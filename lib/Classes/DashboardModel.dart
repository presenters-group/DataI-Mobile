import 'package:eyedatai/Classes/VisualizerModel.dart';
import 'package:flutter/cupertino.dart';

import 'DataSources/Filter.dart';
import 'FilterModel.dart';

class DashboardModel {
  var name;
  int dashboardID;
  List<int> visualizerIndex = new List();
  List<VisualizerModel> visualizersList = new List();
  bool isDelete;
  List<FilterModel> filtersModel = new List();
  List<dynamic> filters = new List();

  DashboardModel(
      {@required this.name,
      @required this.visualizersList,
      @required this.dashboardID,
      @required this.visualizerIndex,
      @required this.filtersModel,
      this.filters,
      this.isDelete});

  factory DashboardModel.fromJson(
      Map<String, dynamic> subJSON, Map<String, dynamic> totalJSON) {
    return DashboardModel(
        name: subJSON["name"],
        visualizerIndex: fetchVisualizersIndex(subJSON),
        visualizersList: convertToVisualizersList(subJSON, totalJSON),
        dashboardID: subJSON["id"],
        filters: subJSON["filters"],
        filtersModel: convertToFiltersList(subJSON, totalJSON),
        isDelete: subJSON["isDelete"]);
  }

  static List<FilterModel> convertToFiltersList(subJSON, totalJSON) {
    List<FilterModel> trueFilters = new List();
    List<FilterModel> allFilters = new List();
    List<dynamic> allFiltersJSON = totalJSON["filters"];
    for (var newFilter in allFiltersJSON) {
      allFilters.add(new FilterModel.fromJSON(newFilter, totalJSON));
    }
    List<Filter> filtersList = new List();
    List<dynamic> filtersJSON = subJSON["filters"];
    for (var newFilter in filtersJSON) {
      filtersList.add(Filter.fromJSON(newFilter));
    }
    List<int> ids = new List();
    for(int i = 0 ; i  < filtersList.length ; i++){
      ids.add(filtersList[i].id);
    }
    for (int i = 0; i < allFilters.length; i++) {
      if (ids.contains(allFilters[i].id)) {
        trueFilters.add(allFilters[i]);
      }
    }
    return trueFilters;
  }

  static List<int> fetchVisualizersIndex(json) {
    List<int> visualizersIndexs = new List();
    List<dynamic> visualizersJSON = json["visualizers"];
    for (var newVisualizerIndex in visualizersJSON) {
      visualizersIndexs.add(newVisualizerIndex["visualizationIndex"]);
    }
    return visualizersIndexs;
  }

  static List<VisualizerModel> convertToVisualizersList(json, totalJSON) {
    List<VisualizerModel> visualizersList = new List();
    List<dynamic> visualizersJSON = totalJSON["visualizations"];
    for (var newVisualizer in visualizersJSON) {
      visualizersList
          .add(new VisualizerModel.fromJSON(newVisualizer, totalJSON));
    }
    List<int> visualizersIndexs = new List();
    List<dynamic> visualizersJSONForIndex = json["visualizers"];
    List<VisualizerModel> visualizersForDashboard = new List();
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
