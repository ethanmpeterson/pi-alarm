/*
Raspberry Pi Alarm Clock
Author: Ethan Peterson
Revision Date: May 2, 2016
Description: The Raspberry Pi Alarm Clock is a program that is meant to go above what a traditional alarm clock can do offering the weather
a school schedule and touchscreen operation with the Raspberry Pi.
*/
import ddf.minim.*; // 3rd party audio library downloaded from processing add library wizard


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
OnClickListener today = new OnClickListener(); // allows user to return to current date in schedule slide
// alarm dialog OnClickListeners
OnClickListener alarm = new OnClickListener(); // button for setting alarm time
OnClickListener exitDialog = new OnClickListener(); // button to exit the dialog for setting alarm time
OnClickListener hourUp = new OnClickListener();
OnClickListener hourDown = new OnClickListener();
OnClickListener minUp = new OnClickListener();
OnClickListener minDown = new OnClickListener();
OnClickListener alarmUp = new OnClickListener();
OnClickListener alarmDown = new OnClickListener();
OnClickListener chooseRing = new OnClickListener();
OnClickListener cancel = new OnClickListener();
OnClickListener ok = new OnClickListener();
OnClickListener setAlarm = new OnClickListener();
OnClickListener playPause = new OnClickListener(); // for the play/pause button
OnClickListener snooze = new OnClickListener();
OnClickListener dismiss = new OnClickListener();


Minim minim; //initialize of main class from library
AudioSnippet ringTone; // initialize the audio file class of the library
AudioSnippet customRing; // have second instance for customized ringTone
Calendar cal; // instance of calendar class to check if it is am or pm


String theWeather; // for the weather slide text
String forecastDays[] = new String[9]; // array storing the strings for weekdays of the forecast
boolean nextPressed; // boolean checking if the nextDay button in weather slide has been pressed same goes for prevPressed
boolean prevPressed;
boolean changePressed; // true if the changeDate button has been clicked
int timesPressed = 0; // tracks the number of times the nextDay button has been pressed starting at 0
boolean dateChanged; // true if the user has changed the date
boolean tPressed;
boolean alarmPressed;
boolean wrongFile; // will be true if the user has not selected an mp3 file
boolean amPmPressed; // true if the button to switch from am to pm in alarm dialog is pressed
boolean isAm; // true if am is selected false if not
boolean hourPressed = false; // true if either of the hour up or down buttons are pressed
boolean minPressed = false;
boolean filePicked; // true if the user has picked a file for the alarm ring tone
boolean isPlaying; // true if the user has hit play to listen to their alarm ringtone
boolean alarmSet = false; // true if the alarm has been set and the alarm time has been saved to XML
boolean alarmRinging = false;
boolean snoozePressed = false; // will be true when snooze is pressed to initiate timer
boolean dismissPressed = false; // true if dismiss button was pressed
int monthInput; // keeps track of what month the user has inputted into the schedule slide
int dayInput; // keeps track of what day the user has inputted into the schedule slide
int dayNum;
int changedDayNum;
int dialogX = 400 - 150;
int dialogY = 50;
int hourInput; // will hold the hour of the alarm selected by the user in the dialog
int minInput; // will hold the minute of the alarm selected by the user in the dialog
int alarmHour; // will store the hour of when the alarm should go off
int alarmMinute;
int amPm = 0;
int millisTime; // will be set to millis() when snooze is pressed to time 10 mins for the alarm to go off again
String alarmPmAm; // will store if alarm is going off in the morning or the afternoon
String p1, p2, p3, p4;
String p1Time = "  (8:15 AM - 9:30 AM)";
String p2Time = "  (9:35 AM - 10:50 AM)";
String p3Time = "  (11:15 AM - 12:30 PM)";
String p4Time = "  (1:25 PM - 2:40 PM)";
String amPmButton;
String fileName;
String amPmDisplay[] = {"AM", "PM"};
XML alarmXML; // xml to load in the alarm clock time
XML[] children; // array for tags of the xml file
XML filePath;


void setup() {
  size(800, 480);
  background(255);
  minim = new Minim(this);
  ringTone = minim.loadSnippet("assets/audio/ringTone.mp3");
  u.setWeather("Toronto", "ON");
  u.update();
  r.load();
  filePath = loadXML("assets/xml/files.xml");
  XML path = filePath.getChild("filePath");
  String rPath = path.getString("path");
  if (!rPath.equals("none") && !filePicked) {
    File ring = new File(rPath);
   customRing = minim.loadSnippet(rPath);
   filePicked = true;
   fileName = ring.getName();
  }
  frameRate(60); // processing will go for 60fps by default however since my program has simple graphics I should cap the rate at 60
  fill(0);
  // print out forecast for each day of the week for testing
  theWeather = u.getTemp() + "°C  " + u.getForecast()[timesPressed][1];
  alarmXML = loadXML("assets/xml/savedData.xml");
  children = alarmXML.getChildren("time");
}


void draw() {
  println("AMPMPressed" + amPmButton);
  background(255);
  cal = Calendar.getInstance();
  u.update();
  dayNum = r.schoolYear[u.month - 1][u.day];
  leftRightNav();
  drawSlides(r.slide); // pass the value of slide from the resources class into the function to check the current slide and corresponding content
  println("alarm ring: " + alarmRinging);
  println("alarm set: " + alarmSet);
  alarmCheck();
  if (keyPressed && key == ' ') {
    exit();
  }
  if (u.minute == 0 && second() == 0) { // update the weather every hour
    u.updateXML();
  }
}

void mouseClicked() { // runs when the mouse is pressed and released (will be tested with pi touchscreen)
  fill(0);
  //text("Mouse Clicked!", width/2 - textWidth("Mouse Clicked")/2, height/2);
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
    if (timesPressed == 8) {
      timesPressed = 0;
    } else {
      timesPressed++;
    }
  }
  if (prevDay.over()) {
    prevPressed = true;
    if (timesPressed == 0) {
      timesPressed = 8;
    } else {
      timesPressed--;
    }
  }
  if (monthUp.over()) {
    if (monthInput == 12) {
      monthInput = 1;
    } else {
      monthInput++;
    }
  }
  if (monthDown.over()) {
    if (monthInput == 1) {
      monthInput = 12;
    } else {
      monthInput--;
    }
  }
  if (dayUp.over()) {
    if (dayInput == u.getMonthLength(monthInput)) {
      dayInput = 1;
    } else {
      dayInput++;
    }
  }
  if (dayDown.over()) {
    if (dayInput == 1) {
      dayInput = u.getMonthLength(monthInput);
    } else {
      dayInput--;
    }
  }
  if (today.over() && dateChanged) {
    dateChanged = false;
    changePressed = false;
  }
  if (enterDate.over() && changePressed) {
    dateChanged = true;
    changePressed = false;
    changedDayNum = r.schoolYear[monthInput - 1][dayInput];
  }
  if (changeDate.over()) {
    changePressed = true;
    dateChanged = false;
  }
  if (exitDialog.over()) {
   exitDialog();
  }
  if (alarm.over()) {
   alarmPressed = true;
  }
  if (hourUp.over()) {
    hourPressed = true;
    if (hourInput == 12) {
      hourInput = 1;
    } else {
      hourInput++;
    }
  }
  if (hourDown.over()) {
    hourPressed = true;
    if (hourInput == 1) {
      hourInput = 12;
    } else {
      hourInput--;
    }
  }
  if (minUp.over()) {
    minPressed = true;
    if (minInput == 59) {
      minInput = 0;
    } else {
      minInput++;
    }
  }
  if (minDown.over() && alarmPressed) {
    minPressed = true;
    if (minInput == 0) {
      minInput = 59;
    } else {
      minInput--;
    }
  } //<>//
  if (alarmUp.over() && alarmPressed) {
    amPmPressed = true;
    if (amPm == 1) {
      amPm = 0;
    } else {
      amPm = 1;
    }
  }
  if (alarmDown.over()) {
    amPmPressed = true;
    if (amPm == 0) {
      amPm = 1;
    } else {
      amPm = 0;
    }
  }
  if (chooseRing.over() && !wrongFile) {
    selectInput("Select Ring Tone Audio File", "fileSelected"); // open file selector window for the user to pick a audio file for their ring tone
    // first parameter is the message to be displayed to the user and the second is the name of the method to be called when a file is selected
  }
  if (cancel.over()) {
    wrongFile = false;
  }
  if (ok.over() && wrongFile) {
    wrongFile = false;
    selectInput("Select Ring Tone Audio File", "fileSelected");
  }
  if (playPause.over()) {
    if (!isPlaying) {
      isPlaying = true;
      if (filePicked) {
        customRing.play();
        ringTone.pause();
      } else {
        ringTone.play();
      }
    } else {
      isPlaying = false;
      if (filePicked) {
        customRing.pause();
        ringTone.pause();
      } else {
        ringTone.pause();
      }
    }
  }
  if (setAlarm.over()) {
    if (hourPressed || minPressed || amPmPressed && !alarmSet && alarmPressed) {
      alarmHour = hourInput;
      alarmMinute = minInput;
      alarmSet = true;
      if (amPmPressed) {
        alarmPmAm = amPmButton; 
      } else if (!amPmPressed) {
        alarmPmAm = AmOrPm();
      }
      children[0].setInt("alarmTime", alarmHour); // reset the ints in the file to the alarm times
      children[1].setInt("alarmTime", alarmMinute);
      children[2].setString("alarmTime", alarmPmAm);
      saveXML(alarmXML, "assets/xml/savedData.xml"); // save changes to assets folder overwriting old file
      for (int i = 0; i < children.length; i++) { // print out what was saved to xml to check it worked
        println(children[i].getContent() + ": " + children[i].getString("alarmTime"));
      }
      exitDialog();
    }
  }
  if (snooze.over()) {
    snooze();
  }
  if (dismiss.over()) {
    dismiss();
  }
}


void fileSelected(File selection) { // takes paremeter as a file object that the selectInput function returns in the callback 
  if (selection != null) {
    if (selection.getName().endsWith("mp3")) {
      customRing = minim.loadSnippet(selection.getAbsolutePath());
      fileName = selection.getName();
      filePath.getChild("filePath").setString("path", selection.getAbsolutePath());
      saveXML(filePath, "assets/xml/files.xml");
      filePath = loadXML("assets/xml/files.xml");
      filePicked = true;
    } else {
      filePicked = false;
      wrongFile = true;
    }
  } else {
    println("User has Cancelled");
  }
}


void dismiss() {
  dismissPressed = true;
  alarmRinging = false;
  millisTime = millis();
  if (filePicked) {
    customRing.rewind();
    customRing.pause();
  } else {
    ringTone.rewind();
    ringTone.pause();
  }
}


void snooze() {
  snoozePressed = true;
  millisTime = millis();
  alarmRinging = false;
  if (filePicked) {
    customRing.rewind();
    customRing.pause();
  } else {
    ringTone.rewind();
    ringTone.pause();
  }
}


void alarmCheck() { // will handle checking if it is alarm time amongst other things
  if (children[0].getString("alarmTime").equals("0") && children[1].getString("alarmTime").equals("0") && children[2].getString("alarmTime").equals("0")) { // use getString in case the alarm has been set and one of the tags holds a string and not int
    alarmSet = false;
  } else {
    alarmSet = true;
  }
  if (alarmSet) {
    alarmHour = children[0].getInt("alarmTime");
    alarmMinute = children[1].getInt("alarmTime");
    amPmButton = children[2].getString("alarmTime");
    println("alarmHour: " + alarmHour);
    println("alarmMinute: " + alarmMinute);
    println("isAm: " + isAm);
    if (u.hour == alarmHour && u.minute == alarmMinute && AmOrPm().equals(amPmButton) && !snoozePressed && !dismissPressed) {
      alarmRinging = true;
    }
    if (alarmRinging && !snoozePressed && !dismissPressed) {
      fill(255);
      rect(dialogX + 25, dialogY + 150, 250, 100); // draw dialog box
      rect(dialogX + 25, dialogY + 150 + 60, 125, 40); // snooze button
      snooze.rec(dialogX + 25, dialogY + 150 + 60, 125, 40);
      snooze.listen("RECTANGLE");
      fill(255);
      rect(dialogX + 25 + 125, dialogY + 150 + 60, 125, 40); // dismiss button
      dismiss.rec(dialogX + 25 + 125, dialogY + 150 + 60, 125, 40);
      dismiss.listen("RECTANGLE");
      fill(0);
      textFont(r.schedule);
      textSize(32);
      text("Wake Up!", (dialogX + 25 + 125) - textWidth("Wake Up!")/2, dialogY + 190);
      textSize(24);
      text("Snooze", (dialogX + 25 + 125/2) - textWidth("Snooze")/2, dialogY + 150 + 90);
      text("Dismiss", (dialogX + 25 + 125 + 125/2) - textWidth("Dismiss")/2, dialogY + 150 + 90);
      if (filePicked) {
        customRing.play();
      } else {
        ringTone.play();
      }
    }
    if (snoozePressed && u.countDown(240000, millisTime)) { // wait for 4 mins before alarm goes off
      snoozePressed = false;
      alarmRinging = true;
    }
    if (dismissPressed && u.countDown(60000, millisTime)) {
     dismissPressed = false; // stops this boolean from preventing the alarm from ringing the next day
    }
  }
}


void exitDialog() {
  alarmPressed = false;
  wrongFile = false;
  amPmPressed = false;
  hourPressed = false;
  minPressed = false;
  if (filePicked) {
    customRing.rewind();
    customRing.pause();
  } else {
    ringTone.rewind();
    ringTone.pause();
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


String AmOrPm() {
  if (cal.get(Calendar.HOUR_OF_DAY) >= 12) {
    return "PM";
  } else if (cal.get(Calendar.HOUR_OF_DAY) < 12) {
    return "AM";
  } else {
    return "ERROR";
  }
}


void setAlarm(boolean b) { // will draw a dialog to set the alarm clock time if the alarm button has been pressed using the boolean parameter of the function
  if (b) {
    fill(255);
    rect(dialogX, dialogY, 300, 400); // draw dialog box
    rect(dialogX + 25, dialogY + 75, 50, 40); // draw box for adjusting hour
    rect(dialogX + 225, dialogY + 75, 50, 40); // draw box for adjusting min
    rect(dialogX + 85, dialogY + 75, 130, 40);
    //amPm.rec(dialogX + 85, dialogY + 75, 130, 40);
    //amPm.listen("RECTANGLE");
    triangle(dialogX + 85, dialogY + 70, dialogX + 85 + 130, dialogY + 70, dialogX + 85 + 65, dialogY + 40);
    alarmUp.tri(dialogX + 85, dialogY + 70, dialogX + 85 + 130, dialogY + 70, dialogX + 85 + 65, dialogY + 40);
    alarmUp.listen("TRIANGLE");
    fill(255);
    triangle(dialogX + 85, dialogY + 75 + 45, dialogX + 85 + 130, dialogY + 75 + 45, dialogX + 85 + 65, (dialogY + 75 + 45) + 30);
    alarmDown.tri(dialogX + 85, dialogY + 75 + 45, dialogX + 85 + 130, dialogY + 75 + 45, dialogX + 85 + 65, (dialogY + 75 + 45) + 30);
    alarmDown.listen("TRIANGLE");
    fill(255);
    rect(dialogX + 10, dialogY + 200, 280, 40);
    if (!wrongFile) {
      chooseRing.rec(dialogX + 10, dialogY + 200, 280, 40);
      chooseRing.listen("RECTANGLE");
    }
    noStroke();
    noFill();
    ellipse((dialogX + 150), dialogY + 285, 50, 50);
    playPause.circle((dialogX + 150), dialogY + 285, 50);
    playPause.listen("CIRCLE");
    if (!isPlaying) {
      shape(r.play, (dialogX + 150) - 25, dialogY + 260, 50, 50); 
    } else{
      shape(r.pause, (dialogX + 150) - 25, dialogY + 260, 50, 50);
    }
    stroke(5);
    fill(255);
    rect(dialogX + 10, dialogY + 350, 280, 40);
    setAlarm.rec(dialogX + 10, dialogY + 350, 280, 40);
    setAlarm.listen("RECTANGLE");
    fill(0);
    textFont(r.schedule);
    textSize(32);
    text("Choose Ring Tone!", (dialogX + 150) - textWidth("Choose Ring Tone!")/2, dialogY + 230);
    text("Set Alarm!", (dialogX + 150) - textWidth("Set Alarm!")/2, dialogY + 380);
    println("AM PM Button: " + amPmPressed);
    if (!amPmPressed) {
      fill(0);
      textFont(r.schedule);
      textSize(32);
      text(AmOrPm(), (dialogX + 150) - textWidth(AmOrPm())/2, dialogY + 108);
    } else if (amPmPressed) {
      fill(0);
      textFont(r.schedule);
      textSize(32);
      text(amPmDisplay[amPm], (dialogX + 150) - textWidth(amPmButton)/2, dialogY + 108);
    }
    if (!hourPressed && !minPressed) {
      textFont(r.schedule);
      hourInput = u.hour;
      minInput = u.minute;
      fill(0);
      textSize(14);
      text("HOUR", (dialogX + 50) - textWidth("HOUR")/2, dialogY + 100); // center hour and min text
      text("MIN", (dialogX + 250) - textWidth("MIN")/2, dialogY + 100);
    } else {
      fill(0);
      textFont(r.schedule);
      textSize(16);
      text(hourInput, (dialogX + 50) - textWidth(Integer.toString(hourInput))/2, dialogY + 100); // center hour input text
      text(minInput, (dialogX + 250) - textWidth(Integer.toString(minInput))/2, dialogY + 100);
    }
    if (hourPressed || minPressed || amPmPressed) {
      // add alarm preview time
      fill(0);
      textFont(r.schedule);
      textSize(16);
      if (!amPmPressed) {
        if (minInput < 10) {
          fill(0);
          text("Alarm Time: " + hourInput + ":0" + minInput + " " + AmOrPm(), (dialogX + 150) - textWidth("Alarm Time: "+ hourInput + ":" + minInput + " " + amPmButton)/2, dialogY + 165); 
        } else {
          text("Alarm Time: " + hourInput + ":" + minInput + " " + AmOrPm(), (dialogX + 150) - textWidth("Alarm Time: "+ hourInput + ":" + minInput + " " + amPmButton)/2, dialogY + 165);  
        }
      } else {
        if (minInput < 10) {
          text("Alarm Time: " + hourInput + ":0" + minInput + " " + amPmDisplay[amPm], (dialogX + 150) - textWidth("Alarm Time: "+ hourInput + ":" + minInput + " " + amPmButton)/2, dialogY + 165);
        } else {
          text("Alarm Time: " + hourInput + ":" + minInput + " " + amPmDisplay[amPm], (dialogX + 150) - textWidth("Alarm Time: "+ hourInput + ":" + minInput + " " + amPmButton)/2, dialogY + 165); 
        }
      }
    }
    fill(255);
    triangle(dialogX + 25, dialogY + 70, dialogX + 75, dialogY + 70, dialogX + 50, dialogY + 50);
    hourUp.tri(dialogX + 25, dialogY + 70, dialogX + 75, dialogY + 70, dialogX + 50, dialogY + 50);
    hourUp.listen("TRIANGLE");
    fill(255);
    triangle(dialogX + 25, dialogY + 75 + 45, dialogX + 75, dialogY + 75 + 45, dialogX + 50, dialogY + 75 + 65);
    hourDown.tri(dialogX + 25, dialogY + 75 + 45, dialogX + 75, dialogY + 75 + 45, dialogX + 50, dialogY + 75 + 65);
    hourDown.listen("TRIANGLE");
    fill(255);
    triangle(dialogX + 225, dialogY + 70, dialogX + 275, dialogY + 70, dialogX + 250, dialogY + 50);
    minUp.tri(dialogX + 225, dialogY + 70, dialogX + 275, dialogY + 70, dialogX + 250, dialogY + 50);
    minUp.listen("TRIANGLE");
    fill(255);
    triangle(dialogX + 225, dialogY + 70 + 50, dialogX + 275, dialogY + 70 + 50, dialogX + 250, dialogY + 140);
    minDown.tri(dialogX + 225, dialogY + 70 + 50, dialogX + 275, dialogY + 70 + 50, dialogX + 250, dialogY + 140);
    minDown.listen("TRIANGLE");
    fill(0);
    textFont(r.schedule);
    textSize(32);
    text("Set Alarm Time:", dialogX + 25, 80);
    textSize(16);
    rect(dialogX + 265, dialogY, 35, 20); // draw button to exit the dialog
    exitDialog.rec(dialogX + 265, dialogY, 35, 20);
    exitDialog.listen("RECTANGLE");
    fill(0);
    text("X", dialogX + 278, dialogY + 15);
    if (wrongFile) {
      // draw wrong file dialog to handle the error where the user does note select mp3 file
      fill(255);
      rect(dialogX + 25, dialogY + 150, 250, 100); // draw dialog box
      rect(dialogX + 25, dialogY + 150 + 60, 125, 40); // cancel button
      cancel.rec(dialogX + 25, dialogY + 150 + 60, 125, 40);
      cancel.listen("RECTANGLE");
      fill(255);
      rect(dialogX + 150, dialogY + 210, 125, 40);
      ok.rec(dialogX + 150, dialogY + 210, 125, 40);
      ok.listen("RECTANGLE");
      fill(0);
      textSize(32);
      text("Cancel", (dialogX + 25 + 62.5) - textWidth("Cancel")/2, dialogY + 150 + 90);
      text("Ok", (dialogX + 150 + 62.5) - textWidth("Ok")/2, dialogY + 240);
      textSize(16);
      text("Error: Please Choose an MP3 File", (dialogX + 150) - textWidth("Error: Please Choose an MP3 File")/2, dialogY + 170);
    }
    if (filePicked) {
      fill(0);
      textSize(16);
      text("Ring Tone: " + fileName, (dialogX + 150) - textWidth("Ring Tone: " + fileName)/2, dialogY + 190);
    }
  }
}


String[] getSchedule(int d) {
  String[] schedule = new String[5];
  if (d == 1) {
   schedule[1] = "Comm. Tech";
   schedule[2] = "Gym";
   schedule[3] = "English";
   schedule[4] = "Instrumental";
  }
  if (d == 2) {
   schedule[1] = "Science";
   schedule[2] = "Software";
   schedule[3] = "French";
   schedule[4] = "Math";
  }
  if (d == 3) {
   schedule[1] = "Instrumental";
   schedule[2] = "Gym";
   schedule[3] = "English";
   schedule[4] = "Comm. Tech";
  }
  if (d == 4) {
   schedule[1] = "Math";
   schedule[2] = "Software";
   schedule[3] = "French";
   schedule[4] = "Science";
  }
  return schedule;
}


void drawSlides(int s) {
  if (s == 0) { // code for slide 0 and the following if statements will represent a particular slide as well
    textFont(r.time);
    fill(0);
    textSize(128);
    text(u.get12HourTime(), width/2 - textWidth(u.get12HourTime())/2, height/2); // draw the time
    textSize(32); // draw the date
    text(u.theDate, 400 - textWidth(u.theDate)/2, 300);
    noFill();
    noStroke();
    ellipse(725, 425, 60, 60); // draw circle that will act as the button for the alarm clock
    alarm.circle(725, 425, 60);
    alarm.listen("CIRCLE");
    shape(r.alarmClock, 700, 400, 50, 50); // draw alarm clock icon for user to pick the alarm time
    stroke(5);
    fill(0);
    setAlarm(alarmPressed);
  }
  if (s == 1) {
    println("changePressed " + changePressed);
    println("dateChanged " + dateChanged);
    println(changedDayNum);
    if (!changePressed) {
      monthInput = u.month;
      dayInput = u.day;
    }
    textFont(r.schedule);
    fill(0);
    textSize(48);
    text("School Schedule:", width/2 - textWidth("School Schedule:")/2, 75);
    textSize(32);
    fill(255);
    if (!dateChanged) {
      rect(r.CD[0], r.CD[1], r.CD[2], r.CD[3]); // change date rect button
      changeDate.rec(r.CD[0], r.CD[1], r.CD[2], r.CD[3]);
      changeDate.listen("RECTANGLE"); 
      fill(0);
      textSize(20);
      text("Change Date", r.CD[0] + 3, r.CD[0]);
    }
    if (changePressed && !dateChanged) {
      fill(255);
      rect(r.monthBox[0], r.monthBox[1], r.monthBox[2], r.monthBox[3]); // month display box
      rect(r.monthBox[0], r.monthBox[1] + 50, r.monthBox[2] - 60, r.monthBox[3]); // day display box
      fill(0);
      textSize(22);
      text(dayInput, r.monthBox[0] + 5, r.monthBox[1] + 75); // day display text
      text(u.getMonth(monthInput), r.monthBox[0] + 5, r.monthBox[1] + 25); // month display text
      fill(255);
      // draw triangular buttons to adjust the date and connect them to OnClickListeners
      triangle(r.mUP[0], r.mUP[1], r.mUP[2], r.mUP[3], r.mUP[4], r.mUP[5]);
      monthUp.tri(r.mUP[0], r.mUP[1], r.mUP[2], r.mUP[3], r.mUP[4], r.mUP[5]);
      monthUp.listen("TRIANGLE");
      triangle(r.mDown[0], r.mDown[1], r.mDown[2], r.mDown[3], r.mDown[4], r.mDown[5]);
      monthDown.tri(r.mDown[0], r.mDown[1], r.mDown[2], r.mDown[3], r.mDown[4], r.mDown[5]);
      monthDown.listen("TRIANGLE");
      triangle(r.dayUP[0], r.dayUP[1], r.dayUP[2], r.dayUP[3], r.dayUP[4], r.dayUP[5]);
      dayUp.tri(r.dayUP[0], r.dayUP[1], r.dayUP[2], r.dayUP[3], r.dayUP[4], r.dayUP[5]);
      dayUp.listen("TRIANGLE");
      triangle(r.mDown[0] - 60, r.mDown[1] + 50, r.mDown[2] - 60, r.mDown[3] + 50, r.mDown[4] - 60, r.mDown[5] + 50);
      dayDown.tri(r.mDown[0] - 60, r.mDown[1] + 50, r.mDown[2] - 60, r.mDown[3] + 50, r.mDown[4] - 60, r.mDown[5] + 50);
      dayDown.listen("TRIANGLE");
      // draw enter button to enter the date
      rect(r.CD[0] + 250, r.CD[1] + 50, r.CD[2], r.CD[3]);
      enterDate.rec(r.CD[0] + 250, r.CD[1] + 50, r.CD[2], r.CD[3]);
      enterDate.listen("RECTANGLE");
      fill(0);
      textSize(28);
      text("Enter!", r.CD[0] + 275, r.CD[1] + 80);
    }
    if (dayNum == 9 && !changePressed && !dateChanged) {
      textSize(48);
      fill(0);
      text("It's A Holiday!", width/2 - textWidth("It's A Holiday!")/2, 175);
    }
    if (changedDayNum == 9 && dateChanged) {
      textSize(48);
      fill(0);
      text("It's A Holiday!", width/2 - textWidth("It's A Holiday!")/2, 175);
    }
    if (dateChanged) {
      rect(width/2 - r.CD[2]/2, r.CD[1] + 50, r.CD[2], r.CD[3]); // rect button with same coordinates as change date button but will be used to be returned to the current date
      today.rec(width/2 - r.CD[2]/2, r.CD[1] + 50, r.CD[2], r.CD[3]);
      today.listen("RECTANGLE");
      fill(0);
      textSize(28);
      text("Today", width/2 - textWidth("Today")/2, r.CD[1] + 80);
    }
    if (dateChanged && changedDayNum != 9) {
      textSize(32);
      fill(0);
      text("P1: " + getSchedule(changedDayNum)[1] + p1Time, width/2 - textWidth("P1: " + getSchedule(changedDayNum)[1] + p1Time)/2, 175); // display schedule strings onscreen
      text("P2: " + getSchedule(changedDayNum)[2] + p2Time, width/2 - textWidth("P2: " + getSchedule(changedDayNum)[2] + p2Time)/2, 225);
      text("P3: " + getSchedule(changedDayNum)[3] + p3Time, width/2 - textWidth("P3: " + getSchedule(changedDayNum)[3] + p3Time)/2, 275);
      text("P4: " + getSchedule(changedDayNum)[4] + p4Time, width/2 - textWidth("P4: " + getSchedule(changedDayNum)[4] + p4Time)/2, 325);
    } else if (!dateChanged && dayNum != 9) {
      textSize(32);
      fill(0);
      text("P1: " + getSchedule(dayNum)[1] + p1Time, width/2 - textWidth("P1: " + getSchedule(dayNum)[1] + p1Time)/2, 175); // display schedule strings onscreen
      text("P2: " + getSchedule(dayNum)[2] + p2Time, width/2 - textWidth("P2: " + getSchedule(dayNum)[2] + p2Time)/2, 225);
      text("P3: " + getSchedule(dayNum)[3] + p3Time, width/2 - textWidth("P3: " + getSchedule(dayNum)[3] + p3Time)/2, 275);
      text("P4: " + getSchedule(dayNum)[4] + p4Time, width/2 - textWidth("P4: " + getSchedule(dayNum)[4] + p4Time)/2, 325);
    }
  }

  if (s == 2) { // extra carriculars
    textFont(r.schedule);
    textSize(48);
    fill(0);
    text("Extracurricular Activities", width/2 - textWidth("Extracurricular Activities")/2, 75);
    textSize(32);
    for (int i = 0; i < u.getDays().length; i++) { // for loop iterating through the array instead of writing text function over and over
      text(u.getDays()[i] + u.getExtras()[i], width/2 - textWidth(u.getDays()[i] + u.getExtras()[i])/2, 150 + i*50); // add 150 to i for y coordinate and multiply by 50 to start the y at 150 and add 50 each time
    }
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
    text(u.getForecast()[timesPressed][2] + "°", r.highArrow[0] - textWidth(u.getForecast()[0][2])/2 - 37, r.highArrow[1] + 35); // draw highs and lows for the day
    text(u.getForecast()[timesPressed][3] + "°", r.lowArrow[0] + textWidth(u.getForecast()[0][3])/2 + 37, r.lowArrow[1] + 35);
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