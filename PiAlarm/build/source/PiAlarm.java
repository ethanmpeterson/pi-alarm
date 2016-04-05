import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Calendar; 
import java.util.Date; 

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
OnClickListener leftTriButton = new OnClickListener();
OnClickListener rightTriButton = new OnClickListener();
OnClickListener rectTest = new OnClickListener();

public void setup() {
  
  background(255);
  u.update();
  r.time = createFont("assets/fonts/timeFont.ttf", 64);
  rectTest.rect(width/2, height/2, 50, 50);
  frameRate(60);
  textFont(r.time);
}

public void draw() {
  background(255);
  rectTest.listen(rectTest, "RECTANGLE");
  fill(0);
  rect(width/2, height/2, 50, 50);
  if (rectTest.overShape[1]) {
    fill(255);
    rect(width/2, height/2, 50, 50);
  } else {
    fill(0);
    rect(width/2, height/2, 50, 50);
  }
  u.update();
  u.switchSlideFrom(r.slide); // use switch slide function to change slide value accordingly
  //depending on what slide the user is switching from
  // once the value of slide is changed in draw the function corresponding to that value will run
  drawSlide0(r.slide); // pass the value of slide from the utilities class into the function to check if it is 1
  if (keyPressed && key == ' ') {
    exit();
  }
}

public void mouseClicked() { // runs when the mouse is pressed and released (will be tested with pi touchscreen)

}

public void drawSlide0(int s) { // s variable is the slide number to ensure it is only drawn when the user has navigated to it
  if (s == 0) { // check if the slide is the right one for the function to run the rest of the draw slide functions will use this model
    fill(0);
    textSize(128);
    text(u.get12HourTime(), width/2 - textWidth(u.get12HourTime())/2, height/2); // draw the time
    textSize(32); // draw the date
    text(u.theDate, 400 - textWidth(u.theDate)/2, 300);
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
interface Triangle {
  public void tri(float x1, float y1, float x2, float y2, float x3, float y3);
}

interface Rectangle {
  public void rect(float x, float y, float width, float height);
}

interface Circle {
  public void circle(float x, float y, float diameter);
}
class OnClickListener implements Triangle, Rectangle, Circle { // implements methods within each of those interfaces

  private Util u = new Util(); // gives access to util functions in case they are needed
  private Resource r = new Resource(); // gives class access to variables stored in Resource class

  // arrays to hold coordinates from the shapes being inputted into their respective function
  float triangle[] = new float[6];
  float triAreas[] = new float[4]; // will store area values for calculating if the the mouse is inside any given triangle
  float rectangle[] = new float[4];
  float circle[] = new float[3];
  public boolean overShape[] = new boolean[3]; // public boolean array to check if the cursor is hovering over a certain shape depending on the position in the array
  // ex. first position is true if the cursor is hovering over a triangle
  // private class variables

  public void OnClickListener() {/*Nothing to Construct*/}
  // interface methods (program does not compile unless methods from the interfaces I have implemented in the class are within it)

  public void tri(float x1, float y1, float x2, float y2, float x3, float y3) {
    this.triangle[0] = x1; // use this to make the value unique to the particular instance of the OnClickListener class
    this.triangle[1] = y1;
    this.triangle[2] = x2;
    this.triangle[3] = y2;
    this.triangle[4] = x3;
    this.triangle[5] = y3;
  }


  public void rect(float x, float y, float width, float height) {
    // fill the rectangle array with values inputted into the function using this to make it unique to the particular instance of the class
    this.rectangle[0] = x;
    this.rectangle[1] = y;
    this.rectangle[2] = width;
    this.rectangle[3] = height;
  }


  public void circle(float x, float y, float diameter) {
    this.circle[0] = x;
    this.circle[1] = y;
    this.circle[2] = diameter;
  }


  //function listens for button presses and does something if the given shape has been pressed
  public void listen(OnClickListener button, String shape) { // takes OnClickListener as input to check the variables of that particular object
    if (shape == "TRIANGLE") {
      // get area of the triangle given in this object
      triAreas[0] = triArea(button.triangle[0], button.triangle[1], button.triangle[2], button.triangle[3], button.triangle[4], button.triangle[5]);
      // collect area substiting each point of the triangle with the mouse coordinates and storing them in a float array
      triAreas[1] = triArea(mouseX, mouseY, button.triangle[2], button.triangle[3], button.triangle[4], button.triangle[5]);
      triAreas[2] = triArea(button.triangle[0], button.triangle[1], mouseX, mouseY, button.triangle[4], button.triangle[5]);
      triAreas[3] = triArea(button.triangle[0], button.triangle[1], button.triangle[2], button.triangle[3], mouseX, mouseY);
      if (triAreas[0] == triAreas[1] + triAreas[2] + triAreas[3]) {
        button.overShape[0] = true;
      } else {
        button.overShape[0] = false;
      }
    } else if (shape == "RECTANGLE") {
      if (mouseX >= button.rectangle[0] && mouseX <= button.rectangle[0] + button.rectangle[2] && mouseY >= button.rectangle[1] && mouseY <= button.rectangle[1] + button.rectangle[3]) {
        overShape[1] = true;
      } else {
        overShape[1] = false;
      }
    } else if (shape == "CIRCLE") {
      if (sqrt(sq(button.circle[0] - mouseX) + sq(button.circle[1] - mouseY)) < button.circle[2]) {
        overShape[2] = true;
      } else {
        overShape[2] = false;
      }
    }
  }


  public boolean over() { // returns true if the cursor is hovering over a shape given to the class
    if (!this.overShape[0] && !this.overShape[1] && !this.overShape[2]) {
      return false;
    } else {
      return true;
    }
  }
  // extra class functions
  public float triArea(float x1, float y1, float x2, float y2, float x3, float y3) {
    return abs((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2))/2.0f); // return absolute value (positive val) of the area
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
 // for getting the date from system time and updating the calendar object
//import processing.io.*; // IO library to control the raspberry Pi's GPIO pins to detect button presses
// for now navigation will be done with the keyboard for testing purposes
// the library will be included when the program is compiled for raspberry pi

class Util {

  Resource r = new Resource();
  Calendar c;

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
  private long startTime; // long is like an int that can holder a larger value

  public void Util() { // do the initial setting of the variables in the constructor
    c = Calendar.getInstance();
    minute = c.get(Calendar.MINUTE); // update the time variables as shortcuts to accessing the calendar
    hour = c.get(Calendar.HOUR);
    day = c.get(Calendar.DAY_OF_MONTH);
    weekDay = c.get(Calendar.DAY_OF_WEEK);
    month = c.get(Calendar.MONTH) + 1;
    year = c.get(Calendar.YEAR);
    theDate = u.getWeekDay(u.weekDay) + ", " + u.getMonth(u.month) + " " + u.day + " " + u.year;
  }

  public void update() { // function will contain any variables that needed to be updated continuously in draw function
    c = Calendar.getInstance(); // reseting the object in a loop will update it to the latest time
    minute = c.get(Calendar.MINUTE);
    hour = c.get(Calendar.HOUR);
    day = c.get(Calendar.DAY_OF_MONTH);
    weekDay = c.get(Calendar.DAY_OF_WEEK);
    month = c.get(Calendar.MONTH) + 1;
    year = c.get(Calendar.YEAR);
    theDate = u.getWeekDay(u.weekDay) + ", " + u.getMonth(u.month) + " " + u.day + " " + u.year;
  }

  public String getMonth(int m) { // takes month var as input
    if (m == 1) { //return the right month string depending on what number from 1-12 is inputted into the function
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
    } else if (!isPM && minute < 10) { // add 0 padding if the minute is below 10
      return hour + ":" + "0" + minute + " AM";
    } else if (isPM && minute >= 10 && hour != 0) {
      return hour + ":" + minute + " PM";
    } else if (isPM && minute < 10 && hour != 0) {
      return hour + ":" + "0" + minute + " PM";
    } else if (isPM && hour == 0 && minute < 10) {
      return "12:" + "0" + minute + " PM";
    } else if (isPM && hour == 0 && minute >= 10) {
      return "12:" + minute + " PM";
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
