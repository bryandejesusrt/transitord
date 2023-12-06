class WeatherModel {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  double? feelsLike;
  int? pressure;

  WeatherModel(
    this.cityName,
    this.temp,
    this.wind,
    this.humidity,
    this.feelsLike,
    this.pressure,
  );

  WeatherModel.fromjson(Map<String, dynamic> json) {
    cityName = json['name'];
    //wind = json['wind']['speed'];
    wind = 1;
    temp = json['main']['temp'];
    humidity = json['main']['humidity'];
    feelsLike = json['main']['feels_like'];
    pressure = json['main']['pressure'];
  }
}
