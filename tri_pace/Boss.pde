public class Boss {
  //fields

  // x and y positions of the Boss piece
  private int xPos = width/2;
  private int yPos;
  private int boundary = 80;

  //creates a new bullet child to initalsise and track the bullets movements
  private Boss_bullet child;

  //speed of boss's x movement 
  private int xSpeed = 2;

  //checks to see if collision has been made or not
  public boolean check;

  //creates new Boss object 
  public Boss() {
    this.child = new Boss_bullet(this);
  }


  private void display(int posX, int posY) {
    fill(#EF6FE5);
    noStroke();
    rect(posX, posY, 50, 20);

  }

  //shoots the bullets 
  void shoot() {
    this.child.reform();
  }

  //update and changes the position of the Boss according to what the location it is in
  public void update() {
    //updates the bullet position
    this.child.update();

    this.xPos += xSpeed;

    if (this.xPos > width-(boundary+35)) {
      xSpeed -= 2;
    }

    if (this.xPos < boundary) {
      xSpeed += 3;
    }

    this.yPos = 80;

    //ensure the boss is alive
    this.child.reform();

    //displays the boss object on the screen
    this.display(this.xPos, this.yPos);
  }  

  //gets y position of Boss
  public int getXPos() {
    return this.xPos;
  }

  //gets y position of Boss
  public int getYPos() {
    return this.yPos;
  }

  //boss bullet positions
  public int xPosBullet() {
    return this.child.xPos;
  }

  public int yPosBullet() {
    return this.child.yPos;
  }

  //collision check
  public boolean collisionWithPlayer(int playerX) {
    //second half of triangle
    if (this.child.xPos >= playerX && this.child.xPos <= playerX + 80) {
      if (this.child.yPos == 600)
        return true;
    }
    return false;
  }

}