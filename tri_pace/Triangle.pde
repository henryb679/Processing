public class Triangle {
  //fields
  
  // x and y positions of the triangle piece
  private int xPos = width/2;
  private int yPos;

  //stores the score and lives 
  private int score;
  public int lives;
  
  //creates a new bullet child to initalsise and track the bullets movements
  private Bullet child;
 
  //constructor
  public Triangle() {
    this.child = new Bullet(this);
  }


  //draws the triangle player on the window 
  private void display(int posX, int posY) {
    strokeWeight(8);
    stroke(#00B24F);
    noFill();
    triangle(posX, posY, posX+40, posY-60, posX+80, posY);
    
  }
   
  //allows the triangle to move right
  public void moveRight(){
    this.xPos += 20;
    
    //prevents the traingle from getting to the edge of the window 
    if(this.xPos == width-100){
      this.xPos -= 20;
    }
    return;
  }
  
  //allows the triangle to move left
  public void moveLeft(){
    this.xPos -= 20;
    
   //prevents the traingle from getting to the edge of the window 
    if(this.xPos <= 30){
      this.xPos += 20;
    }
    return;
  }
  
  //shoots the bullets when the user presses the space bar
  void shoot() {
    this.child.reform();
  }


  //update and changes the position of the triangle according to what the location it is in
  public void update() {
    //updates the bullet position
    this.child.update();
    
    this.yPos = height - 50;
    this.display(this.xPos, this.yPos);
   
  }

  // adds every object the player successfully hits 
  public void addObstacle(Obstacle[] obstacle) {
    for (Obstacle element : obstacle) {
      this.child.addObstacle(element);
    }
  }

  //gets the current score they have 
  public int getScore() {
    return this.score;
  }

  //gets the number of lives the user has 
  public int getLives() {
    return this.lives;
  }

  //reduces the players life by one each time they get hit or fail to hit the obstacles in time.
  public void kill() {
    this.lives--;
  }

  //adds the score for each obstacle object they hit 
  public void addToScore(int score) {
    this.score += score;
  }

  //gets y position of triangle
  public int getXPos() {
    return this.xPos;
  }

  //gets y position of triangle
  public int getYPos() {
    return this.yPos;
  }
}