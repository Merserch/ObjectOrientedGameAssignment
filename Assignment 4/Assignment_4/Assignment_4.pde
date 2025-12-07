Chicken player;

PImage playButton;
PImage playHover;
float playX;
float playY;
boolean click = false;
boolean clickstop = false;
ArrayList<Lane> lanes;
Vehicle car;
int freezeFrame;

int gamemode;

void setup() {
  imageMode(CENTER);
  rectMode(CENTER);
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
            car = new Vehicle(); //TEMPORARY TESTING VEHICLE!!!!!!!!!!!!!!!!
            clickstop = true;
            gamemode = 1;
          }
          
        } else {
          image(playButton, width/2, height/2, playX, playY);
        }
  } else if (gamemode == 1) {
    // MAIN GAME
    
    
    
    
    
    background(255);
    
    player.moveUp();
    player.display();
    
    
    car.move();
    car.display();
    //when player collides with a vehicle, move to the next gamemode
    if (player.hp <= 0) {
      player.hp = 0; //contingency
      freezeFrame = 90;
      gamemode = 2;
    }
    
  } else if (gamemode == 2) {
    // DEATH TRANSITION
    
    
    
    
    
    
    
    
    
    background(0);
    
    
    if (freezeFrame >= 0) {
      car.display();
      freezeFrame --;
    } else {
      player.reposition();
      car.position.x = width;
      car.position.y = 700;
    }
    player.display();
    
  } else if (gamemode == 3) {
    // ESCAPE LIMBO
    
    
    
    
    
    
    background(125);
    
    player.moveDown();
    player.display();
    car.move();
    car.display();
    println("HP at " + player.hp);
    
    if (player.hp <= -1) {
      gamemode = 5;
    }
    if (player.position.y >= height) {
      freezeFrame = 1;
      gamemode = 4;
    }
  } else if (gamemode == 4) {
    //REVIVE TRANSITION
    
    
    println("freezing " + freezeFrame);
    
    
    if (freezeFrame > 0 && freezeFrame < 90) {
      background(125);
      player.display();
      fill(255, freezeFrame*3);
      rect(width/2, height/2, width, height);
      freezeFrame ++;
    } else if (freezeFrame >= 90) {
      background(255);
      player.display();
      player.position.y = player.startingY;
      car.position.x = width/2;
      car.position.y = 100;
      fill(255);
      rect(width/2, height/2, width, height);
      freezeFrame = -90;
    } else if (freezeFrame <= -1) {
      background(255);
      player.display();
      fill(255, -(freezeFrame*3));
      rect(width/2, height/2, width, height);
      freezeFrame ++;
    } else {
      player.hp = 1;
      gamemode = 1;
    }
    
    
    
    
    
  } else {
    // GAME OVER
    println("GAME OVER");
    player.display();
    
    
    
    
    
  }
  
}

void mousePressed() {
  click = true;
}

void mouseReleased() {
  click = false;
  clickstop = false;
  //regardless if clickstop is used, it will be shut off when releasing
}
