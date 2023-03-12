class WeatherDataHourly {
  List<Hour> hourly;

  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) {
    Forecast forecast = Forecast.fromJson((json['forecasts'] as List<dynamic>)[0]);
    return WeatherDataHourly(hourly: forecast.hours);
  }
}

class Hour {
  String? hour;
  int? hourTs;
  int? temp;
  String? icon;

  Hour({
    this.hour,
    this.hourTs,
    this.temp,
    this.icon,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        hour: json['hour'] as String?,
        hourTs: json['hour_ts'] as int?,
        temp: json['temp'] as int?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'hour': hour,
        'hour_ts': hourTs,
        'temp': temp,
        'icon': icon,
      };
}

class Forecast {
  List<Hour> hours;

  Forecast({
    required this.hours,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      hours: (json['hours'] as List<dynamic>)
          .map((e) => Hour.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'hours': hours.map((e) => e.toJson()).toList(),
      };
}
