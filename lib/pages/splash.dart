import 'package:Kobold/core/data_model.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import '../core/color.dart';
import '../home.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.network(
          'https://i.imgur.com/nhganLb.png'),
      backgroundColor: secondary,
      showLoader: true,
      loadingText: Text("..." ,style: TextStyle(color: backgroundDark),),
      navigator: MyHomePage(values: fetchData()),
      durationInSeconds: 5,
    );
  }
}