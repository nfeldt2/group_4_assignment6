class StrategyCircle extends Circle {
  boolean canShoot;
  
  StrategyCircle(float x, float y, float r) {
    super(x, y, r);
  }

  void move() {
    super.move();
    ruleCheck();
  }

  void ruleCheck() {
    //rule 1: if greater than 40 lose some radius
    //rule 2: if less than 30, gain some radius
    //rule 3: if between 40 and 30, randomly gain or lose radius
    if(millis() >= inceptionTime + 3000){
    if((r > 40)){
    inceptionTime = millis();
    shed(5);
    }
    else if((r < 30)){
    inceptionTime = millis();
    grow(5);
    }
    else if((r >= 30) && (r <= 40)){
    int num = round(random(0, 1));
    if(num % 2 == 0){
    inceptionTime = millis();
    grow(round(random(5, 10)));
    }
    else{
    inceptionTime = millis();
    shed(round(random(5, 10)));
    }
    }
    }
  }
  
  void shed(int num){
    this.r = r - num;
  }
  
  void grow(int num){
    this.r = r + num;
   }
}
