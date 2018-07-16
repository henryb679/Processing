public class ObstacleSet {
  //fields

  //x and y positions of the obstacles
  private int xPos;
  private int yPos;
  
  int xSpeed;
  
  //row and col size of obstacles
  private int obstacleWidth;
  private int obstacleHeight;
  
  //x,y spacing between each obstacle object  
  private int obstacleXGap = 50;
  private int obstacleYGap = 50;
  
  //boundard range for obstacles to move 
  private int boundary = 70;

  //updates the time duration so allow the graphics to change state smoothly i.e direction change 
  private int timeUpdate;
  
  //adds the time deplay to the time update
  private int timeDelay;

  //2D array intialised to store the object objects
  private Obstacle[][] obstacleBlock;

  ///constructor
  public ObstacleSet(int obstacleHeight, int obstacleWidth, int startX, int startY, int xSpeed) {
    this.obstacleBlock = new Obstacle[obstacleHeight][obstacleWidth];
    this.xPos = startX;
    this.yPos = startY;
    this.obstacleWidth = obstacleWidth;
    this.obstacleHeight = obstacleHeight;
    
    this.xSpeed = xSpeed;

    this.timeUpdate = 0;
    this.timeDelay = 300;

    this.addObstacle();
  }

  //creates the obstacle objects and stores them into the 2d array
  private void addObstacle() {
    for (int row = 0; row < obstacleHeight; row++) {
      for (int col = 0; col < obstacleWidth; col++) {
        //stores the obstacles into the arrayList
        this.obstacleBlock[row][col] = new Obstacle(this.xPos + col * obstacleXGap, this.yPos + row * obstacleYGap, xSpeed);
      }
    }
  }
  
  //when all obstacle objects are shot, the speed of the new set of obstacles is reset.
  public void reset(boolean speedRevert){
    //checks to see if boolean statement is true or not
    if (speedRevert == true) {
      this.timeDelay = 300;
    }
    //else all the objects are revived
    for (Obstacle[] object: this.obstacleBlock){
      for (Obstacle element : object) {
        element.revive();
      }
    }
  }


  //displays all the obstacle objects in the array
  public void display() {
    //pulls the obstacle objects out of the array 
    for (Obstacle[] object : this.obstacleBlock){
      for (Obstacle element : object){
        
        //calls the display method
        element.display();
      }
    }
  }
   
  //this method checks if the delay time has passed, then updates the positions of them
  public void update() {
    //gets the time in ms
    int time = millis();
    
    //calculates the time difference 
    int timeDiff = this.timeUpdate + this.timeDelay;
    if (time > timeDiff) {
      this.timeUpdate = millis();
      
      //if the object is at the bondary range, the direction of the obstacles change 
      if (this.flipCheck() == true) {
        this.directionFlip();
      }
      
      //if all obstacles are dead it will be set to true
      boolean obstacleStatusCheck = true;
  
      //pulls the obstacle objects out of the 2D array
      for (Obstacle[] object : this.obstacleBlock) {
        for (Obstacle element : object) {
          
          //updates the position of the object
          element.update();
          
          //changes the boolean status of it.
          obstacleStatusCheck = obstacleStatusCheck && !element.alive();
        }
      }
      //if at least one obstacle is alive 
      if (obstacleStatusCheck) {
        //returns false which represents the obstacles are still alive 
        this.reset(false);
      }
    }
  }
  
  //checks to see if the obstacles have reached the boundard of the window and changes the direction and speed of the obstacle
  public boolean flipCheck() {
    int obstacleRightMost = this.getRightmostObstacle().getXPos();
    int obstacleLeftMost = this.getLeftmostObstacle().getXPos();
    
    //if the right most object is at the boundary
    if (obstacleRightMost >= width - boundary) {
      return true;
    }
    
    //if the left most object is at the bondary
    if (obstacleLeftMost <= boundary) {
      return true;
    }
    
    //if condition is not met
    return false;
  }

  //checks to see if obstacles are at the bottom of the window 
  public boolean belowHeight(int h) {
    //returns the lowest y position of a obstacle if its greater or equal to the height of the window 
    return this.getLowest().getYPos() >= h;
  }

  //this method gets the indes of the obstacles 
  public Obstacle[] getObstacle() {
    //creates a new array
    Obstacle[] array = new Obstacle[this.obstacleWidth * this.obstacleHeight];
    
    //sets the inital index to zero
    int index = 0;
    
    //for loop to get the current index of the array
    for (int row = 0; row < this.obstacleWidth; row++) {
      for (int col = 0; col < this.obstacleHeight; col++) {
        array[index] = this.obstacleBlock[col][row];
        index++;
      }
    }

    return array;
  }

  //gets the right most obstacle in the set assuming it is alive 
  public Obstacle getRightmostObstacle() {
    
    //for loop used to find the right most element 
    for (int row = this.obstacleWidth-1; row >= 0; row--) {
      for (int col = 0; col < this.obstacleHeight; col++) {
        if (this.obstacleBlock[col][row].alive()) {
          return this.obstacleBlock[col][row];
        }
      }
    }
    return new Obstacle(0, 0, xSpeed);
  }
  
  //gets the left most obstacle in the set assuming it is alive 
  public Obstacle getLeftmostObstacle() {
    
    //for loop used to find the right most element 
    for (int row = 0; row < this.obstacleHeight; row++) {
      for (int col = 0; col < this.obstacleWidth; col++) {
        if (this.obstacleBlock[col][row].alive()) {
          return this.obstacleBlock[col][row];
        }
      }
    }
    return new Obstacle(0, 0, xSpeed);
  }

 //gets the lowest obstacle in the set assuming it is alive 
  public Obstacle getLowest() {
    
    //for loop used to find the right most element 
    for (int row = this.obstacleHeight - 1; row >= 0; row--) {
      for (int col = 0; col < this.obstacleWidth; col++) {
        if (this.obstacleBlock[row][col].alive()) {
          return this.obstacleBlock[row][col];
        }
      }
    }
    return new Obstacle(0, 0, xSpeed);
  }

  //when the obstacles are at the boundary point, a time delay is added to improve animation appearance while its moving in the oppoiste direction
  private void directionFlip() {
    
    //checks to see if time delay is greater than zero
    if (this.timeDelay > 0) {
      
      //takes away 30 ms from the time delay
      this.timeDelay -= 30;
    }

    for (Obstacle[] object : this.obstacleBlock) {
      for (Obstacle element : object) {
        //changes the direction of the obstacles
        element.directionChange();
        
        //moves the objects down 
        element.downLevel();
      }
    }
  }
}