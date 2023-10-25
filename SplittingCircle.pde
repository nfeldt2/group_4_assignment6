class SplittingCircle extends Circle {
  boolean canSplit = true; // to ensure it doesn't split continuously\
  boolean fromSplit;
  
  SplittingCircle(float x, float y, float r, boolean fromSplit) {
    super(x, y, r);
    this.fromSplit = fromSplit;
  }
  
  
  boolean checkAndSplit(float otherX, float otherY, float otherSize, float d) {
    if (fromSplit && this.inceptionTime + 2000 > millis()){
      return false;
    } else if (fromSplit) {
      fromSplit = true;
    }
    
    if (canSplit && otherSize * 1.1 < this.circleSize / 2) {
      if (d <= this.r + 60) {
        print("splitting");
        return true;
      }
    }
    return false;
  }
  

  float[] split(float otherX, float otherY, float otherVX, float otherVY) {
    float splitAngle = -atan2(this.y - (otherY + 4 * otherVY), this.x - (otherX + 4 * otherVX)); 
    float newRadius = this.r / sqrt(2); 
    this.r = newRadius;
    this.circleSize = PI * pow(r, 2);
    this.baseSpeed = 6 * pow(.99, circleSize/50);
    float temp_vx = 3 * this.baseSpeed * -cos(splitAngle); // I have no clue why but this ended up working
    float temp_vy = 3 * this.baseSpeed * sin(splitAngle);
    float splitX = this.x + newRadius * cos(splitAngle);
    float splitY = this.y + newRadius * sin(splitAngle);
    this.fromSplit = true;
    
   
    return new float[]{splitX, splitY, newRadius, temp_vx, temp_vy};
     
  }
}
