import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe/cubits/weather_cubit/weather_cubit.dart';
import 'package:weathe/cubits/weather_cubit/weather_state.dart';
import 'package:weathe/models/weather_model.dart';
import 'package:weathe/pages/search_page.dart';


class HomePage extends StatelessWidget {
  Weather_model? weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 151, 223, 151) ,
      appBar: AppBar(
        backgroundColor: BlocProvider.of<WeatherCubit>(context).weatherModel == null? Color.fromARGB(255, 151, 223, 151) : BlocProvider.of<WeatherCubit>(context).weatherModel!.getThemeColor(),
        title: Text(
          'Weather App',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchPage();
                }));
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              )),
          SizedBox(
            width: 22,
          )
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherSucsess) {
            weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
            return SucsessBody(weatherData: state.weatherModel);
          } else if (state is WeatherFailur) {
            return Center(
              child: Text('something went  wrong , please try again '),
            );
          } else {
            return InitialBage();
          }
        },
      ),
    );
  }
}

class InitialBage extends StatelessWidget {
  const InitialBage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'there is no weather 😔',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              'searching now 🔍',
              style: TextStyle(
                fontSize: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SucsessBody extends StatelessWidget {
  const SucsessBody({
    super.key,
    required this.weatherData,
  });

  final Weather_model? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          weatherData!.getThemeColor(),
          weatherData!.getThemeColor()[500]!,
          weatherData!.getThemeColor()[100]!,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 4,
          ),
          Text(
            BlocProvider.of<WeatherCubit>(context).cityName!,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            weatherData!.temp!.toInt().toString(),
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Text(
            'max temp:${weatherData!.maxTemp?.toInt()} ',
            style: TextStyle(fontSize: 20),
          ),
          Text('min temp:${weatherData!.minTemp?.toInt()}',
              style: TextStyle(fontSize: 20)),
          Spacer(
            flex: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(weatherData!.getImage()),
              Text(
                weatherData?.weatherStateName ?? '',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [],
              )
            ],
          ),
          Spacer(),
          const Spacer(
            flex: 6,
          )
        ],
      ),
    );
  }
}
