Util u = new Util();
String theDate;

void setup() {
  size(800, 480);
  background(255);
  u.update();
  theDate = u.getWeekDay(u.weekDay) + ", " + u.getMonth(u.month) + " " + u.day + " " + u.year;
  PFont time = createFont("fonts/timeFont.ttf", 64);
  frameRate(60);
  textFont(time);
}

void draw() {
  background(255);
  u.update();
  fill(0);
  //text(u.get12HourTime(), width/2 - textWidth(u.get12HourTime())/2, height/2);
  drawSlide0(u.slide);
}

void drawSlide0(int s) { // s variable is the slide number to ensure it is only drawn when the user has navigated to it
  if (s == 0) {
    fill(0);
    textSize(128);
    text(u.get12HourTime(), width/2 - textWidth(u.get12HourTime())/2, height/2); // draw the time
    textSize(32); // draw the date
    text(theDate, 400 - textWidth(theDate)/2, 400);
  }
}
