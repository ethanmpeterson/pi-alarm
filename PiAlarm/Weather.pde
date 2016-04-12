class Weather {
  private XML weather;
  private int currentTemp; // string storing current temperature returned by getTemp()
  private String weatherCode; // weather code for the particular city/region each place has a unique weather code
  private String url; // stores url of XML file + weather code
  private String[] day = new String[5]; // array to store day of the week for the weather forecast
  private int[] low = new int[5]; // 5 slots for each day of the week in the forecast of the low temps
  private int[] high = new int[5]; // array of high daily temps in the forecast
  private String[] text = new String[5]; // will hold comment on forecast ex. "AM Showers"
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
    for (int i = 0; i < forecast.length; i++) { // indexes weather forecast for the next 5 days into arrays
      day[i] = forecast[i].getString("day");  // fill local arrays with data from the XML file for easier access
      low[i] = forecast[i].getInt("low");
      high[i] = forecast[i].getInt("high");
      text[i] = forecast[i].getString("text");
    }
    //                      5x5 array would give a total of 25 spaces
    String[][] dayForecast = new String[5][5]; // first axis of the array will be the day and second will be the component of forecast you wish to access ex. high temp for the day
    for (int j = 0; j < day.length; j++) { // fills the first row with the day
      dayForecast[j][0] = day[j];
    }
    for (int z = 0; z < text.length; z++) { // fills the array with text for the particular day
      dayForecast[z][1] = text[z];
    }
    for (int k = 0; k < high.length; k++) { // fills array with high temps for the particular day
      dayForecast[k][2] = Integer.toString(high[k]); // add to string function as high array is of type int and so is the low array uses
    }
    for (int l = 0; l < low.length; l++) { // fills array
      dayForecast[l][3] = Integer.toString(low[l]);
    }
    return dayForecast;
  }
  
  
  //private float Farenheit2Celcius() { // will convert farenheit temps from XML to Celcius
  
  //}
}