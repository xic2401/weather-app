import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import '../services/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  String location = "Загрузка...";
  String weatherDescription = "Загрузка...";
  double temperature = 0.0;
  String city = "";
  String country = "";

  final LocationService locationService = LocationService();
  final WeatherService weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    getLocationAndWeather();
  }

  Future<void> getLocationAndWeather() async {
    try {
      final position = await locationService.getCurrentLocation();
      print('Координаты: ${position.latitude}, ${position.longitude}');
      final weather = await weatherService.fetchWeather(
          position.latitude, position.longitude);

      setState(() {
        location = "${position.latitude}, ${position.longitude}";
        weatherDescription = weather.description;
        temperature = weather.temperature;
        city = weather.city;
        country = weather.country;
      });
    } catch (e) {
      setState(() {
        location = "Не удалось получить местоположение";
        weatherDescription = "Ошибка: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Погода",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: location == "Загрузка..."
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$city, $country',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '$temperature°C',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    weatherDescription,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Местоположение: $location',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                '$location',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 16),
              Icon(
                Icons.cloud,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                '$weatherDescription',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
