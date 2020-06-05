import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor, [String opacity = "FF"]) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = opacity + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor, [String opacity = "FF"]) : super(_getColorFromHex(hexColor, opacity));
}