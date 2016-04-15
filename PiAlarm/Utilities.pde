import java.util.Calendar; // for keeping time as opposed to built in processing functions
import java.util.Date; // for getting the date from system time and updating the calendar object
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
  public int dayNum;
  public String theDate;
  public String p1, p2, p3, p4;
  public boolean isPM;
  public String p1Time = "  (8:15 AM - 9:30 AM)";
  public String p2Time = "  (9:35 AM - 10:50 AM)";
  public String p3Time = "  (11:15 AM - 12:30 PM)";
  public String p4Time = "  (1:25 PM - 2:40 PM)";
  public String[] extras;
  void Util() { // do the initial setting of the variables in the constructor
    c = Calendar.getInstance();
    minute = c.get(Calendar.MINUTE); // update the time variables as shortcuts to accessing the calendar
    hour = c.get(Calendar.HOUR);
    day = c.get(Calendar.DAY_OF_MONTH);
    weekDay = c.get(Calendar.DAY_OF_WEEK);
    month = c.get(Calendar.MONTH) + 1;
    year = c.get(Calendar.YEAR);
    theDate = u.getWeekDay(u.weekDay) + ", " + u.getMonth(u.month) + " " + u.day + " " + u.year;
    this.dayNum = r.schoolYear[this.month - 1][this.day];
    if (this.dayNum == 1) {
      p1 = "Comm. Tech";
      p2 = "Gym";
      p3 = "English";
      p4 = "Instrumental";
    } 
    if (this.dayNum == 2) {
      p1 = "Science";
      p2 = "Software";
      p3 = "French";
      p4 = "Math";
    } 
    if (this.dayNum == 3) {
      p1 = "Instrumental";
      p2 = "Gym";
      p3 = "English";
      p4 = "Comm. Tech";
    } 
    if (this.dayNum == 4) {
      p1 = "Math";
      p2 = "Software";
      p3 = "French";
      p4 = "Science";
    }
  }

  void update() { // function will contain any variables that needed to be updated continuously in draw function
    c = Calendar.getInstance(); // reseting the object in a loop will update it to the latest time
    minute = c.get(Calendar.MINUTE);
    hour = c.get(Calendar.HOUR);
    day = c.get(Calendar.DAY_OF_MONTH);
    weekDay = c.get(Calendar.DAY_OF_WEEK);
    month = c.get(Calendar.MONTH) + 1;
    year = c.get(Calendar.YEAR);
    theDate = u.getWeekDay(u.weekDay) + ", " + u.getMonth(u.month) + " " + u.day + " " + u.year;
    this.dayNum = r.schoolYear[month - 1][day];
    if (this.dayNum == 1) {
      p1 = "Comm. Tech";
      p2 = "Gym";
      p3 = "English";
      p4 = "Instrumental";
    } 
    if (this.dayNum == 2) {
      p1 = "Science";
      p2 = "Software";
      p3 = "French";
      p4 = "Math";
    } 
    if (this.dayNum == 3) {
      p1 = "Instrumental";
      p2 = "Gym";
      p3 = "English";
      p4 = "Comm. Tech";
    } 
    if (this.dayNum == 4) {
      p1 = "Math";
      p2 = "Software";
      p3 = "French";
      p4 = "Science";
    }
  }

  String getMonth(int m) { // takes month var as input
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

  String getWeekDay(int w) { // function returns a weekday based on what number is given by the Java Calendar class
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

  String get12HourTime() { // returns a String of the time in 12 hour form
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
}