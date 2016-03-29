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
  drawSlide0(u.slide); // pass the value of slide from the utilities class into the function to check if it is 1
  // the variables in util will evantually be moved to a resources class depending on how many are needed
}

void drawSlide0(int s) { // s variable is the slide number to ensure it is only drawn when the user has navigated to it
  if (s == 0) { // check if the slide is the right one for the function to run the rest of the draw slide functions will use this model
    fill(0);
    textSize(128);
    text(u.get12HourTime(), width/2 - textWidth(u.get12HourTime())/2, height/2); // draw the time
    textSize(32); // draw the date
    text(theDate, 400 - textWidth(theDate)/2, 400);
    if (keyPressed && key == CODED) {
      if (keyCode == RIGHT) {
        background(255); // clear the screen when the button is pressed and incriment the slide variable
        u.slide = 1; // once the value of slide is changed in draw the function corresponding to that value will run
        // ex. all the code in this function is housed within an if statement checking that slide is 0 because this is slide 0
      } else if (keyCode == LEFT) {
        background(255);
        u.slide = 3; // give slide value that will likely correspond to the settings menu
      }
    }
  }
}

void drawSlide1(int s) {
  if (s == 1) {

  }
}

void drawSlide2(int s) {
  if (s == 2) {

  }
}

void drawSlide3(int s) {
  if (s == 3) {

  }
}
