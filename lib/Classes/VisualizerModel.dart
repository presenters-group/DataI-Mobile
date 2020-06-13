import 'package:flutter/cupertino.dart';

import 'DataSources/ColumnModel.dart';
import 'DataSources/TableModel.dart';
import 'Filter.dart';

class VisualizerModel {
  TableModel dataSource;
  int visualizerID;
  int dataID;
  var visualizerName;
  List<dynamic> usedColumns = new List();
  List<dynamic> filters = new List();
  List<ColumnModel> columnsModel = new List();
  List<Filter> filtersModel = new List();
  bool isDeleted;
  bool isBar;
  bool isLine;
  bool isPie;

  VisualizerModel(
      {@required this.visualizerID,
      @required this.dataID,
      @required this.visualizerName,
      @required this.usedColumns,
      @required this.filters,
      @required this.columnsModel,
      @required this.filtersModel,
      @required this.isDeleted,
      @required this.isBar,
      @required this.isLine,
      @required this.isPie,
      @required this.dataSource});

  factory VisualizerModel.fromJSON(
      Map<String, dynamic> json, Map<String, dynamic> totalJSON) {
    return VisualizerModel(
      dataSource: checkDataSource(totalJSON, json["id"]),
      visualizerID: json["id"],
      dataID: json["data"],
      visualizerName: json["name"],
      usedColumns: json["usedColumns"],
      filters: json["filters"],
      columnsModel:
          checkUsedColumns(totalJSON, json["usedColumns"], json["id"]),
      filtersModel: checkUsedFilters(totalJSON, json["filters"]),
      isDeleted: json["isDeleted"],
      isBar: true,
      isLine: false,
      isPie: false,
    );
  }

  static TableModel checkDataSource(json, id) {
    TableModel trueDataSource;
    List<TableModel> allDataSources = new List();
    List<dynamic> allDataSourcesJSON = json["dataSources"];

    for (var newDataSource in allDataSourcesJSON) {
      allDataSources.add(new TableModel.fromJSON(newDataSource));
    }

    for (int i = 0; i < allDataSources.length; i++) {
      if (allDataSources[i].id == id) {
        trueDataSource = allDataSources[i];
      }
    }
    return trueDataSource;
  }

  static List<ColumnModel> checkUsedColumns(json, usedCol, id) {
    List<ColumnModel> trueColumnModel = new List();
    TableModel tableModel = checkDataSource(json, id);

    for (int i = 0; i < tableModel.listColumns.length; i++) {
      if (tableModel.listColumns[i].id == id[i]) {
        trueColumnModel.add(tableModel.listColumns[i]);
      }
    }

    return trueColumnModel;
  }

  static List<Filter> checkUsedFilters(json, usedFilter) {
    List<Filter> trueFilters = new List();
    List<Filter> allFilters = new List();
    List<dynamic> allFiltersJSON = json["filters"];
    for (var newFilter in allFiltersJSON) {
      allFilters.add(new Filter.fromJSON(newFilter, json));
    }
    for (int i = 0; i < allFilters.length; i++) {
      if (allFilters[i].id == usedFilter[i]) {
        trueFilters.add(allFilters[i]);
      }
    }

    return trueFilters;
  }
}
