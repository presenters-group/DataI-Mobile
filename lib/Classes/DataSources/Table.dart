import 'dart:core';
import '../Dashboard.dart';
import 'DataSource.dart';

class Table {
  List<DataSource> dataSources = new List();
  List<Dashboard> dashboards = new List();

  Table({this.dataSources, this.dashboards});

  factory Table.fromJSONDashboard(Map<String, dynamic> json) {
    return Table(dashboards: convertToDashboards(json));
  }

  factory Table.fromJSONDataSource(Map<String, dynamic> json) {
    return Table(dataSources: convertToDataSource(json));
  }

  static List<Dashboard> convertToDashboards(json) {
    List<Dashboard> listDashboard = new List();
    List<dynamic> dashboardsJSON = json["dashboards"];
    for (var newDataSource in dashboardsJSON) {
      listDashboard.add(new Dashboard.fromJson(newDataSource , json));
    }
    return listDashboard;
  }

  static List<DataSource> convertToDataSource(json) {
    List<DataSource> listDataSources = new List();
    List<dynamic> dataSourcesJSON = json["dataSources"];
    for (var newDataSource in dataSourcesJSON) {
      listDataSources.add(new DataSource.fromJSON(newDataSource));
    }
    return listDataSources;
  }
}
