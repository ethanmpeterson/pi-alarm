Util u = new Util();
Resource r = new Resource();
OnClickListener leftNavButton = new OnClickListener();
OnClickListener rightNavButton = new OnClickListener();

void setup() {
  size(800, 480);
  background(255);
  u.update();
  r.time = createFont("assets/fonts/timeFont.ttf", 24);
  r.schedule = createFont("assets/fonts/OpenSans.ttf", 64);
  frameRate(60);
  fill(0);
}

void draw() {
  background(255);
  u.update();
  //depending on what slide the user is switching from
  // once the value of slide is changed in draw the function corresponding to that value will run
  drawSlide0(r.slide); // pass the value of slide from the resources class into the function to check if it is 1
  drawSlide1(r.slide);
  drawSlide2(r.slide);
  drawSlide3(r.slide);
  leftRightNav();
  if (keyPressed && key == ' ') {
    exit();
  }
}

void mouseClicked() { // runs when the mouse is pressed and released (will be tested with pi touchscreen)
  if (rightNavButton.over()) {
    if (r.slide == 4) {
      r.slide = 0;
    } else {
      r.slide++;
    }
  }
  if (leftNavButton.over()) {
    if (r.slide == 0) {
      r.slide = 3;
    } else {
      r.slide--;
    }
  }
}


void leftRightNav() {
  fill(255);
  // draw right and left buttons
  triangle(r.rightButton[0], r.rightButton[1], r.rightButton[2], r.rightButton[3], r.rightButton[4], r.rightButton[5]); // right
  triangle(r.leftButton[0], r.leftButton[1], r.leftButton[2], r.leftButton[3], r.leftButton[4], r.leftButton[5]); // left
  leftNavButton.tri(r.leftButton[0], r.leftButton[1], r.leftButton[2], r.leftButton[3], r.leftButton[4], r.leftButton[5]);
  rightNavButton.tri(r.rightButton[0], r.rightButton[1], r.rightButton[2], r.rightButton[3], r.rightButton[4], r.rightButton[5]);
  rightNavButton.listen("TRIANGLE");
  leftNavButton.listen("TRIANGLE");
}


void drawSlide0(int s) { // s variable is the slide number to ensure it is only drawn when the user has navigated to it
  if (s == 0) { // check if the slide is the right one for the function to run the rest of the draw slide functions will use this model
    textFont(r.time);
    fill(0);
    textSize(128);
    text(u.get12HourTime(), width/2 - textWidth(u.get12HourTime())/2, height/2); // draw the time
    textSize(32); // draw the date
    text(u.theDate, 400 - textWidth(u.theDate)/2, 300);
  }
} //all the code in this function is housed within an if statement checking that slide is 0 because this is slide 0


void drawSlide1(int s) { // slide 1 will show RSGC Schedule
  if (s == 1) {
    textFont(r.schedule);
    fill(0);
    textSize(48);
    smooth();
    text("Schedule:", width/2 - textWidth("Schedule:")/2, 75);
    textSize(32);
    text("School", 125, 125);
    text("P1:", 125, 175);
    text("P2:", 125, 225);
    text("P3:", 125, 275);
    text("P4:", 125, 325);
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