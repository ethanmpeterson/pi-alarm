interface Triangle {
  void tri(float x1, float y1, float x2, float y2, float x3, float y3);
}

interface Rectangle {
  void rec(float x, float y, float rwidth, float rheight);
}

interface Circle {
  void circle(float x, float y, float diameter);
}

interface Buttons {
  void makeRectButton(String text, float x, float y, float rwidth, float rheight);
  void makeTriButton(float x1, float y1, float x2, float y2, float x3, float y3);
  void makeCircleButton(float x, float y, float diameter);
}

interface WeatherUtils {
  boolean xmlAvail();
  void updateXML();
  int getTemp();
  String getWeather();
  String[][] getForecast();
}

interface TimeUtils {
  String getMonth(int m);
  String getWeekDay(int w);
  String get12HourTime();
}