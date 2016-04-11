class Weather {
  private XML weather;
  private String forecast; // stores the weather forecast from Yahoo API
  private int temp;
  private String humidity;
  private String weatherCode;
  private String url; // stores url of XML file + weather code
  
  void Weather(String wCode) { // called when weather object is created  wCode parameter takes the weather code for your city user will evantually be able to set this
    weather = loadXML("http://xml.weather.yahoo.com/forecastrss?p=" + wCode); // loads XML file with the weather from Yahoo feed
    wCode = weatherCode;
    url = "http://xml.weather.yahoo.com/forecastrss?p=" + wCode;
  }
  
  
  public void updateWeatherXML() { // will be called in PiAlarm every hour to get the latest weather feed from Yahoo
    weather = loadXML(url);
  }
  
  
  public int getTemp() { // gets current temperature
    temp = weather.getChild("channel/item/yweather:condition").getInt("temp");
    return temp;
  }
  
  
  public int high() { // gets high temp for the day
  
  }
  
  public int low() { // gets low of the day
  
  }
  
  
  String forecast() {
  
  }
  
  
  private float Farenheit2Celcius() { // will convert farenheit temps from XML to Celcius
  
  }
}