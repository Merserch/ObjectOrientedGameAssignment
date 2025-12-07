class Chicken {
  int hp;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float startingY = 6*(height/7);
  float limboY = height/7;
  float size = 50;
  float rBound;
  float lBound;
  float bBound;
  float tBound;

  Chicken() {
    hp = 1;
    position = new PVector(width/2, startingY);
    velocity = new PVector(0, 0);
  }

  void display() {
    fill(255);
    circle(position.x, position.y, size);
    rBound = position.x + (size/2);
    lBound = position.x - (size/2);
    bBound = position.y + (size/2);
    tBound = position.y - (size/2);
    
    
    
    
  }

  void moveUp() {

    if (click == true && clickstop == false) {
      position.y = position.y - 150;
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

  void reposition() {
    if (position.y > limboY) {
      velocity.y = -(position.y - limboY)/30;
      position = position.add(velocity);
      println("Chicken at " + position.y);
      if (position.y <= (limboY + 1) && position.y != limboY) {
        position.y = limboY;
      }
    } else if (position.y < limboY) {
      velocity.y = (position.y - limboY)/30;
      position = position.add(velocity);
      println("Chicken at " + position.y);
      if (position.y >= (limboY - 1) && position.y != limboY) {
        position.y = limboY;
      }
    } else {
      gamemode = 3; // goes from transition to Limbo level
    }
  }

  void moveDown() {
    println("Chicken at " + position.y);
  }
}
