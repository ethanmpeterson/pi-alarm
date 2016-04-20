/*
Raspberry Pi Alarm Clock
 Author: Ethan Peterson
 Revision Date: April 19, 2016
 Description: The Raspberry Pi Alarm Clock is a program that is meant to go above what a traditional alarm clock can do offering the weather
 a school schedule and touchscreen operation with the Raspberry Pi.
 */

Util u = new Util();
Resource r = new Resource();
OnClickListener leftNavButton = new OnClickListener();
OnClickListener rightNavButton = new OnClickListener();
OnClickListener nextDay = new OnClickListener(); // for browsing the forecast on weather slide
OnClickListener prevDay = new OnClickListener();


String theWeather; // for the weather slide text
String forecastDays[] = new String[9]; // array storing the strings for weekdays of the forecast
boolean nextPressed; // boolean checking if the nextDay button in weather slide has been pressed same goes for prevPressed
boolean prevPressed;
int timesPressed = 0; // tracks the number of times the nextDay button has been pressed starting at 1


void setup() {
  size(800, 480);
  background(255);
  u.setWeather("Toronto", "ON");
  u.update();
  r.load();
  frameRate(60); // processing will go for 60fps by default however since my program has simple graphics I should cap the rate at 60
  fill(0);
  // print out forecast for each day of the week for testing
  theWeather = u.getTemp() + "°C  " + u.getWeather();
  if (u.xmlAvail()) {
    for (int i = 0; i < 4; i++) { // prints out the forecast high and low temps for 2 days from now (At the time of this comment wednesday)
      print(u.getForecast()[0][i] + ", "); // first demension of array is the day and second is the resource you want such as high temp of the day
      // prints out day, forecast, high temperature and low temperature
    }
  }
}


void draw() {
  background(255);
  u.update();
  //depending on what slide the user is switching from
  // once the value of slide is changed in draw the function corresponding to that value will run
  drawSlides(r.slide); // pass the value of slide from the resources class into the function to check if it is 1
  leftRightNav();
  if (keyPressed && key == ' ') {
    exit();
  }
  if (u.minute == 0 && second() == 0) { // update the weather every hour
    u.updateXML();
  }
}

void mouseClicked() { // runs when the mouse is pressed and released (will be tested with pi touchscreen)
  // handle clicks to navigate between slides
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
  // handle clicks on nextDay and PrevDay buttons in weather slide
  if (nextDay.over()) {
    nextPressed = true;
    println("next Pressed");
    timesPressed++;
  }
  if (prevDay.over()) {
    prevPressed = true;
    println("prev Pressed");
    timesPressed--;
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


void drawSlides(int s) {
  if (s == 0) { // code for slide 0 and the following if statements will represent a particular slide as well
    textFont(r.time);
    fill(0);
    textSize(128);
    text(u.get12HourTime(), width/2 - textWidth(u.get12HourTime())/2, height/2); // draw the time
    textSize(32); // draw the date
    text(u.theDate, 400 - textWidth(u.theDate)/2, 300);
  }

  if (s == 1) {
    textFont(r.schedule);
    fill(0);
    textSize(48);
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

  if (s == 2) { // extra carriculars
  }

  if (s == 3) { // weather slide
    textSize(48);
    fill(0);
    text("Weather", width/2 - textWidth("Weather")/2, 75);
    textSize(32);
    text(theWeather, width/2 - textWidth(theWeather)/2, 150);
    for (int i = 0; i < 9; i++) { // use for loop to grab weekdays in the forecast and move to new array outside of the class
      forecastDays[i] = u.getForecast()[i][0];
    }
    fill(255);
    rect(width/2 - 75/2, 300, 75, 30); // draw rect to display text telling the user what day they are viewing the weather for
    // draw triangular buttons to navigate between days
    triangle(width/2 - 75/2 - 5, 330, width/2 - 75/2 - 5, 300, width/2 - 75/2 - 20, 300 + 15); // prev day navigation button
    triangle(75 + width/2 - 75/2 + 5, 330, 75 + width/2 - 75/2 + 5, 300, 75 + width/2 - 75/2 + 20, 300 + 15); // next day navigation button
    nextDay.tri(75 + width/2 - 75/2 + 5, 330, 75 + width/2 - 75/2 + 5, 300, 75 + width/2 - 75/2 + 20, 300 + 15);
    prevDay.tri(width/2 - 75/2 - 5, 330, width/2 - 75/2 - 5, 300, width/2 - 75/2 - 20, 300 + 15);
    nextDay.listen("TRIANGLE");
    prevDay.listen("TRIANGLE");
    fill(0);
    if (!nextPressed && !prevPressed) {
      text(forecastDays[0], width/2 - textWidth(forecastDays[0])/2, 328);
    }
    if (nextPressed || prevPressed) {
      if (timesPressed < 9 && timesPressed >= 1) { // prevents the user from clicking the button too many times causing an array out of bounds runtime error
        text(forecastDays[timesPressed], width/2 - textWidth(forecastDays[timesPressed])/2, 328);
      } else if (timesPressed > 8) { // insert protective else if statements to prevent array out of bounds error
        timesPressed = 1;
      } else if (timesPressed < 1) {
        timesPressed = 8;
      }
    }
  }

  if (s == 4) {
  }
}