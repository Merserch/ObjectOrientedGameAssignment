Chicken player;

PImage home;
PImage ending;
PImage playButton;
PImage playHover;
float playX;
float playY;
boolean click = false;
boolean clickstop = false;
ArrayList<Lane> lanes;
ArrayList<Vehicle> cars;
LimboVehicle chaser;
Lane singlelane;
Vehicle car;
int freezeFrame;
boolean win;
float repMult;
int renderDist = 6;

int gamemode;

void setup() {
  imageMode(CENTER);
  noStroke();
  rectMode(CENTER);
  size(400, 700); //vertical game, mobile feel
  frameRate(90);
  playButton = loadImage("Asset 1.png");
  playHover = loadImage("Asset 1 hover.png");
  ending = loadImage("ending.png");
  home = loadImage("homescreen.png");
  playX = playButton.width*2;
  playY = playButton.height *2;
  win = false;
}

void draw() {
  
  
  if (gamemode == 0) {
    // MAIN MENU








    background(0);
    image(home, width/2, height/2);

    //hoverstate detection
    if (mouseX >= (width/2)-(playX/2) &&
      mouseX <= (width/2)+(playX/2) &&
      mouseY >= (height/2)-(playY/2) &&
      mouseY <= (height/2)+(playY/2)) {
      image(playHover, width/2, height/2, playX, playY);

      //clicking while hovering
      if (click && !clickstop) {
        player = new Chicken();         //player
        car = new Vehicle();            //TEMPORARY TESTING VEHICLE!!!!!!!!!!!!!!!!
        lanes = new ArrayList<Lane>();  //create the lanes array
        cars = new ArrayList<Vehicle>();  //create the cars array
        clickstop = true;
        gamemode = 1;                   //start the game
      }
    } else {
      image(playButton, width/2, height/2, playX, playY); //regular play button
      if (click && !clickstop) {
        clickstop = true;
      }
    }
    
    
  } else if (gamemode == 1) {
    // MAIN GAME

    





    //despawning offscreen lanes
    for (int i = 0; i < lanes.size() - 1; i++) {
      Lane part = lanes.get(i);
      if (part.position.y >= 900) {
        lanes.remove(i);
      }
    }

    //spawning upcoming lanes
    if (lanes.size() <= renderDist){
      for (int i = lanes.size(); i <= renderDist; i++) {
        lanes.add(new Lane(i));
      }
    }
    

    //render scene
    background(130); //grey
    //background(20, 255, 100); //green
    for (Lane p : lanes) {
      p.display();
    }
    car.display();
    car.hitDetect();
    player.moveUp();
    player.display();
    
    //when player collides with a vehicle, move to the next gamemode
    if (player.hp <= 0) {
      player.hp = 0; //contingency
      freezeFrame = 90;
      chaser = new LimboVehicle();
      gamemode = 2;
    }
    
    //The win condition is crossing the road, so this is measuring that
    Lane i = lanes.get(lanes.size()-1);
  if (i.position.y >= 14065) {
    win = true;
  }
    
    //win transition
    if (win) {
      if (freezeFrame > 0) {
        fill(255, freezeFrame);
        rect(width/2, height/2, width, height);
        freezeFrame ++;
        if (freezeFrame >= 270) {
          gamemode = 6;
        }
      } else {
        //freezeFrame should only be 0 or -90 while playing, so this forces it to be 1 and start the transition
        freezeFrame = 1;
      }
    }
    
    
  } else if (gamemode == 2) {
    // DEATH TRANSITION









    background(0);
    if (freezeFrame >= 0) {    //freeze frame after impact
      car.display();
      player.display();
      freezeFrame --;
    } else {                  //show chaser and move character to the correct spot
      chaser.display();
      player.display();
      player.reposition();    //has condition to change gamemode once in position
      car.position.x = width/2;
      car.position.y = -10;
    }
    
  } else if (gamemode == 3) {
    // ESCAPE LIMBO






    background(125);
    chaser.display();
    chaser.move();
    chaser.hitDetect();
    player.moveDown();
    player.display();
    
    println("HP at " + player.hp);

    if (player.hp <= -1) {
      freezeFrame = 0;
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
      chaser.display();
      player.display();
      fill(255, freezeFrame*3);
      rect(width/2, height/2, width, height);
      freezeFrame ++;
    } else if (freezeFrame >= 90) {
      background(130);
      player.display();
      player.position.y = player.startingY;
      chaser = null;
      repMult += 0.5;
      car.position.x = width/2;
      car.position.y = 100;
      fill(255);
      rect(width/2, height/2, width, height);
      freezeFrame = -90;
    } else if (freezeFrame <= -1) {
      background(130);
      for (Lane p : lanes) {
      p.display();
    }
      player.display();
      fill(255, -(freezeFrame*3));
      rect(width/2, height/2, width, height);
      freezeFrame ++;
    } else {
      
      player.hp = 1;
      gamemode = 1;
    }
  } else if (gamemode == 5) {
    // GAME OVER
    
    
    
    
    
    
    println("GAME OVER");
    player.display();
    if (freezeFrame < 270) {
      fill(0, freezeFrame);
      rect(width/2, height/2, width, height);
      freezeFrame ++;
    } else {
      background(0);
      reset();
    }
  } else {
    // GAME WON
    
    
    
    background(255);
    image(ending, width/2, height/2);
    
    if (freezeFrame > 0) {
      fill(255, freezeFrame);
      rect(width/2, height/2, width, height);
      freezeFrame --;
    }
    if (click && !clickstop && freezeFrame < 50) {
      clickstop = true;
      reset();
    }
  }
}

void reset() {
  win = false;
  repMult = 0;
  player = null;
  car = null;
  lanes = null;
  cars = null;
  gamemode = 0;
}

void mousePressed() {
  click = true;
}

void mouseReleased() {
  click = false;
  clickstop = false;
  //regardless if clickstop is used, it will be shut off when releasing
}
