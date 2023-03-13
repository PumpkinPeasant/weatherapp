class WeatherDataDaily {
  List<WeatherDataDay> daily;

  WeatherDataDaily({required this.daily});

  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) {
    List<WeatherDataDay> daily = (json['forecasts'] as List<dynamic>).map((f) {
      Forecast forecast = Forecast.fromJson(f);
      return WeatherDataDay(
        date: forecast.date,
        tempDay: forecast.parts?.dayShort?.temp,
        tempNight: forecast.parts?.nightShort?.temp,
        icon: forecast.parts?.dayShort?.icon,
      );
    }).toList();
    return WeatherDataDaily(daily: daily);
  }
}

class WeatherDataDay {
  String? date;
  int? tempNight;
  int? tempDay;
  String? icon;

  WeatherDataDay(
      {required this.date,
      required this.tempNight,
      required this.tempDay,
      required this.icon});
}

class Forecast {
  String? date;
  Parts? parts;

  Forecast({
    this.date,
    this.parts,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        date: json['date'] as String?,
        parts: json['parts'] == null
            ? null
            : Parts.fromJson(json['parts'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'parts': parts?.toJson(),
      };
}

class Parts {
  DayShort? dayShort;
  NightShort? nightShort;

  Parts({
    this.dayShort,
    this.nightShort,
  });

  factory Parts.fromJson(Map<String, dynamic> json) => Parts(
        dayShort: json['day_short'] == null
            ? null
            : DayShort.fromJson(json['day_short'] as Map<String, dynamic>),
        nightShort: json['night_short'] == null
            ? null
            : NightShort.fromJson(json['night_short'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'day_short': dayShort?.toJson(),
        'night_short': nightShort?.toJson(),
      };
}

class NightShort {
  int? temp;

  NightShort({
    this.temp,
  });

  factory NightShort.fromJson(Map<String, dynamic> json) => NightShort(
        temp: json['temp'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
      };
}

class DayShort {
  int? temp;
  String? icon;

  DayShort({
    this.temp,
    this.icon,
  });

  factory DayShort.fromJson(Map<String, dynamic> json) => DayShort(
        temp: json['temp'] as int?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'icon': icon,
      };
}
