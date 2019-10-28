int sizeX = 2000;
int sizeY = 2000;
int[] direction = new int[100];
int segmentCounter = 0;
double[] turnX = new double[100];
double[] turnY = new double[100];
bodySegment[] body = new bodySegment[100];
firstSegment head = new firstSegment(sizeX/2, sizeY/2);
double xPosHead = sizeX/2;
double yPosHead = sizeY/2;
double[] xPosSegments = new double[100];
double[] yPosSegments = new double[100];
int xPosFruit = (int)(Math.random()*800)+100;
int yPosFruit = (int)(Math.random()*800)+100;
fruit theFruit = new fruit(xPosFruit, yPosFruit);
char keyHold = 'm';
int result = 0;
void setup(){
  background(0);
  size(2000,2000);
  head.show();
  theFruit.show();
  for(int i = 0; i < turnX.length; i++){
    turnX[i] = 0;
    turnY[i] = 0;
  }
}
void draw(){
  for(int i = 1; i < segmentCounter; i++){
    if(direction[i] == direction[1]){
      result += 1;
    }
  }
  if(result == segmentCounter){
    for(int i = 0; i < turnX.length; i++){
      turnX[i] = 0;
      turnY[i] = 0;
    }
  }
  background(0);
  head.move();
  head.show();
  theFruit.show();
  if(xPosHead > xPosFruit - 25 && xPosHead < xPosFruit + 25 && yPosHead > yPosFruit - 25 && yPosHead < yPosFruit + 25){
    theFruit.relocate();
    segmentCounter += 1;
    if(direction[segmentCounter-1] == 1){
      body[segmentCounter] = new bodySegment(xPosSegments[segmentCounter-1], yPosSegments[segmentCounter-1] + 50, segmentCounter, direction[segmentCounter-1]); 
    } else if(direction[segmentCounter-1] == 3) {
      body[segmentCounter] = new bodySegment(xPosSegments[segmentCounter-1], yPosSegments[segmentCounter-1] - 50, segmentCounter, direction[segmentCounter-1]);
    } else if(direction[segmentCounter-1] == 2) {
      body[segmentCounter] = new bodySegment(xPosSegments[segmentCounter-1] + 50, yPosSegments[segmentCounter-1], segmentCounter, direction[segmentCounter-1]);
    } else if(direction[segmentCounter-1] == 4) {
      body[segmentCounter] = new bodySegment(xPosSegments[segmentCounter-1] - 50, yPosSegments[segmentCounter-1], segmentCounter, direction[segmentCounter-1]);
    }
  }
  for(int i = 1; i <= segmentCounter; i++){
      body[i].show();
      body[i].move();
  }
  if(keyPressed){
    if(key != keyHold){
      if(key == 'w'){
        keyHold = 'w';
        head.turn();
        direction[0] = 1;
      }
      if(key == 'a'){
        keyHold = 'a';
        head.turn();
        direction[0] = 2;
      }
      if(key == 's'){
        keyHold = 's';
        head.turn();
        direction[0] = 3;
      }
      if(key == 'd'){
        keyHold = 'd';
        head.turn();
        direction[0] = 4;
      }
    }
  }
}
class firstSegment {
  double myX,myY;
  int mySize = 50;
  int mySpeed = 5;
  int tracker = 0;
  int tracker2 = 0;
  int debug = 0;
  firstSegment(double x, double y){
    myY = y;
    myX = x;
  }
  void turn(){
    tracker = direction[1];
    tracker2 = 0;
    debug = 0;
    for(int i = 1; i <= segmentCounter; i++){
      if(direction[i] != tracker){
        tracker2 = 1;
        for(int g = 0; i < turnX.length; i++){
          if(debug == 0){
            if(turnX[i] == 0){
              turnX[i] = myX;
              turnY[i] = myY;
              debug = 1;
            }
          }
        }
      }
    }
    if(tracker2 == 0){
      turnX[0] = myX;
      turnY[0] = myY;
    }
  }
  void show(){
    fill(255);
    ellipse((float)myX, (float)myY, (float)mySize, (float)mySize);
  }
  void move(){
    if(direction[0] == 1){
      myY = myY - mySpeed;
    } else if(direction[0] == 3) {
      myY = myY + mySpeed;
    } else if(direction[0] == 2) {
      myX = myX - mySpeed;
    } else if(direction[0] == 4) {
      myX = myX + mySpeed;
    }
    xPosHead = myX;
    yPosHead = myY;
    xPosSegments[0] = myX;
    yPosSegments[0] = myY;
  }
}
class fruit {
  int myX, myY;
  int mySize = 20;
  fruit(int x, int y){
    myY = y;
    myX = x;
  }
  void show(){
    fill(255,0,0);
    ellipse(myX, myY, mySize, mySize);
  }
  void relocate(){
    fill(0);
    ellipse(myX, myY, mySize, mySize);
    fill(255,0,0);
    myX = (int)(Math.random()*800)+100;
    myY = (int)(Math.random()*800)+100;
    yPosFruit = myY;
    xPosFruit = myX;
  }
} 
class bodySegment{
  double myX,myY;
  int mySize = 50;
  int mySpeed = 5;
  int mySpot;
  int myPointing;
  bodySegment(double x, double y, int spot, int pointing){
    myY = y;
    myX = x;
    mySpot = spot;
    myPointing = pointing;
    direction[mySpot] = myPointing;
  }
  void show(){
    fill(255);
    ellipse((float)myX, (float)myY, (float)mySize, (float)mySize);
  }
  void move(){
    myPointing = direction[mySpot];
    if(direction[mySpot] == 1){
      myY = myY - mySpeed;
    } else if(direction[mySpot] == 3) {
      myY = myY + mySpeed;
    } else if(direction[mySpot] == 2) {
      myX = myX - mySpeed;
    } else if(direction[mySpot] == 4) {
      myX = myX + mySpeed;
    }
    xPosSegments[mySpot] = myX;
    yPosSegments[mySpot] = myY;
    for(int i = 0; i < turnX.length; i++){
      if(myX == turnX[i] && myY == turnY[i]){
        direction[mySpot] = direction[mySpot-1];
        myPointing = direction[mySpot-1];
        keyHold = 'z';
      } else {
        direction[mySpot] = myPointing;
      }
    }
  }
}
