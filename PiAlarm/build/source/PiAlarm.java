import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PiAlarm extends PApplet {

int slide = 0; // time slide
int minute;
int hour;
int month;
int year;
String theTime;
PFont time;

public void setup() {
  
  background(255);
  time = createFont("fonts/timeFont.ttf", 32);
  textFont(time);
  //fullScreen(); //uncomment the line when the program is exported for the Pi
}

public void draw() {
  //background(255);
  update();
  fill(0);
  text(theTime, width/2 - textWidth(theTime)/2, height/2);
}

public void update() {
  minute = minute();
  hour = hour();
  month = month();
  year = year();
  theTime = hour + " : " + minute;
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
