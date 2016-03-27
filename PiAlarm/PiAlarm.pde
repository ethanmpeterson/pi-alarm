Slide1 s1;
void setup() {
  size(800, 480);
  background(255);
  PFont time = createFont("fonts/timeFont.ttf", 64);
  frameRate(60);
  textFont(time);
  s1 = new Slide1();
}

void draw() {
  background(255);
  s1.update();
  s1.drawSlide();
}
