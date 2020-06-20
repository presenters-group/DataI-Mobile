import 'dart:core';
import 'package:eyedatai/Classes/VisualizerModel.dart';

import 'DashboardModel.dart';
import 'FilterModel.dart';
import 'DataSources/TableModel.dart';

class DataModel {
  List<TableModel> dataSources = new List();
  List<DashboardModel> dashboards = new List();
  List<FilterModel> filters = new List();
  List<VisualizerModel> visualizers = new List();

  DataModel(
      {this.dataSources, this.dashboards, this.filters, this.visualizers});

  factory DataModel.fromJSON(Map<String, dynamic> json) {
    return DataModel(
      dataSources: convertToDataSources(json),
      visualizers: convertToVisualizers(json),
      dashboards: convertToDashboards(json),
      filters: convertToFilters(json),
    );
  }

  static List<TableModel> convertToDataSources(json) {
    List<TableModel> listDataSources = new List();
    List<dynamic> dataSourcesJSON = json["dataSources"];
    for (var newDataSource in dataSourcesJSON) {
      listDataSources.add(new TableModel.fromJSON(newDataSource));
    }
    return listDataSources;
  }

  static List<VisualizerModel> convertToVisualizers(json) {
    List<VisualizerModel> listVisualizers = new List();
    List<dynamic> visualizersJSON = json["visualizations"];
    for (var newVisualizer in visualizersJSON) {
      listVisualizers.add(new VisualizerModel.fromJSON(newVisualizer, json));
    }
    return listVisualizers;
  }

  static List<DashboardModel> convertToDashboards(json) {
    List<DashboardModel> listDashboard = new List();
    List<dynamic> dashboardsJSON = json["dashboards"];
    for (var newDataSource in dashboardsJSON) {
      listDashboard.add(new DashboardModel.fromJson(newDataSource, json));
    }
    return listDashboard;
  }

  static List<FilterModel> convertToFilters(json) {
    List<FilterModel> listFilters = new List();
    List<dynamic> filtersJSON = json["filters"];
    for (var newFilter in filtersJSON) {
      listFilters.add(new FilterModel.fromJSON(newFilter, json));
    }
    return listFilters;
  }
}
