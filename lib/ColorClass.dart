import 'package:flutter/material.dart';
import 'dart:math' as math;

class ColorClass {
  static Color scaffoldBackgroundColor = HexColor('E3E5E8');
  static Color fontColor = HexColor('000000');
  static Color subTitleColor = HexColor('A5ACB6');
  static Color dividerColor = Colors.black12;
  static Color drawerIcons = Colors.black54;
  static Color containerColor = Colors.white;

  List<Color> colors = [
    Colors.deepPurple,
    Colors.pink,
    Colors.red,
    Colors.green,
    Colors.deepPurpleAccent,
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.blueAccent,
    Colors.deepOrangeAccent,
  ];

  List<Color> generateColors() {
    List<Color> randomColor = new List();
    for (int i = 1; i < 100; i++) {
      randomColor.add(
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
              .withOpacity(1.0));
    }
    for (int i = 0; i < randomColor.length; i++) {
      if (randomColor[i] == colors[i]) {
        print("No");
      } else {
        colors.add(randomColor[i]);
      }
    }
    return colors;
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
