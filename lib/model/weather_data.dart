import 'package:weatherapp/model/geolocation.dart';
import 'package:weatherapp/model/weaher_data_hourly.dart';
import 'package:weatherapp/model/weather_data_current.dart';
import 'package:weatherapp/model/weather_data_daily.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;
  final Geolocation? geolocation;

  WeatherData([this.current, this.hourly, this.daily, this.geolocation]);

  WeatherDataCurrent getCurrentWeather() => current!;

  WeatherDataHourly getHourlyWeather() => hourly!;

  WeatherDataDaily getDailyWeather() => daily!;

  Geolocation getGeolocation() => geolocation!;
}
