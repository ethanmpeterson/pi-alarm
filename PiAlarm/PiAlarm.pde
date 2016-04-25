/*
Raspberry Pi Alarm Clock
 Author: Ethan Peterson
 Revision Date: April 24, 2016
 Description: The Raspberry Pi Alarm Clock is a program that is meant to go above what a traditional alarm clock can do offering the weather
 a school schedule and touchscreen operation with the Raspberry Pi.
 */

Util u = new Util();
Resource r = new Resource();
OnClickListener leftNavButton = new OnClickListener();
OnClickListener rightNavButton = new OnClickListener();
OnClickListener nextDay = new OnClickListener(); // for browsing the forecast on weather slide
OnClickListener prevDay = new OnClickListener();
OnClickListener changeDate = new OnClickListener(); // button placed on the school schedule slide allowing user to change the date of shcedule being viewed
OnClickListener monthUp = new OnClickListener(); // lets user navigate to next month
OnClickListener monthDown = new OnClickListener(); // lets user navigate to previous month
OnClickListener dayUp = new OnClickListener(); // lets user navigate to next day in schedule
OnClickListener dayDown = new OnClickListener(); // lets user navigate to previous days schedule
OnClickListener enterDate = new OnClickListener(); // enters the date of the schedule the user wants to view


String theWeather; // for the weather slide text
String forecastDays[] = new String[9]; // array storing the strings for weekdays of the forecast
boolean nextPressed; // boolean checking if the nextDay button in weather slide has been pressed same goes for prevPressed
boolean prevPressed;
boolean changePressed; // true if the changeDate button has been clicked
int timesPressed = 0; // tracks the number of times the nextDay button has been pressed starting at 0
int monthInput; // keeps track of what month the user has inputted into the schedule slide
int dayInput; // keeps track of what day the user has inputted into the schedule slide


void setup() {
  size(800, 480);
  background(255);
  u.setWeather("Toronto", "ON");
  u.update();
  r.load();
  frameRate(60); // processing will go for 60fps by default however since my program has simple graphics I should cap the rate at 60
  fill(0);
  // print out forecast for each day of the week for testing
  theWeather = u.getTemp() + "°C  " + u.getForecast()[timesPressed][1];
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
    println("next Pressed " + timesPressed);
    if (timesPressed == 8) {
      timesPressed = 0;
    } else {
      timesPressed++;
    }
  }
  if (prevDay.over()) {
    prevPressed = true;
    println("prev Pressed " + timesPressed);
    if (timesPressed == 0) {
      timesPressed = 8;
    } else {
      timesPressed--;
    }
  }
  if (changeDate.over()) {
    changePressed = true;
    
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
    monthInput = u.month;
    dayInput = u.day;
    textFont(r.schedule);
    fill(0);
    textSize(48);
    text("School Schedule:", width/2 - textWidth("School Schedule:")/2, 75);
    textSize(32);
    fill(255);
    rect(r.CD[0], r.CD[1], r.CD[2], r.CD[3]);
    changeDate.rec(r.CD[0], r.CD[1], r.CD[2], r.CD[3]);
    changeDate.listen("RECTANGLE");
    fill(0);
    textSize(20);
    text("Change Date", r.CD[0] + 3, r.CD[0]);
    if (changePressed) {
      fill(255);
      rect(width/2 + 140, 350, 120, 30);
      triangle(width/2 + 145 + 120, 350 + 13, width/2 + 145 + 120 + 25, 350 + 13, width/2 + 145 + 120 + 25/2, 350 - 5);
    }
    textSize(32);
    if (u.dayNum == 1 || u.dayNum == 2 || u.dayNum == 3 || u.dayNum == 4) {
      fill(0);
      text("P1: " + u.p1 + u.p1Time, width/2 - textWidth("P1: " + u.p1 + u.p1Time)/2, 175); // display schedule strings onscreen
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
    textFont(r.schedule);
    textSize(48);
    fill(0);
    text("Extracurricular Activities", width/2 - textWidth("Extracurricular Activities")/2, 75);
  }

  if (s == 3) { // weather slide
    theWeather = u.getTemp() + "°C  " + u.getForecast()[timesPressed][1]; // ensure the weather string is updated when the slide is displayed
    textFont(r.schedule);
    textSize(48);
    fill(0);
    text("Weather", width/2 - textWidth("Weather")/2, 75);
    textSize(32);
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
    textSize(32);
    if (!nextPressed && !prevPressed || timesPressed == 0) {
      text(theWeather, width/2 - textWidth(theWeather)/2, 230);
    }
    if (timesPressed != 0) {
      text(u.getForecast()[timesPressed][1], width/2 - textWidth(u.getForecast()[timesPressed][1])/2, 230); // draw weather text without the current temp because it is forecast
    }
    shape(r.upArrow, r.highArrow[0], r.highArrow[1], r.highArrow[2], r.highArrow[3]); // draw arrow representing the high temp from svg asset
    shape(r.downArrow, r.lowArrow[0], r.lowArrow[1], r.lowArrow[2], r.lowArrow[3]); // draw arrow representing the low temp from svg asset
    text(u.getForecast()[timesPressed][2] + "°", r.highArrow[0] - textWidth(u.getForecast()[0][2])/2 - 30, r.highArrow[1] + 35); // draw highs and lows for the day
    text(u.getForecast()[timesPressed][3] + "°", r.lowArrow[0] + textWidth(u.getForecast()[0][3])/2 + 45, r.lowArrow[1] + 35);
    text(forecastDays[timesPressed], width/2 - textWidth(forecastDays[timesPressed])/2, 328);
    text(u.getForecast()[timesPressed][4], width/2 - textWidth(u.getForecast()[timesPressed][4])/2, 375);
    text(u.getLocation(), width/2 - textWidth(u.getLocation())/2, 425);
    if (nextPressed || prevPressed) {
    }
    if (u.getForecast()[timesPressed][1].equals("Mostly Cloudy") || u.getForecast()[timesPressed][1].equals("Partly Cloudy") || u.getForecast()[timesPressed][1].equals("Mostly Sunny")) {
      shape(r.partlyCloudy, r.wIcon[0], r.wIcon[1], r.wIcon[2], r.wIcon[3]);
    }
    if (u.getForecast()[timesPressed][1].equals("Cloudy")) {
      shape(r.cloud, r.wIcon[0], r.wIcon[1], r.wIcon[2], r.wIcon[3]);
    }
    if (u.getForecast()[timesPressed][1].equals("Sunny")) {
      shape(r.sun, r.wIcon[0], r.wIcon[1], r.wIcon[2], r.wIcon[3]);
    }
    if (u.getForecast()[timesPressed][1].equals("Showers")) {
      shape(r.rain, r.wIcon[0], r.wIcon[1], r.wIcon[2], r.wIcon[3]);
    }
    if (u.getForecast()[timesPressed][1].equals("Scattered Showers")) {
      shape(r.sunShowers, r.wIcon[0], r.wIcon[1], r.wIcon[2], r.wIcon[3]);
    }
    if (u.getForecast()[timesPressed][1].equals("Rain And Snow")) {
      shape(r.rainSnow, r.wIcon[0], r.wIcon[1], r.wIcon[2], r.wIcon[3]);
    }
    if (u.getForecast()[timesPressed][1].equals("Rain")) {
      shape(r.rain, r.wIcon[0], r.wIcon[1], r.wIcon[2], r.wIcon[3]);
    }
  }

  if (s == 4) {
  }
}