Util u = new Util();
Resource r = new Resource();
OnClickListener leftNavButton = new OnClickListener();
OnClickListener rightNavButton = new OnClickListener();


void setup() {
  size(800, 480);
  background(255);
  u.update();
  r.time = createFont("assets/fonts/timeFont.ttf", 64);
  frameRate(60);
  textFont(r.time);
  fill(0);
}

void draw() {
  background(255);
  u.update();
  //depending on what slide the user is switching from
  // once the value of slide is changed in draw the function corresponding to that value will run
  drawSlide0(r.slide); // pass the value of slide from the utilities class into the function to check if it is 1
  leftRightNav();
  if (keyPressed && key == ' ') {
    exit();
  }
}

void mouseClicked() { // runs when the mouse is pressed and released (will be tested with pi touchscreen)
  if (rightNavButton.over(rightNavButton)) {
    //fill(r.buttonHighlight);
    //triangle(r.rightButton[0], r.rightButton[1], r.rightButton[2], r.rightButton[3], r.rightButton[4], r.rightButton[5]);
  } else {
    //fill(255);
    //triangle(r.rightButton[0], r.rightButton[1], r.rightButton[2], r.rightButton[3], r.rightButton[4], r.rightButton[5]);
  }
  if (leftNavButton.over(leftNavButton)) {
    //fill(r.buttonHighlight);
    //triangle(r.leftButton[0], r.leftButton[1], r.leftButton[2], r.leftButton[3], r.leftButton[4], r.leftButton[5]);
  } else {
    //fill(255);
    //triangle(r.leftButton[0], r.leftButton[1], r.leftButton[2], r.leftButton[3], r.leftButton[4], r.leftButton[5]);
  }
}

void drawSlide0(int s) { // s variable is the slide number to ensure it is only drawn when the user has navigated to it
  if (s == 0) { // check if the slide is the right one for the function to run the rest of the draw slide functions will use this model
    fill(0);
    textSize(128);
    text(u.get12HourTime(), width/2 - textWidth(u.get12HourTime())/2, height/2); // draw the time
    textSize(32); // draw the date
    text(u.theDate, 400 - textWidth(u.theDate)/2, 300);
  }
} //all the code in this function is housed within an if statement checking that slide is 0 because this is slide 0

void leftRightNav() {
  fill(255);
  // draw right and left buttons
  triangle(r.rightButton[0], r.rightButton[1], r.rightButton[2], r.rightButton[3], r.rightButton[4], r.rightButton[5]); // right
  triangle(r.leftButton[0], r.leftButton[1], r.leftButton[2], r.leftButton[3], r.leftButton[4], r.leftButton[5]); // left
  leftNavButton.tri(r.leftButton[0], r.leftButton[1], r.leftButton[2], r.leftButton[3], r.leftButton[4], r.leftButton[5]);
  rightNavButton.tri(r.rightButton[0], r.rightButton[1], r.rightButton[2], r.rightButton[3], r.rightButton[4], r.rightButton[5]);
  rightNavButton.listen(rightNavButton, "TRIANGLE");
  leftNavButton.listen(leftNavButton, "TRIANGLE");
}

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
