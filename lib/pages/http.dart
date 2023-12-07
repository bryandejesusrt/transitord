import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transitord/pages/WeatherModel.dart';

class Weather {
  Future<WeatherModel>? getWeather(String? location) async {
    var endpoint = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=ef79ea7210219e271874cfbce8306bcd&units=metric');
    var respone = await http.get(endpoint);
    var body = jsonDecode(respone.body);
    return WeatherModel.fromjson(body);
  }
}
