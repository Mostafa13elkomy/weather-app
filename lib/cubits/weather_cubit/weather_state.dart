import 'package:weathe/models/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSucsess extends WeatherState {
  Weather_model weatherModel;
  WeatherSucsess({required this.weatherModel});
}

class WeatherFailur extends WeatherState {}
