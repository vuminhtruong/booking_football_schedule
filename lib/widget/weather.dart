import 'package:booking_football_schedule/helper/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../models/weather_model.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<WeatherWidget> createState() {
    return _WeatherWidgetState();
  }
}

class _WeatherWidgetState extends State<WeatherWidget> {
  int hour = DateTime.now().hour;
  final _weatherService = WeatherService();
  Weather? _weather;

  _fetchWeather() async {
    try {
      final weather = await _weatherService.getWeather();
      setState(() {
        _weather = weather;
      });
    } catch (error) {
      print(error);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      if (hour < 19) {
        return 'assets/weather/clear.json';
      } else {
        return 'assets/weather/night.json';
      }
    }

    if (hour < 19) {
      switch (mainCondition.toLowerCase()) {
        case 'clouds':
          return 'assets/weather/few_clouds.json';
        case 'mist':
          return 'assets/weather/few_clouds.json';
        case 'smoke':
          return 'assets/weather/few_clouds.json';
        case 'haze':
          return 'assets/weather/few_clouds.json';
        case 'dust':
          return 'assets/weather/few_clouds.json';
        case 'fog':
          return 'assets/weather/few_clouds.json';
        case 'rain':
          return 'assets/weather/rain.json';
        case 'drizzle':
          return 'assets/weather/rain.json';
        case 'shower rain':
          return 'assets/weather/shower_rain.json';
        case 'thunderstorm':
          return 'assets/weather/thunderstorm.json';
        case 'clear':
          return 'assets/weather/clear.json';
        default:
          return 'assets/weather/clear.json';
      }
    } else {
      switch (mainCondition.toLowerCase()) {
        case 'clouds':
          return 'assets/weather/night_clouds.json';
        case 'mist':
          return 'assets/weather/night_clouds.json';
        case 'smoke':
          return 'assets/weather/night_clouds.json';
        case 'haze':
          return 'assets/weather/night_clouds.json';
        case 'dust':
          return 'assets/weather/night_clouds.json';
        case 'fog':
          return 'assets/weather/night_clouds.json';
        case 'rain':
          return 'assets/weather/night_rain.json';
        case 'drizzle':
          return 'assets/weather/night_rain.json';
        case 'shower rain':
          return 'assets/weather/night_rain.json';
        case 'thunderstorm':
          return 'assets/weather/night_thunderstorm.json';
        case 'clear':
          return 'assets/weather/night.json';
        default:
          return 'assets/weather/night.json';
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding:
            const EdgeInsets.only(left: 10, top: 25, right: 10, bottom: 25),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 97, 97, 97),
              Color.fromARGB(255, 155, 197, 195)
            ],
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: double.infinity,
        child: Column(
          children: [
            Text(
                _weather?.cityName == null
                    ? "Loading city..."
                    : "Thị trấn Cổ Lễ",
                style: const TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent)),
            const SizedBox(
              height: 12,
            ),
            Text(
              DateFormat.yMd().add_jm().format(DateTime.now()),
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition),
                width: 100, height: 100),
            const SizedBox(
              height: 12,
            ),
            Text(
              '${_weather?.temperature.round()}°C',
              style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${_weather?.description}',
              style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent),
            )
          ],
        ));
  }
}
