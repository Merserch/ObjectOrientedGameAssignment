Chicken player;

int gamemode;

void setup() {
  
  size(400,700); //vertical game, mobile feel
  frameRate(90);
  player = new Chicken();
  
  
}

void draw() {
  if (gamemode == 0) {
    // MAIN MENU
    
    
    
  } else if (gamemode == 1) {
    // MAIN GAME
    player.display();
    
    if (player.hp <= 0) {
      player.hp = 0;
      gamemode = 2;
    }
  } else if (gamemode == 2) {
    // DEATH TRANSITION
    
    
    
  } else if (gamemode == 3) {
    // ESCAPE LIMBO
    
    
    if (player.hp <= -1) {
      gamemode = 4;
    }
  } else {
    // GAME OVER
    
    
    
  }
  
}
