import 'package:flutter/material.dart';
import 'dart:math' as math;

class ColorClass {
  static Color scaffoldBackgroundColor = HexColor('E3E5E8');
  static Color fontColor = HexColor('000000');
  static Color subTitleColor = HexColor('A5ACB6');
  static Color filterContainerColor = HexColor('C4C4C4');
  static Color dividerColor = Colors.black12;
  static Color drawerIcons = Colors.black54;
  static Color containerColor = Colors.white;
//Light theme
  Color lightScaffoldBackgroundColor  = HexColor('E0E0E0');
  Color lightContainerBackground = HexColor('fafafa');
  Color lightDrawerColor = HexColor('F2F2F2');
  Color lightFontColor = HexColor('333333');
  Color lightRecycleColor = HexColor('1F6C42');
  Color lightCasesColor = HexColor('36A2EB');


  //dark theme
  Color darkScaffoldBackgroundColor  = HexColor('E0E0E0');
  Color darkContainerBackground = HexColor('fafafa');
  Color darkDrawerColor = HexColor('F2F2F2');
  Color darkFontColor = HexColor('333333');
  Color darkRecycleColor = HexColor('1F6C42');
  Color darkCasesColor = HexColor('36A2EB');
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
