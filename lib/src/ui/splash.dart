import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keak/src/resources/repository.dart';
import 'package:keak/src/utils/app_builder.dart';
import 'package:keak/src/utils/global_translations.dart';
import 'package:keak/src/utils/pref_manager.dart';
import 'package:keak/src/utils/routes.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final _prefManager = PrefManager();
  final _repo = Repository();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await lang.init();
    AppBuilder.of(context).rebuild();

    if(await _prefManager.contains("phone")){
      String phone = await _prefManager.get("phone", "");
      if(phone.isNotEmpty){
        Map<String, dynamic> response = await _repo.auth(phone);
        await _prefManager.set("token", response["token"]);
        await _prefManager.set("ambergris", json.encode(response["ambergris"]));
        Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, ModalRoute.withName("/no_route"));
        return;
      } else {
        _prefManager.remove("phone");
      }
    }
    Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.of(context).pushNamedAndRemoveUntil(authRoute, ModalRoute.withName("/no_route"));
    });
  }

  @override
  void dispose() {
    _repo.close();
    super.dispose();
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
