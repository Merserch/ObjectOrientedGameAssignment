class Chicken {
  int hp;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float startingY = 6*(height/7);
  
  Chicken() {
    hp = 1;
    position = new PVector(width/2, startingY);
    velocity = new PVector(0,0);
  }
  
  void display() {
    
    circle(position.x, position.y, 50);
  }
  
  void move() {
    
    if (click == true && clickstop == false) {
      position.y = position.y - 100;
      clickstop = true;
    } else {
      velocity.y = -(position.y - startingY)/50;
      position = position.add(velocity);
      println("Chicken at " + position.y);
      if (position.y >= (startingY - 1) && position.y != startingY) {
        position.y = startingY;
      }
      
    }
  }
}
