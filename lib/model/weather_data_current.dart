import 'package:weatherapp/model/condition.dart';

class WeatherDataCurrent {
  final Fact current;

  WeatherDataCurrent({required this.current});

  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) =>
      WeatherDataCurrent(current: Fact.fromJson(json['fact']));
}

class Fact {
  int? temp;
  String? icon;
  String? condition;
  double? cloudness;
  double? windSpeed;
  int? humidity;

  Fact({
    this.temp,
    this.icon,
    this.condition,
    this.cloudness,
    this.windSpeed,
    this.humidity,
  });

  factory Fact.fromJson(Map<String, dynamic> json) {
    Condition condition = Condition();
    return Fact(
      temp: json['temp'] as int?,
      icon: json['icon'] as String?,
      condition: condition.condition[json['condition'] as String],
      cloudness: (json['cloudness'] as num?)?.toDouble(),
      windSpeed: (json['wind_speed'] as num?)?.toDouble(),
      humidity: json['humidity'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'icon': icon,
        'condition': condition,
        'cloudness': cloudness,
        'wind_speed': windSpeed,
        'humidity': humidity,
      };
}
