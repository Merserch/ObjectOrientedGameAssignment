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
        player = new Chicken();
        car = new Vehicle(); //TEMPORARY TESTING VEHICLE!!!!!!!!!!!!!!!!
        //Unfortunately, I'm leaving this in. I tried but don't have time to
        //add the moving vehicles attached to each lane. 
        lanes = new ArrayList<Lane>();  //create the lanes array
        for (int i = 0; i <90; i++) {   //spawn all lanes
          lanes.add(new Lane(i));
          println("there are " + lanes.size() + " lanes.");
        }
        clickstop = true;
        gamemode = 1;
      }
    } else {
      image(playButton, width/2, height/2, playX, playY);
      if (click && !clickstop) {
        clickstop = true;
      }
    }
    
    
  } else if (gamemode == 1) {
    // MAIN GAME

    






    //render scene
    background(20, 255, 100);
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
    if (freezeFrame >= 0) {
      car.display();
      player.display();
      freezeFrame --;
    } else {
      chaser.display();
      player.display();
      player.reposition();
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
      background(255);
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
      background(255);
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
      repMult = 0;
      gamemode = 0;
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
      win = false;
      clickstop = true;
      repMult = 0;
      gamemode = 0;
    }
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
