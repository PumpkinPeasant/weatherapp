import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  DateTime date = DateTime.now();
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getCity(globalController.getPlacemark().value);
    super.initState();
  }

  getCity(placemark) {
    print('test');
    print(placemark);
    setState(() {
      // city = placemark.locality;
      city = "Severodvinsk";
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
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Text(city,
                style: TextStyle(
                    fontSize: 14, color: Colors.grey[700], height: 1.5))),
      ],
    );
  }
}
