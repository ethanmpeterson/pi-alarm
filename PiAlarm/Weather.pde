class Weather {
  private XML weather;
  private int currentTemp; // string storing current temperature returned by getTemp()
  private String url; // stores url of XML file + city and province
  private int arraySize = 10; // will be int to store the array size because all the arrays to do with the forecast should be the same size
  private String[] day = new String[arraySize]; // array to store day of the week for the weather forecast
  private int[] low = new int[arraySize]; // 5 slots for each day of the week in the forecast of the low temps
  private int[] high = new int[arraySize]; // array of high daily temps in the forecast
  private String[] text = new String[arraySize]; // will hold comment on forecast ex. "AM Showers"
  // current the length of the all forecast arrays is 5
  XML[] forecast; // XML array storing the forecast for each 
  
  public Weather (String city, String provCode) { // called when weather object is created city parameter will take city name ex. Toronto and provCode will take the province ex. ON
    weather = loadXML("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22" + city + "%2C%20" + provCode + "%22)&format=xml&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"); // loads XML file with the weather from Yahoo feed
    url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22" + city + "%2C%20" + provCode + "%22)&format=xml&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";
    forecast = weather.getChildren("results/channel/item/yweather:forecast");
  }
  
  
  public void updateWeatherXML() { // will be called in PiAlarm every hour to get the latest weather feed from Yahoo
    weather = loadXML(url); // update XML file and forecast
    forecast = weather.getChildren("results/channel/item/yweather:forecast");
  }
  
  
  public int getTemp() { // gets current temperature
    currentTemp = weather.getChild("results/channel/item/yweather:condition").getInt("temp");
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
    String[][] dayForecast = new String[arraySize][arraySize]; // first axis of the array will be the day and second will be the component of forecast you wish to access ex. high temp for the day
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