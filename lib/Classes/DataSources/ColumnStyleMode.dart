import 'package:flutter/material.dart';

class ColumnStyleMode {
  Color color;
  double lineWeight;
  double pointWeight;
  String font;

  ColumnStyleMode({this.color, this.lineWeight, this.pointWeight, this.font});

  factory ColumnStyleMode.fromJSON(Map<String, dynamic> json) {
    return ColumnStyleMode(
        color: json["color"],
        lineWeight: json["lineWeight"],
        pointWeight: json["pointWeight"],
        font: json["font"]);
  }
}
