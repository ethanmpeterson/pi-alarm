import java.net.*; // import java net libraries for access to classes like URL and URI
import java.io.*; // import java io libraries for access to file class

class Weather {
  private XML weather;
  File f;
  URL u;
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
    url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22" + city + "%2C%20" + provCode + "%22)&format=xml&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";
    weather = loadXML(url); // loads XML file with the weather from Yahoo feed
    if (weather != null) { // only load the xml file if the link works in case yahoo is down
     xmlAvailable = true;
     forecast = weather.getChildren("results/channel/item/yweather:forecast");
    } else {
     xmlAvailable = false;
    } 
  }
  
  
  public boolean xmlAvail() { // functions allowing me to check if the weather xml file exists outside the class
    return xmlAvailable;
  }
  
  
  public void updateXML() { // will be called in PiAlarm every hour to get the latest weather feed from Yahoo
     if (xmlAvailable) { // only load the xml file if the link works in case yahoo is down
       xmlAvailable = true;
       weather = loadXML(url); // loads XML file with the weather from Yahoo feed
       forecast = weather.getChildren("results/channel/item/yweather:forecast");
     } else {
       xmlAvailable = false;
    }
  }
  
  
  public int getTemp() { // gets current temperature
    currentTemp = weather.getChild("results/channel/item/yweather:condition").getInt("temp");
    return currentTemp;
  }
  
  
  //public String[] getWeather() { // will return weather conditions of the very moment
  //  String currentW[] = weather.getChildren("results/channel/item/yweather:condition");
  //  return currentW;
  //}
  
  
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
        dayForecast[j][2] = Float.toString(F2C(high[j])); // add toString function as high array is of type float and so is the low array also uses the F2C function to get Celsius temp
        dayForecast[j][3] = Float.toString(F2C(low[j]));
      }
    }
    return dayForecast;
  }


  private float F2C(float f) { // will convert farenheit temps from XML to Celcius takes farenheit degree as input
    float celsius = 5 * (f - 32)/9;
    return celsius;
  }
}