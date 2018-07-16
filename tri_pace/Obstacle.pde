public class Obstacle {
  //fields
  
  //x and y positions of the obstacle
  private int xPos;
  private int yPos;
  
  //intial x and y positons 
  private int xPosInital;
  private int yPosInital;
  
  //speed of obstacles
  private final int xSpeed;
  //private final int xSpeed;
  private final int ySpeed = 10;
  
  //boolean statements
  private boolean alive = true;
  private boolean moveMostRight = true;

  //constructor 
  public Obstacle(int x, int y, int xSpeed) {
    this.xPos = x;
    this.yPos = y;
    this.xPosInital = x;
    this.yPosInital = y;
    
    this.xSpeed = xSpeed;
  }

  //displays the obstacles in the window
  public void display() {
    if (this.alive) {
      noStroke();
      fill(#17E3E5);
      
      //rect(this.xPos, this.yPos, 30, 30);
      
      //draw triangle
      triangle(this.xPos, this.yPos, this.xPos+20, this.yPos+40, this.xPos+40, this.yPos);
    }
  }

  //when reset, the x and y positions are set back to the original positions 
  private void reset() {
    this.xPos = this.xPosInital;
    this.yPos = this.yPosInital;
  }

  //returns when the player has lost all their lives
  public void playerDead() {
    this.alive = false;
  }

  public void directionChange() {
    this.moveMostRight = !this.moveMostRight;
  }

  public void update() {
    if (this.moveMostRight == true) {
      this.xPos += xSpeed;
    } else {
      this.xPos -= xSpeed;
    }
  }
  
  //moves the obstacles down when it hits a boundary
  public void downLevel() {
    this.yPos += ySpeed;
  }
  
  //if obstacles are alive, the status is changed
  public void revive() {
    this.reset();
    this.alive = true;
  }

  //gets the current x position of the obstacle
  public int getXPos() {
    return this.xPos;
  }

 //gets the current y position of the obstacle
  public int getYPos() {
    return this.yPos;
  }
    
  //returns the alive status of the obstacles
  public boolean alive() {
    return this.alive;
  }
}