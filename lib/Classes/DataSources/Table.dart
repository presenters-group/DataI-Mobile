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

  Table({this.dataSources, this.dashboards, this.filters});

  factory Table.fromJSON(Map<String, dynamic> json) {
    return Table(
      dataSources: convertToDataSource(json),
      dashboards: convertToDashboards(json),
      filters: convertToFilters(json),
    );
  }

  static List<DataSource> convertToDataSource(json) {
    List<DataSource> listDataSources = new List();
    List<dynamic> dataSourcesJSON = json["dataSources"];
    for (var newDataSource in dataSourcesJSON) {
      listDataSources.add(new DataSource.fromJSON(newDataSource));
    }
    return listDataSources;
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
