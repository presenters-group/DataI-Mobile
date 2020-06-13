import 'package:flutter/material.dart';

class ColumnStyleMode {
  Color color;
  double lineWeight;
  double pointWeight;
  String font;

  ColumnStyleMode({this.color, this.lineWeight, this.pointWeight, this.font});

  factory ColumnStyleMode.fromJSON(Map<String, dynamic> json) {
    return ColumnStyleMode(
        color: HexColor(json["color"]),
        lineWeight: json["lineWeight"],
        pointWeight: json["pointWeight"],
        font: json["font"]);
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
