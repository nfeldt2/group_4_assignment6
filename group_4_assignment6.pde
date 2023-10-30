Food myFood;
int sizeX;
int sizeY;
ArrayList<Circle> circles;

void setup() {
  size(1000, 1000);
  myFood = new Food(width/5, height/5, 80);
  sizeX = width/5;
  sizeY = height/5;
  for (int i = 0; i < sizeX; i++) {
    for (int j = 0; j < sizeY; j++) {
      if (myFood.food.get(i).get(j)) {
        fill(0);
        rect(i * (width / sizeX), j * (height / sizeY), width / sizeX, height / sizeY);
      }
    }
  }
  circles = new ArrayList<Circle>();
  for (int i = 0; i < 10; i++) { 
    circles.add(new Circle(random(width), random(height), random(5, 15)));
  }
  // add y'alls circle type after
  circles.add(new SplittingCircle(random(width), random(height), 40, false));
  circles.add(new StrategyCircle(random(width), random(height), random(10, 60)));

  ExplodingCircle explodingCircle = new ExplodingCircle(random(width), random(height), 70);
  circles.add(explodingCircle);
}

void draw() {
 background(255);
 reDrawFood();

 ArrayList<Circle> toAdd = new ArrayList<Circle>();
 ArrayList<Circle> toRemove = new ArrayList<Circle>();

 for (Circle c : circles) {
   c.growOnTouchingFood(myFood);
   c.move();
   c.display();

   if(c instanceof ExplodingCircle && ((ExplodingCircle) c).exploded) {
     ExplodingCircle temp = (ExplodingCircle) c;
     toAdd.addAll(temp.getExplodedCircles());
     toRemove.add(c);
   }
 }

 circles.removeAll(toRemove);
 circles.addAll(toAdd);
 
 checkForEngulfing();
}

void reDrawFood(){
  myFood.update();
  for (int i = 0; i < sizeX; i++) {
    for (int j = 0; j < sizeY; j++) {
      if (myFood.food.get(i).get(j)) {
        fill(0);
        rect(i * (width / sizeX), j * (height / sizeY), width / sizeX, height / sizeY);
      }
    }
  }
}

void checkForEngulfing() {
  int[] toRemove={};
  for (int i = circles.size() - 1; i >= 0; i--) {
    Boolean splittingCircle = false;
    Circle c1;
    if (circles.get(i) instanceof SplittingCircle) {
      c1 = (SplittingCircle) circles.get(i); //cast to Splitting circle
      splittingCircle = true;
    } else {
      c1 =  circles.get(i);
    }
    
    for (int j = circles.size() - 1; j >= 0; j--) {
      if (i == j) continue;
      
      Circle c2 = circles.get(j);

      float d = dist(c1.x, c1.y, c2.x, c2.y);
      if (splittingCircle) {
        boolean splitCirc = ((SplittingCircle) c1).checkAndSplit(c2.x, c2.y, c2.circleSize, d);
        if (circles.get(j) instanceof SplittingCircle) {
          splitCirc = false; // splitting circle supremacy
        }
        if (splitCirc) {
          float[]params = ((SplittingCircle) c1).split(c2.x, c2.y, c2.vx, c2.vy);
          SplittingCircle temp = new SplittingCircle(params[0], params[1], params[2], true);
          temp.vx = params[3];
          temp.vy = params[4];
          circles.add(temp);
        }
      }
      if (c1.r > 1.1 * c2.r && d < 0.9 * c1.r) {
        toRemove = append(toRemove, j);
        c1.engulf(c2.circleSize);
      }
    }
  }
  for (int index : toRemove) {
    circles.remove(index);
  }
}
