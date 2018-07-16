import java.util.ArrayList;

public class Boss_bullet {
  //fields
  //x and y positions of the bullet
  private int xPos;
  private int yPos;

  //y axis speed of bullet
  public int ySpeed = 8;

  //boolean statements
  private boolean alive;


  //objects
  private Boss parent;

  //contructor
  public Boss_bullet(Boss parent) {
    this.xPos = 0;
    this.yPos = 0;

    this.parent = parent;

    this.alive = false;
  }

  //updates the position of the obstacles and does regular check of collisions
  public void update() {
    if (this.alive == true) {
      this.yPos += this.ySpeed;

      //draws bullets with rounded edges 
      noStroke();
      fill(#F0ED18);
      rect(this.xPos, this.yPos, 8, 20);
    }

    if (this.yPos > 750) {
      this.alive = false;
    }
  }

  //if player is not hit, the parent of the obstacle position is replaced. 
  public void reform() {
    if (this.alive == false) {
      this.xPos = this.parent.getXPos();
      this.yPos = this.parent.getYPos();
      this.alive = true;
    }
  }

  //returns the boolean statement if obstacles are alive or not
  public boolean alive() {
    return this.alive;
  }
}