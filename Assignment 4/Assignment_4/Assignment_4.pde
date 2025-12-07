Chicken player;
PImage playButton;
PImage playHover;
float playX;
float playY;
boolean click = false;
boolean clickstop = false;

int gamemode;

void setup() {
  imageMode(CENTER);
  size(400,700); //vertical game, mobile feel
  frameRate(90);
  playButton = loadImage("Asset 1.png");
  playHover = loadImage("Asset 1 hover.png");
  playX = playButton.width*2;
  playY = playButton.height *2;
  
  
}

void draw() {
  if (gamemode == 0) {
    // MAIN MENU
    background(0);
    
    //hoverstate detection
    if (mouseX >= (width/2)-(playX/2) &&
        mouseX <= (width/2)+(playX/2) &&
        mouseY >= (height/2)-(playY/2) &&
        mouseY <= (height/2)+(playY/2)) {
          image(playHover, width/2, height/2, playX, playY);
          
          //clicking while hovering
          if (click == true) {
            player = new Chicken();
            clickstop = true;
            gamemode = 1;
          }
          
        } else {
          image(playButton, width/2, height/2, playX, playY);
        }
  } else if (gamemode == 1) {
    // MAIN GAME
    background(255);
    player.display();
    player.move();
    
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

void mousePressed() {
  click = true;
}

void mouseReleased() {
  click = false;
  clickstop = false;
}
