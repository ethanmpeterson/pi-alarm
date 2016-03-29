import java.util.Calendar; // for keeping time as opposed to built in processing functions

class Util {

  Calendar c = Calendar.getInstance();

  // useful variables for all classes
  public int slide = 0; // time slide
  public int minute;
  public int hour;
  public int day;
  public int weekDay;
  public int month;
  public int year;
  public int timeX;
  public int timeY;
  public int dateX;
  public int dateY;
  public boolean isPM;

  void Util() { // do the initial setting of the variables in the constructor
    minute = c.get(Calendar.MINUTE);
    hour = c.get(Calendar.HOUR);
    day = c.get(Calendar.DAY_OF_MONTH);
    weekDay = c.get(Calendar.DAY_OF_WEEK);
    month = c.get(Calendar.MONTH) + 1;
    year = c.get(Calendar.YEAR);
  }

  void update() { // function will contain any variables that needed to be updated continuously
    minute = c.get(Calendar.MINUTE);
    hour = c.get(Calendar.HOUR);
    day = c.get(Calendar.DAY_OF_MONTH);
    weekDay = c.get(Calendar.DAY_OF_WEEK);
    month = c.get(Calendar.MONTH) + 1;
    year = c.get(Calendar.YEAR);
  }

  String getMonth(int m) { // takes month var as input
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

  String getWeekDay(int w) {
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

  String get12HourTime() {
    if (c.get(Calendar.HOUR_OF_DAY) >= 12) {
      isPM = true;
    }
    if (c.get(Calendar.HOUR_OF_DAY) < 12) {
      isPM = false;
    }
    if (!isPM) {
      return hour + ":" + minute + " AM";
    } else if (isPM) {
      return hour + ":" + minute + " PM";
    }
    return hour + ":" + minute;
  }
}