/*
Raspberry Pi Alarm Clock
Author: Ethan Peterson
Revision Date: April 11, 2016
Description: The Raspberry Pi Alarm Clock is a program that is meant to go above what a traditional alarm clock can do offering the weather
a school schedule and touchscreen operation with the Raspberry Pi.
*/

Util u = new Util();
Resource r = new Resource();
OnClickListener leftNavButton = new OnClickListener();
OnClickListener rightNavButton = new OnClickListener();
Weather weather;

void setup() {
  size(800, 480);
  background(255);
  weather = new Weather("Toronto", "ON");
  if (!weather.xmlAvail()) {
    
  }
  u.update();
  r.time = createFont("assets/fonts/timeFont.ttf", 24);
  r.schedule = createFont("assets/fonts/OpenSans.ttf", 64);
  frameRate(60);
  fill(0);
  // print out forecast for each day of the week for testing
  if (weather.xmlAvail()) {
    for (int i = 0; i < 4; i++) { // prints out the forecast high and low temps for 2 days from now (At the time of this comment wednesday)
      print(weather.getForecast()[0][i] + ", "); // first demension of array is the day and second is the resource you want such as high temp of the day
      // prints out day, forecast, high temperature and low temperature
    }
  }
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
  if (u.minute == 0) { // update the weather every hour
    weather.updateXML();
  }
}

void mouseClicked() { // runs when the mouse is pressed and released (will be tested with pi touchscreen)
  if (rightNavButton.over()) {
    if (r.slide == r.slideNum) {
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
    text("School Schedule:", width/2 - textWidth("School Schedule:")/2, 75);
    textSize(32);
    if (u.dayNum == 1 || u.dayNum == 2 || u.dayNum == 3 || u.dayNum == 4) {
      text("P1: " + u.p1 + u.p1Time, width/2 - textWidth("P1: " + u.p1 + u.p1Time)/2, 175);
      text("P2: " + u.p2 + u.p2Time, width/2 - textWidth("P2: " + u.p2 + u.p2Time)/2, 225);
      text("P3: " + u.p3 + u.p3Time, width/2 - textWidth("P3: " + u.p3 + u.p3Time)/2, 275);
      text("P4: " + u.p4 + u.p4Time, width/2 - textWidth("P4: " + u.p4 + u.p4Time)/2, 325);
    } 
    if (u.dayNum == 9) {
      textSize(48);
      text("It's A Holiday!", width/2 - textWidth("It's A Holiday!")/2, 175);
    }
  }
}


void drawSlide2(int s) { // slide 2 will be the users after school activities
  if (s == 2) {
    
  }
}


void drawSlide3(int s) { // will be weather slide
  if (s == 3) {
  }
}