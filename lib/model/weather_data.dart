import 'package:weatherapp/model/weaher_data_hourly.dart';
import 'package:weatherapp/model/weather_data_current.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;

  WeatherData([this.current, this.hourly]);

  WeatherDataCurrent getCurrentWeather() => current!;

  WeatherDataHourly getHourlyWeather() => hourly!;
}
