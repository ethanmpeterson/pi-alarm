class Weather {
  private XML weather;
  private boolean xmlAvailable;
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
    url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22" + city + "%2C%20" + provCode + "%22)%20and%20u%3D'c'&format=xml&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";
    try { // tries a line of code allowing an error in this case NullPointer Exception to be caught and handled
      weather = loadXML(url); // loads XML file with the weather from Yahoo feed
      xmlAvailable = true; // will stay true if there is no NullPointerException
      forecast = weather.getChildren("results/channel/item/yweather:forecast");
    } catch (NullPointerException e) {
      println("weather XML is null");
      xmlAvailable = false;
    }
    println(xmlAvailable);
  }


  public boolean xmlAvail() { // functions allowing me to check if the weather xml file exists outside the class
    return xmlAvailable;
  }


  public void updateXML() { // will be called in PiAlarm every hour to get the latest weather feed from Yahoo
    try { // tries a line of code allowing an error in this case NullPointer Exception to be caught and handled
      weather = loadXML(url); // loads XML file with the weather from Yahoo feed
      xmlAvailable = true; // will stay true if there is no NullPointerException
      forecast = weather.getChildren("results/channel/item/yweather:forecast");
    } catch (NullPointerException e) {
        println("weather XML is null");
        xmlAvailable = false;
    }
      println(xmlAvailable);
    }


  public int getTemp() { // gets current temperature
    currentTemp = weather.getChild("results/channel/item/yweather:condition").getInt("temp");
    return currentTemp;
  }


  public String getWeather() { // will return weather conditions of the very moment
    return weather.getChild("results/channel/item/yweather:condition").getString("text");
  }


  public String[][] getForecast() { // function returns array of type String that is demensions meaning it is like a matrix which is filled with the week's forecast
  //                      5x5 array would give a total of 25 spaces
    String[][] dayForecast = new String[arraySize][arraySize]; // first axis of the array will be the day and second will be the component of forecast you wish to access ex. high temp for the day
    for (int i = 0; i < forecast.length; i++) { // indexes weather forecast for the next 5 days into arrays
      day[i] = forecast[i].getString("day");  // fill local arrays with data from the XML file for easier access
      low[i] = forecast[i].getInt("low");
      high[i] = forecast[i].getInt("high");
      text[i] = forecast[i].getString("text");
      for (int j = 0; j < arraySize; j++) {
        dayForecast[j][0] = day[j];
        dayForecast[j][1] = text[j];
        dayForecast[j][2] = Integer.toString(high[j]); // add toString function as high array is of type float and so is the low array also uses the F2C function to get Celsius temp
        dayForecast[j][3] = Integer.toString(low[j]);
      }
    }
    return dayForecast;
  }
}