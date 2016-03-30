import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Calendar; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PiAlarm extends PApplet {

Util u = new Util();
Resource r = new Resource();

public void setup() {
  
  background(255);
  u.update();
  r.time = createFont("assets/fonts/timeFont.ttf", 64);
  frameRate(60);
  textFont(r.time);
}

public void draw() {
  background(255);
  u.update();
  fill(0);
  u.switchSlideFrom(r.slide); // use switch slide function to change slide value accordingly
  //depending on what slide the user is switching from
  // once the value of slide is changed in draw the function corresponding to that value will run
  drawSlide0(r.slide); // pass the value of slide from the utilities class into the function to check if it is 1
  // the variables in util will evantually be moved to a resources class depending on how many are needed
}

public void drawSlide0(int s) { // s variable is the slide number to ensure it is only drawn when the user has navigated to it
  if (s == 0) { // check if the slide is the right one for the function to run the rest of the draw slide functions will use this model
    fill(0);
    textSize(128);
    text(u.get12HourTime(), width/2 - textWidth(u.get12HourTime())/2, height/2); // draw the time
    textSize(32); // draw the date
    text(u.theDate, 400 - textWidth(u.theDate)/2, 400);
  }
} //all the code in this function is housed within an if statement checking that slide is 0 because this is slide 0

public void drawSlide1(int s) { // slide 1 will show RSGC Schedule
  if (s == 1) {

  }
}

public void drawSlide2(int s) { // slide 2 will likely be weather
  if (s == 2) {

  }
}

public void drawSlide3(int s) { // will likely be settings
  if (s == 3) {

  }
}
class Resource { // stores useful public vars and assets such as sounds fonts and images
  public int slide = 0;
  public int timeX;
  public int timeY;
  public int dateX;
  public int dateY;
  public PFont time;
}
 // for keeping time as opposed to built in processing functions
//import processing.io.*; // IO library to control the raspberry Pi's GPIO pins to detect button presses
// for now navigation will be done with the keyboard for testing purposes
// the library will be included when the program is compiled for raspberry pi

class Util {

  //Resource r = new Resource();
  Calendar c = Calendar.getInstance();

  // useful variables for all classes
  // time slide
  public int minute;
  public int hour;
  public int day;
  public int weekDay;
  public int month;
  public int year;
  public String theDate;
  public boolean isPM;

  public void Util() { // do the initial setting of the variables in the constructor
    minute = c.get(Calendar.MINUTE); // update the time variables as shortcuts to accessing the calendar
    hour = c.get(Calendar.HOUR);
    day = c.get(Calendar.DAY_OF_MONTH);
    weekDay = c.get(Calendar.DAY_OF_WEEK);
    month = c.get(Calendar.MONTH) + 1;
    year = c.get(Calendar.YEAR);
    theDate = u.getWeekDay(u.weekDay) + ", " + u.getMonth(u.month) + " " + u.day + " " + u.year;
  }

  public void update() { // function will contain any variables that needed to be updated continuously in draw function
    minute = c.get(Calendar.MINUTE);
    hour = c.get(Calendar.HOUR);
    day = c.get(Calendar.DAY_OF_MONTH);
    weekDay = c.get(Calendar.DAY_OF_WEEK);
    month = c.get(Calendar.MONTH) + 1;
    year = c.get(Calendar.YEAR);
    theDate = u.getWeekDay(u.weekDay) + ", " + u.getMonth(u.month) + " " + u.day + " " + u.year;
  }

  public String getMonth(int m) { // takes month var as input
    if (m == 1) {
      return "January";
    } else if (m == 2) {
      return "February";
    } else if (m == 3) {
      return "March";
    } else if (m == 4) {
      return "April";
    } else if (m == 5) {
      return "May";
    } else if (m == 6) {
      return "June";
    } else if (m == 7) {
      return "July";
    } else if (m == 8) {
      return "August";
    } else if (m == 9) {
      return "September";
    } else if (m == 10) {
      return "October";
    } else if (m == 11) {
      return "November";
    } else if (m == 12) {
      return "December";
    } else {
      return "Error";
    }
  }

  public String getWeekDay(int w) { // function returns a weekday based on what number is given by the Java Calendar class
    if (w == 1) {
      return "Sunday";
    } else if (w == 2) {
      return "Monday";
    } else if (w == 3) {
      return "Tuesday";
    } else if (w == 4) {
      return "Wednesday";
    } else if (w == 5) {
      return "Thursday";
    } else if (w == 6) {
      return "Friday";
    } else if (w == 7) {
      return "Saturday";
    } else {
      return "Error";
    }
  }

  public String get12HourTime() { // returns a String of the time in 12 hour form
    if (c.get(Calendar.HOUR_OF_DAY) >= 12) { // checks if the hour of the day is greater or equal to 12 meaning it is the afternoon
      isPM = true;
    }
    if (c.get(Calendar.HOUR_OF_DAY) < 12) { // checks if the hour of the day is less than 12 meaning it is the morning
      isPM = false;
    }
    if (!isPM && minute >= 10) {
      return hour + ":" + minute + " AM";
    } else if (minute < 10) { // add 0 padding if the minute is below 10
      return hour + ":" + "0" + minute + " AM";
    } else if (isPM && minute >= 10) {
      return hour + ":" + minute + " PM";
    } else if (minute < 10) {
      return hour + ":" + "0" + minute + " PM";
    } else {
      return "Error";
    }
  }

  public void switchSlideFrom(int s) {
    if (keyPressed && key == CODED) {
      if (keyCode == RIGHT) {
        if (s == 0) {
          r.slide = 1;
        }
        if (s == 1) {
          r.slide = 2;
        }
        if (s == 2) {
          r.slide = 3;
        }
        if (s == 3) {
          r.slide = 0;
        }
      }
      if (keyCode == LEFT) {
        if (s == 0) {
          r.slide = 3;
        }
        if (s == 1) {
          r.slide = 0;
        }
        if (s == 2) {
          r.slide = 1;
        }
        if (s == 3) {
          r.slide = 2;
        }
      }
    }
  }
}
  public void settings() {  size(800, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PiAlarm" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
