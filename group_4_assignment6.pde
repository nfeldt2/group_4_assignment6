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
}

void draw() {
 background(255);
 for (Circle c : circles) {
   c.growOnTouchingFood(myFood);
   c.move();
   c.display();
 }
 reDrawFood();
 
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
    Circle c1 = circles.get(i);
    for (int j = circles.size() - 1; j >= 0; j--) {
      if (i == j) continue;
      
      Circle c2 = circles.get(j);
      float d = dist(c1.x, c1.y, c2.x, c2.y);
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
