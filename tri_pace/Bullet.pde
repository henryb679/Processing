import java.util.ArrayList;

public class Bullet {
  //fields
  //x and y positions of the bullet
  private int xPos;
  private int yPos;

  //y axis speed of bullet
  public int ySpeed = 25;

  //boolean statements
  private boolean alive;

  //objects
  private Triangle parent;

  //creates new arrayList to store obstacles that are succesfully hit by the bullet/s
  private ArrayList<Obstacle> obstacle;

  //contructor
  public Bullet(Triangle parent) {
    this.xPos += 40;
    this.yPos -= 60;

    this.parent = parent;
    this.alive = false;

    //initalsises the arrayList
    this.obstacle = new ArrayList<Obstacle>();
  }

  //updates the position of the obstacles and does regular check of collisions
  public void update() {
    if (this.alive == true) {
      this.yPos -= this.ySpeed;

      this.checkCollison();

      //draws bullets with rounded edges 
      noStroke();
      fill(#E52C17);
      rect(this.xPos+40, this.yPos-60, 8, 20, 5, 5, 5, 5);
    }

    if (this.yPos < -10) {
      this.alive = false;
    }
  }

  //if obstacle is not hit, the parent of the obstacle position is replaced. 
  public void reform() {
    if (this.alive == false) {
      this.xPos = this.parent.getXPos();
      this.yPos = this.parent.getYPos();
      this.alive = true;
    }
  }

  //adds obstacles to arrayList to store to allow collision detection to take place 
  void addObstacle(Obstacle toAdd) {
    this.obstacle.add(toAdd);
  }

  //checks to see if collision between a obstacle object and bullet object has taken place
  public void checkCollison() {
    for (Obstacle current : obstacle) {
      if (current.alive() == true) {
        if (this.bulletTouchesObstacle(current) == true) {
          current.playerDead();
          this.alive = false;
          this.parent.addToScore(50);
        }
      }
    }
  }

  //checks if bullet touches the obstacle
  private boolean bulletTouchesObstacle(Obstacle check) {

    // tollerance added to ensure edges of triangle objects are accepted
    int tolerance = 8;

    int checkXPos = check.getXPos();
    int checkYPos = check.getYPos();

    //checks left side of obstacle
    boolean left = this.xPos >= (checkXPos - 16 - tolerance);

    //checks right side of obstacle 
    boolean right = this.xPos <= (checkXPos + 16 + tolerance);

    ////checks top side of obstacle 
    boolean top = this.yPos >= (checkYPos - 23 + tolerance);

    //checks bottom side of obstacle 
    boolean bottom = this.yPos <= (checkYPos + 23 + tolerance);

    return left && right && top && bottom;
  }

  //returns the boolean statement if obstacles are alive or not
  public boolean alive() {
    return this.alive;
  }
}