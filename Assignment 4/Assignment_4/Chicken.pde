class Chicken {
  PImage faceUp;
  PImage faceDown;
  PImage dead;
  int hp;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float startingY = 6*(height/7);
  float limboY = height/3;
  float size = 50;
  float rBound;
  float lBound;
  float bBound;
  float tBound;

  Chicken() {
    hp = 1;
    position = new PVector(width/2, startingY);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    faceUp = loadImage("chickenUp.png");
    faceDown = loadImage("chickenDown.png");
    dead = loadImage("chickenDead.png");
  }

  void display() {
    fill(255);
    if (gamemode == 1 || gamemode == 4) {
      image(faceUp, position.x, position.y, size, size*1.6);
    } else if (gamemode == 2 || gamemode == 5) {
      image(dead, position.x, position.y, size, size*1.6);
    } else if (gamemode == 3) {
      image(faceDown, position.x, position.y, size, size*1.6);
    }
    rBound = position.x + (size/2);
    lBound = position.x - (size/2);
    bBound = position.y + (size/2);
    tBound = position.y - (size/2);
    
    
    
    
  }

  void moveUp() {

    if (click == true && clickstop == false) {
      position.y = position.y - 147;
      clickstop = true;
    } else {
      velocity.y = -(position.y - startingY)/50;
      position.add(velocity);
      println("Chicken at " + position.y);
      if (position.y >= (startingY - 1) && position.y != startingY) {
        position.y = startingY;
      }
    }
  }

  void reposition() {
    if (position.y > limboY) {
      velocity.y = -(position.y - limboY)/30;
      position.add(velocity);
      println("Chicken at " + position.y);
      if (position.y <= (limboY + 1) && position.y != limboY) {
        position.y = limboY;
      }
    } else if (position.y < limboY) {
      velocity.y = -(position.y - limboY)/30;
      position.add(velocity);
      println("Chicken at " + position.y);
      if (position.y >= (limboY - 1) && position.y != limboY) {
        position.y = limboY;
      }
    } else {
      hp = 0;
      gamemode = 3; // goes from transition to Limbo level
    }
  }

  void moveDown() {
    
    if (click == true && clickstop == false) {
      acceleration.y = 6;
      velocity.add(acceleration);
      clickstop = true;
    } 
    acceleration.y = -0.2;
    velocity.add(acceleration);
    position.add(velocity);
    velocity.mult(0.9);
    println("Chicken at " + position.y);
    
    
    
  }
}
