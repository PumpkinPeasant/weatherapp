import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String district = "";
  String date = DateFormat('yMMMd', 'ru_RU').format(DateTime.now());
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    setCity(globalController.getPlacemark().value);
    super.initState();
  }

  setCity(placemark) {
    setState(() {
      city = placemark.locality;
      district = placemark.district;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Text(city, style: const TextStyle(fontSize: 35, height: 2))),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Text(district,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 20,
                  height: 1,
                ))),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Text(date,
                style: TextStyle(
                    fontSize: 14, color: Colors.grey[700], height: 1.5))),
      ],
    );
  }
}
