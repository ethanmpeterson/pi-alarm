class Util {
  public int slide = 0; // time slide
  public int minute;
  public int hour;
  public int day;
  public int month;
  public int year;
  void Util() {/*Nothing to Construct*/}

  void update() { // function will contain any variables that needed to be updated continuously
    minute = c.get(Calendar.MINUTE) + 1;
    hour = c.get(Calendar.HOUR);
    month = c.get(Calendar.MONTH);
    year = c.get(Calendar.YEAR);
    theTime = hour + ":" + minute;
    timeX = 400 - textWidth(theTime)/2;
  }

  String getMonth(int m) { // takes month var as input
    if (m == 1) {
      return "January";
    }
    if (m == 2) {
      return "February";
    }
    if (m == 3) {
      return "March";
    }
    if (m == 4) {
      return "April";
    }
    if (m == 5) {
      return "May";
    }
    if (m == 6) {
      return "June";
    }
    if (m == 7) {
      return "July";
    }
    if (m == 8) {
      return "August";
    }
    if (m == 9) {
      return "September";
    }
    if (m == 10) {
      return "October";
    }
    if (m == 11) {
      return "November";
    }
    if (m == 12) {
      return "December";
    }
    return "Error";
  }


  String getWeekDay(int w) {
    if (w == 1) {
      return "Sunday";
    }
    if (w == 2) {
      return "Monday";
    }
    if (w == 3) {
      return "Tuesday";
    }
    if (w == 4) {
      return "Wednesday";
    }
    if (w == 5) {
      return "Thursday";
    }
    if (w == 6) {
      return "Friday";
    }
    if (w == 7) {
      return "Saturday";
    }
    return "Error";
  }

  String get12HourTime() {

  }
}
