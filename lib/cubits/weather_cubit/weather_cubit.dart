import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe/cubits/weather_cubit/weather_state.dart';
import 'package:weathe/models/weather_model.dart';
import 'package:weathe/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherService) : super(WeatherInitial());
  WeatherService weatherService;
  String? cityName;
  Weather_model? weatherModel;
  void getWeather({required String cityName}) async {
    emit(WeatherLoading());
    try {
      weatherModel = await weatherService.getWeather(cityName: cityName);
      emit(WeatherSucsess(weatherModel: weatherModel!));
    } catch (e) {
      emit(WeatherFailur());
    }
  }
}
