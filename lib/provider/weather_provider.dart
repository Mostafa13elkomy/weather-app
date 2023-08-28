import 'package:flutter/material.dart';
import 'package:weathe/models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  Weather_model? _weatherData;
  String? cityName;
  set weatherData(Weather_model? weather) {
    _weatherData = weather;
    notifyListeners();
  }

  Weather_model? get weatherData => _weatherData;
}
