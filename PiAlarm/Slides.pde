class Slide1 {
  float timeX;
  float timeY = 480/2;
  boolean rightPressed; // when right button is pressed
  boolean leftPressed; // when left button is pressed
  String theTime; // string containing the complete time for the pi Alarms main page
  int slide = 0; // time slide
  int minute;
  int hour;
  int month;
  int year;
  String amPm;

  void Slide1() {/*Nothing to Construct*/}

  void drawSlide() {
    background(255);
    fill(0);
    textSize(128);
    text(theTime, timeX, timeY); // draw the time
    textSize(64); // draw the date
    //text()
    textSize(128);
  }

  void update() { // function will contain any variables that needed to be updated continuously
    minute = minute();
    hour = hour();
    month = month();
    year = year();
    theTime = hour + ":" + minute;
    timeX = 400 - textWidth(theTime)/2;
  }
}
