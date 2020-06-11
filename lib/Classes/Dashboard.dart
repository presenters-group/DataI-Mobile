import 'package:eyedatai/Classes/Visualizer.dart';
import 'package:flutter/cupertino.dart';

class Dashboard {
  var name;
  int dashboardID;
  int numberOfVisualizer;
  List<int> visualizerIndex = new List();
  List<Visualizer> visualizersList = new List();

  Dashboard(
      {@required this.name,
        this.numberOfVisualizer,
        @required this.visualizersList,
        @required this.dashboardID,
        @required this.visualizerIndex});

  factory Dashboard.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> totalJSON) {
    return Dashboard(
      name: json["name"],
      visualizerIndex: fetchVisualizersIndex(json),
      visualizersList: convertToVisualizersList(json, totalJSON),
      dashboardID: json["id"],
    );
  }

  static List<int> fetchVisualizersIndex(json) {
    List<int> visualizersIndexs = new List();
    List<dynamic> visualizersJSON = json["visualizers"];
    for (var newVisualizerIndex in visualizersJSON) {
      visualizersIndexs.add(newVisualizerIndex["visualizationIndex"]);
    }
    return visualizersIndexs;
  }

  static List<Visualizer> convertToVisualizersList(json, totalJSON) {
    /*List<Visualizer> allVisualizers = new List();
    List<dynamic> allVisualizersJSON = json["visualizations"];
    for (var newVisualizer in allVisualizersJSON) {
      allVisualizers.add(new Visualizer.fromJson(newVisualizer));
    }
    List<dynamic> visualizersOfDashboardJSON = json["visualizers"];
    List<Visualizer> visualizersOfDashboard = ;
    for(var newDashVisualizer in visualizersOfDashboardJSON){
      visualizersOfDashboard.add(new Visualizer.fromJson(newDashVisualizer));
    }
    List<Visualizer> visualizersList = new List();

    for (int i = 0; i < allVisualizers.length; i++) {
      if (allVisualizers[i].visualizerID ==
          visualizersOfDashboardJSON[i].visualizationIndex) {
        visualizersList.add(new Visualizer(
            visualizerID: allVisualizers[i].visualizerID,
            visualizerName: allVisualizers[i].visualizerName,
            usedColumns: allVisualizers[i].usedColumns,
            filters: allVisualizers[i].filters,
            isDeleted: allVisualizers[i].isDeleted,
            isBar: true,
            isLine: false,
            isPie: false));
      }
    }

    return allVisualizers;*/

    List<Visualizer> visualizersList = new List();
    List<dynamic> visualizersJSON = totalJSON["visualizations"];
    for (var newVisualizer in visualizersJSON) {
      visualizersList.add(new Visualizer.fromJson(newVisualizer));
    }
    List<int> visualizersIndexs = new List();
    List<dynamic> visualizersJSONForIndex = json["visualizers"];
    List<Visualizer> visualizersForDashboard = new List();
    for (var newVisualizerIndex in visualizersJSONForIndex) {
      visualizersIndexs.add(newVisualizerIndex["visualizationIndex"]);
    }
    for (int i = 0; i < visualizersIndexs.length; i++) {
      if (visualizersIndexs[i] == visualizersList[i].visualizerID) {
        visualizersForDashboard.add(visualizersList[i]);
      }
    }
    return visualizersForDashboard;
  }
}
