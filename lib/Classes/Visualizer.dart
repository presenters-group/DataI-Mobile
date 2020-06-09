import 'package:flutter/cupertino.dart';

class Visualizer {
  int visualizerID;
  var visualizerName;
  List<int> usedColumns = new List();
  List<int> filters = new List();
  bool isDeleted;
  bool isBar;
  bool isLine;
  bool isPie;

  Visualizer(
      {@required this.visualizerID,
        @required this.visualizerName,
        @required this.usedColumns,
        @required this.filters,
        @required this.isDeleted,
        @required this.isBar,
        @required this.isLine,
        @required this.isPie});

  factory Visualizer.fromJson(Map<String, dynamic> json) {
    return Visualizer(
        visualizerID: json["id"],
        visualizerName: json["name"],
        usedColumns: json["usedColumns"],
        filters: json["filters"],
        isDeleted: json["isDeleted"],
        isBar: true,
        isLine: false,
        isPie: false);
  }
}
