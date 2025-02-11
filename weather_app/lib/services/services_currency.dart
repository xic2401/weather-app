import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchCurrencyRates() async {
  try {
    var request = http.Request('GET', Uri.parse(
        'https://api.currencyapi.com/v3/latest?apikey=cur_live_dHMJadYxcZVlGu5PmjpIzALX4DMbsGmyXxlUFNCp'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      return jsonDecode(responseBody);
    } else {
      throw Exception('Ошибка: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Ошибка запроса: $e');
  }
}
