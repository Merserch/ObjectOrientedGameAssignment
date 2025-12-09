class LimboVehicle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PImage vehicleLimbo;
  float carWidth = 380;
  float carHeight = 380;
  float rBound;
  float lBound;
  float bBound;
  float tBound;
  
  
  
  LimboVehicle() {
    position = new PVector(width/2, -100);
    velocity = new PVector(0,1 + repMult);
    vehicleLimbo = loadImage("vehicleLimbo.png");
  }
  
  void display() {
    rBound = position.x + (carWidth/2);
    lBound = position.x - (carWidth/2);
    bBound = position.y + (carHeight/2.3);
    tBound = position.y - (carHeight/2);
    
    image(vehicleLimbo, position.x, position.y, carWidth, carHeight);
  }
  
  void move() {
    position.add(velocity);
  }
  
  void hitDetect() {
    //hit detection between the individual car and the player.
    position.y = position.y;
    if (rBound >= player.lBound &&
        lBound <= player.rBound &&
        bBound >= player.tBound &&
        tBound <= player.bBound) {
      player.hp --;
    }
  }
  
  
}
