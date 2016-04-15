interface Triangle {
  void tri(float x1, float y1, float x2, float y2, float x3, float y3);
}

interface Rectangle {
  void rect(float x, float y, float width, float height);
}

interface Circle {
  void circle(float x, float y, float diameter);
}

interface Buttons {
  void makeRectButton(String text, float x, float y, float width, float height);
  void makeTriButton(float x1, float y1, float x2, float y2, float x3, float y3);
  void makeCircleButton(float x, float y, float diameter);
}

interface weatherUtils {
  
}

interface Time {
  String getMonth(int m);
  String getWeekDay(int w);
  String get12HourTime();
}