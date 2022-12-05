import 'package:Kobold/pages/splash.dart';
import 'package:flutter/material.dart';
import 'core/data_model.dart';

void main() {
  runApp(
    MyApp(),
  );
}

DataModel monumentModel = DataModel();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'KenyanCoffee'),
      debugShowCheckedModeBanner: false,
      home:  SplashPage(),
    );
  }
}