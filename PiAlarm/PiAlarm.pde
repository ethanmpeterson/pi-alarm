void setup() {
  size(800, 480);
  background(255);
  time = createFont("fonts/timeFont.ttf", 64);
  textFont(time);
  frameRate(60);
  //fullScreen(); //uncomment the line when the program is exported for the Pi
  s.x = width/2 - textWidth(theTime)/2;
}

void draw() {
  background(255);
  update();
  fill(0);
  s.slide0Left(2, width/2 - textWidth(theTime)/2);
  text(theTime, s., height/2);
}

void update() { // function will contain any variables that needed to be updated continuously
  minute = minute();
  hour = hour();
  month = month();
  year = year();
  theTime = hour + ":" + minute;
}
