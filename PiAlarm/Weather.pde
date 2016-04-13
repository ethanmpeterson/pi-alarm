class Weather {
  private XML weather;
  private int currentTemp; // string storing current temperature returned by getTemp()
  private String weatherCode; // weather code for the particular city/region each place has a unique weather code
  private String url; // stores url of XML file + weather code
  private String[] day = new String[5]; // array to store day of the week for the weather forecast
  private int[] low = new int[5]; // 5 slots for each day of the week in the forecast of the low temps
  private int[] high = new int[5]; // array of high daily temps in the forecast
  private String[] text = new String[5]; // will hold comment on forecast ex. "AM Showers"
  private int arraySize = 5; // will be int to store the array size because all the arrays to do with the forecast should be the same size
  // current the length of the all forecast arrays is 5
  XML[] forecast; // XML array storing the forecast for each 
  
  public Weather (String wCode) { // called when weather object is created  wCode parameter takes the weather code for your city user will evantually be able to set this
    weather = loadXML("http://xml.weather.yahoo.com/forecastrss?p=" + wCode); // loads XML file with the weather from Yahoo feed
    wCode = weatherCode;
    url = "http://xml.weather.yahoo.com/forecastrss?p=" + wCode;
    forecast = weather.getChildren("channel/item/yweather:forecast");
  }
  
  
  public void updateWeatherXML() { // will be called in PiAlarm every hour to get the latest weather feed from Yahoo
    weather = loadXML(url); // update XML file and forecast
    forecast = weather.getChildren("channel/item/yweather:forecast");
  }
  
  
  public int getTemp() { // gets current temperature
    currentTemp = weather.getChild("channel/item/yweather:condition").getInt("temp");
    return currentTemp;
  }
  
  
  public String[][] getForecast() { // function returns array of type String that is demensions meaning it is like a matrix
    for (int i = 0; i < arraySize; i++) { // indexes weather forecast for the next 5 days into arrays
      day[i] = forecast[i].getString("day");  // fill local arrays with data from the XML file for easier access
      low[i] = forecast[i].getInt("low");
      high[i] = forecast[i].getInt("high");
      text[i] = forecast[i].getString("text");
    }
    //                      5x5 array would give a total of 25 spaces
    String[][] dayForecast = new String[5][5]; // first axis of the array will be the day and second will be the component of forecast you wish to access ex. high temp for the day
    for (int j = 0; j < arraySize; j++) { // fills the first row with the day
      dayForecast[j][0] = day[j];
      dayForecast[j][1] = text[j];
      dayForecast[j][2] = Integer.toString(high[j]); // add toString function as high array is of type int and so is the low array
      dayForecast[j][3] = Integer.toString(low[j]);
    }
    return dayForecast;
  }
  
  
  private float Fahrenheit2Celsius(float f) { // will convert farenheit temps from XML to Celcius takes farenheit degree as input
    float celsius = 5 * (f - 32)/9;
    return celsius;
  }
}