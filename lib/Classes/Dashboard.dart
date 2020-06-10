import 'package:eyedatai/Classes/Visualizer.dart';
import 'package:flutter/cupertino.dart';

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

  static List<Visualizer> convertToVisualizersList(json) {
    List<Visualizer> visualizersList = new List();
    List<dynamic> visualizersJSON = json["visualizations"];
    for (var newVisualizer in visualizersJSON) {
      visualizersList.add(new Visualizer.fromJson(newVisualizer));
    }
    return visualizersList;
  }
}
