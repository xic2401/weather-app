import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  Future<WeatherModel> fetchWeather(double latitude, double longitude) async {
    final apiKey = 'fe059762-caaa-4b45-9a08-0f56bf5ff714';
    final url =
        'https://api.weather.yandex.ru/v2/forecast?lat=52.37125&lon=4.89388';
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Не удалось получить данные о погоде');
    }
  }
}
