import 'package:flutter/material.dart';

class ColorClass {
  static Color scaffoldBackgroundColor = HexColor('E3E5E8');
  static Color fontColor = HexColor('000000');
  static Color subTitleColor = HexColor('A5ACB6');
  static Color dividerColor = Colors.black12;
  static Color drawerIcons = Colors.black54;
  static Color containerColor = Colors.white;
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
