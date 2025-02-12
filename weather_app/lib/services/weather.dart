import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherModel {
  final String description;
  final double temperature;
  final String city;
  final String country;

  WeatherModel({
    required this.description,
    required this.temperature,
    required this.city,
    required this.country,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'].toDouble(),
      city: json['name'],
      country: json['sys']['country'],
    );
  }
}

class WeatherService {
  Future<WeatherModel> fetchWeather(double latitude, double longitude) async {
    final apiKey = '801855c2f1fe372b17d7bc91d33191a0';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);

        if (decodedResponse == null) {
          throw Exception('Ответ от сервера пустой');
        }

        print('Decoded Response: $decodedResponse');

        if (decodedResponse.containsKey('main') &&
            decodedResponse['main'].containsKey('temp')) {
          return WeatherModel.fromJson(decodedResponse);
        } else {
          throw Exception('Не удалось найти температуру в ответе');
        }
      } else {
        print('Ошибка: ${response.body}');
        throw Exception('Не удалось получить данные о погоде');
      }
    } catch (e) {
      print('Ошибка запроса: $e');
      rethrow;
    }
  }
}
