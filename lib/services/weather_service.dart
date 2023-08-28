import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weathe/models/weather_model.dart';

class WeatherService {
  Future<Weather_model> getWeather({required String cityName}) async {
    String baseUrl = 'http://api.weatherapi.com/v1';
    String apiKey = '3149bab54266418b932112125232004';
    Uri url =
        Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=3');
    http.Response response = await http.get(url);

    if (response.statusCode == 400) {
      var data = jsonDecode(response.body);
      throw Exception(data['error']['message']);
    }
    Map<String, dynamic> data = jsonDecode(response.body);

    Weather_model weathern = Weather_model.fromjson(data);
    return weathern;
  }
}
