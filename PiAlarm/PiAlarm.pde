Util u = new Util();
Resource r = new Resource();

void setup() {
  size(800, 480);
  background(255);
  u.update();
  r.time = createFont("assets/fonts/timeFont.ttf", 64);
  frameRate(60);
  textFont(r.time);
}

void draw() {
  //background(255);
  u.update();
  fill(0);
  u.switchSlideFrom(r.slide); // use switch slide function to change slide value accordingly
  //depending on what slide the user is switching from
  // once the value of slide is changed in draw the function corresponding to that value will run
  drawSlide0(r.slide); // pass the value of slide from the utilities class into the function to check if it is 1
  // the variables in util will evantually be moved to a resources class depending on how many are needed
}

void drawSlide0(int s) { // s variable is the slide number to ensure it is only drawn when the user has navigated to it
  if (s == 0) { // check if the slide is the right one for the function to run the rest of the draw slide functions will use this model
    fill(0);
    textSize(128);
    text(u.get12HourTime(), width/2 - textWidth(u.get12HourTime())/2, height/2); // draw the time
    textSize(32); // draw the date
    text(u.theDate, 400 - textWidth(u.theDate)/2, 400);
  }
} //all the code in this function is housed within an if statement checking that slide is 0 because this is slide 0

void drawSlide1(int s) { // slide 1 will show RSGC Schedule
  if (s == 1) {

  }
}

void drawSlide2(int s) { // slide 2 will likely be weather
  if (s == 2) {

  }
}

void drawSlide3(int s) { // will likely be settings
  if (s == 3) {

  }
}
