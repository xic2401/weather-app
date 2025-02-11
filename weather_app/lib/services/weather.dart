import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  Future<WeatherModel> fetchWeather(double latitude, double longitude) async {
    Map<String, String> headers = {'X-Gismeteo-Token': '56b30cb255.3443075'};
    final url = 'https://api.gismeteo.net/v2/weather/current/?latitude=$latitude&longitude=$longitude';

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Не удалось получить данные о погоде');
    }
  }
}
