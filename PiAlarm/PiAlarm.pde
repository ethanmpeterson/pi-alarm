int slide = 0; // time slide
int minute;
int hour;
int month;
int year;
String theTime; // string containing the complete time for the pi Alarms main page
String amPm;
PFont time;

void setup() {
  size(800, 480);
  background(255);
  time = createFont("fonts/timeFont.ttf", 32);
  textFont(time);
  //fullScreen(); //uncomment the line when the program is exported for the Pi
}

void draw() {
  //background(255);
  update();
  fill(0);
  text(theTime, width/2 - textWidth(theTime)/2, height/2);
}

void update() { // function will contain any variables that needed to be updated continuously
  minute = minute();
  hour = hour();
  month = month();
  year = year();
  theTime = hour + ":" + minute;
}
