import 'dart:convert';

import 'package:weatherapp/model/weaher_data_hourly.dart';
import 'package:weatherapp/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/model/weather_data_current.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  Future<WeatherData> processData(lat, lon) async {
    var response =
        await http.get(Uri.parse(apiURL(lat, lon)), headers: apiKey());
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString));
    return weatherData!;
  }
}

String apiURL(var lat, var lon) {
  String url;
  url =
      "https://api.weather.yandex.ru/v2/forecast/?lat=$lat&lon=$lon&lang=ru_RU";
  return url;
}

Map<String, String> apiKey() {
  Map<String, String> requestHeaders = {
    'X-Yandex-API-Key': "82de17c4-ecca-4952-9586-dccf26352a26",
  };
  return requestHeaders;
}
