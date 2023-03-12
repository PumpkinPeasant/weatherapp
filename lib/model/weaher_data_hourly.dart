class WeatherDataHourly {
  List<Hour> hourly;

  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) =>
      WeatherDataHourly(
          hourly: List<Hour>.from(json['hour'].map((e) => Hour.fromJson(e))));
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
