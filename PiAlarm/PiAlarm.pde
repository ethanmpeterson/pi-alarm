import java.util.Calendar; // for keeping time as opposed to built in processing functions
Slide1 s1;
Calendar c;

void setup() {
  size(800, 480);
  background(255);
  PFont time = createFont("fonts/timeFont.ttf", 64);
  c = Calendar.getInstance();
  frameRate(60);
  textFont(time);
  s1 = new Slide1();
}

void draw() {
  background(255);
  s1.update();
  s1.drawSlide();
}