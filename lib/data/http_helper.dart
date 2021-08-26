import 'package:globo_fitness/data/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper {
  // http://api.openweathermap.org/data/2.5/weather?q=London&appid=904af2b8a02663467552bc392441584e
  final String authority = 'api.openweathermap.org';
  final String path = 'data/2.5/weather';
  final apiKey = '904af2b8a02663467552bc392441584e';

  Future<Weather> getWeather(String location) async {
    Map<String, dynamic> parameters = {'q': location, 'appid': apiKey};
    Uri uri = Uri.https(authority, path, parameters);
    http.Response result = await http.get(uri);

    Map<String, dynamic> data = json.decode(result.body);
    Weather weather = Weather.fromJson(data);

    return weather;
  }
}