class Vehicle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float carWidth = 200;
  float carHeight = 70;
  float rBound;
  float lBound;
  float bBound;
  float tBound;
  
  
  Vehicle() {
    position = new PVector(width/2, 100);
    velocity = new PVector(0,0);
    
  }
  
  void display() {
    rBound = position.x + (carWidth/2);
    lBound = position.x - (carWidth/2);
    bBound = position.y + (carHeight/2);
    tBound = position.y - (carHeight/2);
    
    fill(255,0,0);
    rect(position.x, position.y, carWidth, carHeight);
    
    if (rBound >= player.lBound &&
        lBound <= player.rBound &&
        bBound >= player.tBound &&
        tBound <= player.bBound ) {
      player.hp -= 1;
    }
  }
  
  void move() {
    position.y = position.y;
    
  }
  
  
}
