class WeatherModel {
  final double temperature;
  final String description;

  WeatherModel({required this.temperature, required this.description});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}
