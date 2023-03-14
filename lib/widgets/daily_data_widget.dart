import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/model/weather_data_daily.dart';
import 'package:weatherapp/utils/custom_colors.dart';

class DailyDataWidget extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;

  const DailyDataWidget({Key? key, required this.weatherDataDaily})
      : super(key: key);

  String formatDate(final dateTs) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(dateTs * 1000);
    return DateFormat('EEE').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColors.dividerLine.withAlpha(150),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "Следующие дни",
              style:
                  TextStyle(color: CustomColors.textColorBlack, fontSize: 17),
            ),
          ),
          dailyList(),
        ],
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: weatherDataDaily.daily.length > 7
            ? 7
            : weatherDataDaily.daily.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        formatDate(weatherDataDaily.daily[index].dateTs),
                        style: const TextStyle(
                          color: CustomColors.textColorBlack,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                          "assets/weather/${weatherDataDaily.daily[index].icon}.png"),
                    ),
                    Text(
                      "${weatherDataDaily.daily[index].tempDay}°/${weatherDataDaily.daily[index].tempNight.toString()}°",
                      style: const TextStyle(
                        color: CustomColors.textColorBlack,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
