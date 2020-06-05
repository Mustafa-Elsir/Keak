
import 'package:flutter/material.dart';
import 'package:keak/src/ui/home.dart';
import 'package:keak/src/ui/splash.dart';

const String splashRoute = "/";
const String homeRoute = "/home";

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  splashRoute: (BuildContext context) => new Splash(),
  homeRoute: (BuildContext context) => new Home(),
};
