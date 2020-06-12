import 'dart:core';
import 'package:eyedatai/Classes/Visualizer.dart';

import '../Dashboard.dart';
import '../Filter.dart';
import 'DataSource.dart';

class Table {
  List<DataSource> dataSources = new List();
  List<Dashboard> dashboards = new List();
  List<Filter> filters = new List();
  List<Visualizer> visualizers = new List();

  Table({this.dataSources, this.dashboards, this.filters, this.visualizers});

  factory Table.fromJSON(Map<String, dynamic> json) {
    return Table(
      dataSources: convertToDataSources(json),
      visualizers: convertToVisualizers(json),
      dashboards: convertToDashboards(json),
      filters: convertToFilters(json),
    );
  }

  static List<DataSource> convertToDataSources(json) {
    List<DataSource> listDataSources = new List();
    List<dynamic> dataSourcesJSON = json["dataSources"];
    for (var newDataSource in dataSourcesJSON) {
      listDataSources.add(new DataSource.fromJSON(newDataSource));
    }
    return listDataSources;
  }

  static List<Visualizer> convertToVisualizers(json) {
    List<Visualizer> listVisualizers = new List();
    List<dynamic> visualizersJSON = json["visualizations"];
    for (var newVisualizer in visualizersJSON) {
      listVisualizers.add(new Visualizer.fromJson(newVisualizer));
    }
    return listVisualizers;
  }

  static List<Dashboard> convertToDashboards(json) {
    List<Dashboard> listDashboard = new List();
    List<dynamic> dashboardsJSON = json["dashboards"];
    for (var newDataSource in dashboardsJSON) {
      listDashboard.add(new Dashboard.fromJson(newDataSource, json));
    }
    return listDashboard;
  }

  static List<Filter> convertToFilters(json) {
    List<Filter> listFilters = new List();
    List<dynamic> filtersJSON = json["filters"];
    for (var newFilter in filtersJSON) {
      listFilters.add(new Filter.fromJSON(newFilter));
    }
    return listFilters;
  }
}
