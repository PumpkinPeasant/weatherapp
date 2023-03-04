import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomeScreen(),
      title: 'Погода',
      debugShowCheckedModeBanner: false,
    );
  }
}
