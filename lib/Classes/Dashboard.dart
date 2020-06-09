import 'package:flutter/cupertino.dart';

import 'Visualizer.dart';

class Dashboard {
  var name;
  int dashboardID;
  int numberOfVisualizer;
  List<Visualizer> visualizersList = new List();

  Dashboard(
      {@required this.name,
        this.numberOfVisualizer,
        @required this.visualizersList,
        @required this.dashboardID});

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
        name: json["name"],
        visualizersList: convertToVisualizersList(json),
        dashboardID: json["id"]);
  }
}

List<Visualizer> convertToVisualizersList(json) {
  List<Visualizer> visualizersList = new List();
  List<dynamic> visualizersJSON = json["visualizations"];
  for (var newVisualizer in visualizersJSON) {
    visualizersList.add(new Visualizer(
        visualizerID: newVisualizer["id"],
        visualizerName: newVisualizer["name"],
        usedColumns: newVisualizer["usedColumns"],
        filters: newVisualizer["filters"],
        isDeleted: newVisualizer["isDeleted"],
        isBar: true,
        isLine: false,
        isPie: false));
  }
  return visualizersList;
}
