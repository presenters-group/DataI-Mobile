import 'dart:core';
import 'DataSource.dart';

class Table {
  List<DataSource> dataSources = new List();

  Table({this.dataSources});

  factory Table.fromJSON(Map<String, dynamic> json) {
    return Table(dataSources: convertToDataSource(json));
  }

  static List<DataSource> convertToDataSource(json) {
    List<DataSource> listDataSources = new List();
    List<dynamic> dataSourcesJSON = json;
    for (var newDataSource in dataSourcesJSON) {
      listDataSources.add(new DataSource.fromJSON(newDataSource));
    }
    return listDataSources;
  }
}
