//tri_pace main code

//variables

//inital x and y pos for obstacles
int obstacleXPos = 150;
int obstacleYPos = 150;

//the row and col are different to make the game more different each time
int obstacleRowCol = (int)(random(4, 7));

//initalise object
ObstacleSet obstacle;
Triangle player;
Boss boss;

//allows a font to be loaded into processing
PFont defaultFont;

//boolean
boolean gameStart = false;
boolean menu = true;

boolean reset = true;

void setup() {
  //size of window
  size(600, 800);

  //background color
  background(#1E264C);

  frameRate(60);
  //pixelDensity(displayDensity());
  smooth();

  //loads the default font into the program
  defaultFont = loadFont("AgencyFB.vlw");

  //creates the obstacles 

  obstacle = new ObstacleSet(1, 1, obstacleXPos, obstacleYPos, 6);

  //calls the new player to set up the score board and lives counter
  player = new Triangle();

  boss = new Boss();

  player.addObstacle(obstacle.getObstacle());
}

void draw() {
  //background color
  background(#1E264C);

  //add menu screen
  if (menu == true) {
    if (gameStart == false) {

      float textWidth = (width/4)+10;
      float textHeight = height/2;

      noFill();
      stroke(#EF6FE5);
      strokeWeight(10);
      triangle(200, 250, 300, 100, 400, 250);    


      fill(#ffffff);
      textAlign(CENTER);
      textFont(defaultFont, 80);
      text("TRI_PACE", width/2, height/2 - 60);

      textAlign(LEFT);
      textFont(defaultFont, 40);
      //text("PRESS <S> TO START", textWidth, textHeight+30);
      text("PRESS <1> TO START L1", textWidth, textHeight+30);
      text("PRESS <2> TO START L2", textWidth, textHeight+80);

      text("PRESS <ESC> TO QUIT", textWidth, textHeight + 130);

      text("CONTROLS", textWidth/4, textHeight + 230);
      textFont(defaultFont, 20);
      fill(#00B24F);
      text("TO MOVE", textWidth/4, textHeight + 270);
      fill(#ffffff);
      text("RIGHT ARROW -> ", textWidth/4, textHeight + 300);
      text("<- LEFT ARROW ", textWidth/4, textHeight + 330);

      fill(#E52C17);
      text("TO SHOOT", textWidth+50, textHeight + 270);
      fill(#ffffff);
      text("SPACE", textWidth+50, textHeight + 300);
      this.player.lives = 5;
      start();
    }
  }
  //checks to see if menu has been shown or not
  if (menu == false) {
    if (gameStart == true) {
      //if game has not been started    
      if (player.getLives() > 0) {
        gameInterface();
        obstacle.display();
        obstacle.update();
        player.update();
        boss.update();

        //if obstacles at the bottom of the window a life is lost
        if (obstacle.belowHeight(625)) {
          player.kill();
          obstacle.reset(true);
        }

        int playerXPos = this.player.getXPos();
        if (boss.collisionWithPlayer(playerXPos)) {
          player.kill();
        }
      } 

      //when the game is over 
      if (player.getLives() <= 0) {
        fill(#FFFFFF);
        textAlign(CENTER);
        textFont(defaultFont, 40);
        text("TRI_PACE", width/2, height/2 - 60);

        textFont(defaultFont, 20);
        text("GAME OVER", width/2, height/2 + 10);
        text("SCORE " + player.getScore(), width/2, height/2 + 30);
        text("PRESS R TO GET BACK TO THE MENU", width/2, height/2 + 100);

        // the triangle shape form is changed through translation - moving shape by constant distance 
        translate(width/2, height/2);

        //rotates the triangle at the inital frame rate +2 to reduce the speed of the motion 
        rotate(radians(frameCount+2));

        noFill();
        stroke(random(0, 255), random(0, 255), random(0, 255));

        //co-ordiantes and dimensions of the moving triangle
        strokeWeight(10);
        triangle(50, 300, 150, 150, 250, 300);
        reset = false;
        restart();
      }
    }
  }
}

//Game controls

//logs the keys pressed in the game
void keyPressed() {
  if (gameStart == true) {
    if (keyCode == ' ') {
      player.shoot();
    }

    //moves the player to the right
    if (keyCode == RIGHT) {
      player.moveRight();
    }

    //moves the player to the left
    if (keyCode == LEFT) {
      player.moveLeft();
    }

    //quit game
    if (keyCode == ESC) {
      exit();
    }
  }
}


//this draws the text for the in game experience 
void gameInterface() {  
  //score tracker text
  fill(#FFFFFF);
  textFont(defaultFont, 20);
  text("SCORE " + player.getScore(), 50, 40);

  //title of game
  fill(#FFFFFF);
  textFont(defaultFont, 20);
  text("TRI_PACE ", 270, 40);

  //live tracker text
  fill(#FFFFFF);
  textFont(defaultFont, 20);
  text("LIVES " + player.getLives(), 500, 40);

  //draw boundary
  fill(#FFFFFF); 
  rect(0, 650, 2500, 0.5);
}

//method used to start the game
void start() {
  if (keyCode == '1') {
    obstacleRowCol = (int)(random(2, 4));

    obstacle = new ObstacleSet(obstacleRowCol, obstacleRowCol, obstacleXPos, obstacleYPos, 6);
    player.addObstacle(obstacle.getObstacle());
    gameStart = true;
    menu = false;
  }
  
  if (keyCode == '2') {
    obstacleRowCol = (int)(random(4, 7));

    obstacle = new ObstacleSet(obstacleRowCol, obstacleRowCol, obstacleXPos, obstacleYPos, 10);
    player.addObstacle(obstacle.getObstacle());
    gameStart = true;
    menu = false;
  }
  
}
//method used to ensure the game can be restarted 
void restart() {
  if (keyCode == 'R') {
    menu = true;
    gameStart = false;
    reset = true;

    //resets the lives + score
    this.player.lives = 5;
    this.player.score = 0;

    obstacle = new ObstacleSet(1, 1, obstacleXPos, obstacleYPos, 6);
    player.addObstacle(obstacle.getObstacle());
    
  }
}