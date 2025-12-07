class Lane {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PImage lane;
  int index;
  int spawnY;
  
  
  Lane(int i) {
    spawnY = i;
    lane = loadImage("lane1.png");
    position = new PVector(width/2, -12750 + (spawnY*150));
    velocity = new PVector(0,0);
  }
  
  void display() {
    image(lane, position.x, position.y, 400, 150);
    velocity.y = -(player.position.y - player.startingY)/50;
      position.add(velocity);
      println("Lane at " + position.y);
      if (player.position.y >= (player.startingY - 1) && player.position.y != player.startingY) {
        position.y = player.startingY;
      }
  }
  
  
  
}
