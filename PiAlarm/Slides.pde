class Slide1 {
  float x;
  float y = 480/2;
  float x2;
  float y2;
  float x3;
  float y3;
  boolean rightPressed;
  boolean leftPressed;
  String theTime; // string containing the complete time for the pi Alarms main page
  int slide = 0; // time slide
  int minute;
  int hour;
  int month;
  int year;
  String amPm;

void Slide1() {/*Nothing to Construct*/}

  void drawSlide() {
    fill(0);
    text(theTime, x, y);
  }

  void update() { // function will contain any variables that needed to be updated continuously
    minute = minute();
    hour = hour();
    month = month();
    year = year();
    theTime = hour + ":" + minute;
    x = 400 - textWidth(theTime)/2;
  }
}
