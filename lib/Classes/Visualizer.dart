import 'package:flutter/cupertino.dart';

class Visualizer {
  int visualizerID;
  int dataID;
  var visualizerName;
  List<dynamic> usedColumns = new List();
  List<dynamic> filters = new List();
  bool isDeleted;
  bool isBar;
  bool isLine;
  bool isPie;

  Visualizer(
      {@required this.visualizerID,
        @required this.dataID,
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
        dataID: json["data"],
        visualizerName: json["name"],
        usedColumns: json["usedColumns"],
        filters: json["filters"],
        isDeleted: json["isDeleted"],
        isBar: true,
        isLine: false,
        isPie: false);
  }
}
