import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe/cubits/weather_cubit/weather_cubit.dart';

class SearchPage extends StatelessWidget {
  String? cityName;
  SearchPage({this.updateui});
  VoidCallback? updateui;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 151, 223, 151),
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 151, 223, 151),
        title: const Text(
          'Search a City',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              cityName = data;
              BlocProvider.of<WeatherCubit>(context)
                  .getWeather(cityName: cityName!);
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;
              Navigator.pop(context);
            },
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                hintText: 'enter a city',
                border: OutlineInputBorder(),
                label: Text('search'),
                suffixIcon: Icon(Icons.search)),
          ),
        ),
      ),
    );
  }
}
