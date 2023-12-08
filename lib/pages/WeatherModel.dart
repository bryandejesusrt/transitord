class WeatherModel {
  String? cityName;
  double? temp;
  double? windSpeed;
  String? weatherMain;
  String? weatherDescription;
  int? humidity;
  double? feelsLike;
  int? pressure;

  WeatherModel(
    this.cityName,
    this.temp,
    this.windSpeed,
    this.humidity,
    this.feelsLike,
    this.pressure,
    this.weatherMain,
    this.weatherDescription,
  );

  WeatherModel.fromjson(Map<String, dynamic> json) {
    cityName = json['name'];
    // windSpeed = json['wind']['speed'];
    windSpeed = json['wind']['speed'];
    temp = json['main']['temp'];
    humidity = json['main']['humidity'];
    feelsLike = json['main']['feels_like'];
    pressure = json['main']['pressure'];
    weatherMain = json['weather'][0]['main'];
    weatherDescription = json['weather'][0]['description'];
  }
}
