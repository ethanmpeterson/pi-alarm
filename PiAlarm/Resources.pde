class Resource { // stores useful public vars and assets such as sounds fonts and images
  public int slide = 0;
  public int slideNum = 4; // int stores the number of slides
  public PFont schedule; // the font used for slide 1 to show my school schedule
  public PFont time;  // grey color
  public PShape cloud;
  public PShape rain;
  public PShape sun;
  public PShape partlyCloudy;
  public PShape sunShowers;
  public PShape rainSnow;
  public PShape downArrow;
  public PShape upArrow;
  public PShape alarmClock;
  public PShape play; // play button
  public PShape pause; // pause button
  public PShape thunderStorm;
  public color buttonHighlight = color(209, 209, 209); // color buttons will change to when they have been hovered over by the cursor
  public int wIcon[] = {350, 90, 100, 100};
  public int highArrow[] = {460, 245, 40, 40};
  public int lowArrow[] = {295, 245, 40, 40};
  public int leftButton[] = {25, 480/2, 50, 480/2 + 50, 50, 480/2 - 50};
  public int rightButton[] = {800 - 25, 480/2, 800 - 50, 480/2 + 50, 800 - 50, 480/2 - 50};
  public int CD[] = {400, 375, 120, 40}; // array holding change date button rect coordinates
  public int monthBox[] = {540, 350, 120, 30};
  public float[] mUP = {665, 363, 690, 363, 665 + 25/2, 345};
  public float[] mDown = {665, 367, 690, 367, 665 + 25/2, 345 + 40};
  public float[] dayUP = {mUP[0] - 60, mUP[1] + 50, mUP[2] - 60, mUP[3] + 50, mUP[4] - 60, mUP[5] + 50};
  public final int[][] schoolYear = {
    {9, 9, 9, 9, 0, 4, 1, 2, 3, 9, 9, 4, 1, 2, 3, 4, 9, 9, 1, 2, 3, 4, 1, 9, 9, 2, 3, 4, 1, 2, 9, 9}, // January
    {9, 3, 4, 1, 2, 3, 9, 9, 4, 1, 2, 3, 9, 9, 9, 9, 4, 1, 2, 3, 9, 9, 4, 1, 2, 3, 4, 9, 9, 1},       // February
    {9, 2, 3, 4, 1, 9, 9, 2, 3, 4, 1, 2, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 3, 4, 1}, // March
    {9, 2, 9, 9, 3, 4, 1, 2, 3, 9, 9, 4, 1, 2, 3, 4, 9, 9, 1, 2, 3, 4, 1, 9, 9, 2, 3, 4, 1, 2, 9},    // April
    {9, 9, 3, 4, 1, 2, 3, 9, 9, 4, 1, 2, 3, 4, 9, 9, 1, 2, 3, 4, 1, 9, 9, 9, 2, 3, 4, 1, 9, 9, 2, 3}, // May
    {9, 4, 1, 2, 9, 9, 9, 3, 4, 1, 2, 3, 9, 9, 4, 1, 2, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9},    // June
    {9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9}, // July
    {9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9}, // August
    {9, 9, 9, 9, 9, 9, 9, 9, 9, 0, 1, 2, 9, 9, 3, 4, 1, 2, 3, 9, 9, 4, 1, 2, 3, 5, 9, 9, 4, 1, 2},    // September
    {9, 3, 4, 9, 9, 1, 2, 3, 4, 1, 9, 9, 9, 2, 3, 4, 1, 9, 9, 2, 3, 4, 1, 2, 9, 9, 3, 4, 1, 2, 3, 9}, // October
    {9, 9, 4, 1, 2, 3, 4, 9, 9, 1, 2, 3, 9, 9, 9, 9, 4, 1, 2, 3, 4, 9, 9, 1, 2, 3, 4, 1, 9, 9, 2},    // November
    {9, 3, 4, 1, 2, 9, 9, 3, 4, 1, 2, 3, 9, 9, 4, 1, 2, 3, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9}  // December
    }; //same array that is in the gecko firmware that is filled with the day calendar for 2015-2016 school year
    
    
  public void load() {
    // put all external files/assets that need to be loaded into this function
    time = createFont("assets/fonts/timeFont.ttf", 24);
    schedule = createFont("assets/fonts/OpenSans.ttf", 64);
    cloud = loadShape("assets/img/cloud.svg");
    rain = loadShape("assets/img/rain.svg");
    sun = loadShape("assets/img/sun.svg");
    partlyCloudy = loadShape("assets/img/partlyCloudy.svg");
    sunShowers = loadShape("assets/img/sunShowers.svg");
    rainSnow = loadShape("assets/img/rainSnow.svg");
    upArrow = loadShape("assets/img/upArrow.svg");
    downArrow = loadShape("assets/img/downArrow.svg");
    alarmClock = loadShape("assets/img/alarmClock.svg");
    play = loadShape("assets/img/play.svg");
    pause = loadShape("assets/img/pause.svg");
    thunderStorm = loadShape("assets/img/thunderStorm.svg");
  }
}