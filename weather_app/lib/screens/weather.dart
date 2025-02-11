import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import '../services/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _location = "Загрузка...";
  String _weatherDescription = "Загрузка...";
  double _temperature = 0.0;

  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    _getLocationAndWeather();
  }

  Future<void> _getLocationAndWeather() async {
    try {
      final position = await _locationService.getCurrentLocation();
      final weather = await _weatherService.fetchWeather(position.latitude, position.longitude);

      setState(() {
        _location = "${position.latitude}, ${position.longitude}";
        _weatherDescription = weather.description;
        _temperature = weather.temperature;
      });
    } catch (e) {
      setState(() {
        _location = "Не удалось получить местоположение";
        _weatherDescription = "Ошибка: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Погода")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Местоположение: $_location'),
            Text('Температура: $_temperature °C'),
            Text('Описание: $_weatherDescription'),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on),
              SizedBox(width: 8),
              Text('$_location'),
              SizedBox(width: 16),
              Icon(Icons.cloud),
              SizedBox(width: 8),
              Text('$_weatherDescription'),
            ],
          ),
        ),
      ),
    );
  }
}
