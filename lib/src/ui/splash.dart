import 'package:flutter/material.dart';
import 'package:keak/src/utils/global_translations.dart';
import 'package:keak/src/utils/routes.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init(){
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, ModalRoute.withName("/no_route"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image(
            image: AssetImage("assets/images/bg.png"),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black54,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  lang.text("Keak"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 54,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),
                Loading(indicator: BallPulseIndicator(), size: 82.0,color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
