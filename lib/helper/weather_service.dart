import 'dart:convert';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey = '91eeac0a6df37868bd026898a9b7a7e1';
  final String latitude = '20.32336';
  final String longitude = '106.26584';

  Future<Weather> getWeather() async {
    final response = await http.get(Uri.parse('$BASE_URL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=vi'));

    if(response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}