class ExplodingCircle extends Circle {
  boolean exploded = false;
  ArrayList<Circle> explodedCircles;

  ExplodingCircle(float x, float y, float r) {
    super(x, y, r);
    explodedCircles = new ArrayList<Circle>();
  }
  
  ArrayList<Circle> getExplodedCircles() {
    return explodedCircles;
  }

  void move() {
    super.move();
    if (!exploded && r > 75) {
      explode();
      exploded = true;
    }
  }

  void explode() {
    int numSmallerCircles = 8;
    float smallerRadius = r/4;

    for (int i = 0; i < numSmallerCircles; i++) {
      float angle = TWO_PI/numSmallerCircles*i;
      float offsetX = smallerRadius*cos(angle);
      float offsetY = smallerRadius*sin(angle);
      float smallerX = x + offsetX;
      float smallerY = y + offsetY;
      float smallerVX = 2*cos(angle);
      float smallerVY = 2*sin(angle);

      Circle smallerCircle = new Circle(smallerX, smallerY, smallerRadius);
      smallerCircle.vx = smallerVX;
      smallerCircle.vy = smallerVY;
      explodedCircles.add(smallerCircle);
    }
  }
}
