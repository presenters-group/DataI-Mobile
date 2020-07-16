import 'package:eyedatai/Classes/ChartData.dart';
import 'package:eyedatai/Classes/DataSources/ColumnModel.dart';
import 'package:eyedatai/Classes/DataSources/TableModel.dart';
import 'package:eyedatai/Classes/FilterModel.dart';
import 'package:flutter/cupertino.dart';
import 'DataSources/Filter.dart';

class VisualizerModel {
  TableModel dataSource;
  int visualizerID;
  int dataID;
  var visualizerName;
  List<dynamic> usedColumns = new List();
  int xColumn;
  List<ColumnModel> columnsModel = new List();
  List<FilterModel> filtersModel = new List();
  ChartData chartData;
  bool isDeleted;
  bool isBar = true;
  bool isLine = false;
  bool isPie = false;
  List<dynamic> filters = new List();

  VisualizerModel({
    @required this.visualizerID,
    @required this.dataID,
    @required this.visualizerName,
    @required this.usedColumns,
    @required this.xColumn,
    @required this.filters,
    @required this.columnsModel,
    @required this.filtersModel,
    @required this.chartData,
    @required this.isDeleted,
    @required this.isBar,
    @required this.isLine,
    @required this.isPie,
    @required this.dataSource,
  });

  factory VisualizerModel.fromJSON(
      Map<String, dynamic> subJSON, Map<String, dynamic> totalJSON) {
    return VisualizerModel(
      dataSource: checkDataSource(totalJSON, subJSON["data"]),
      visualizerID: subJSON["id"],
      dataID: subJSON["data"],
      visualizerName: subJSON["name"],
      usedColumns: subJSON["usedColumns"],
      xColumn: subJSON["xColumn"],
      filters: subJSON["filters"],
      columnsModel: checkUsedColumns(totalJSON, subJSON["usedColumns"],
          subJSON["data"], subJSON["xColumn"]),
      filtersModel: checkUsedFilters(totalJSON, subJSON["filters"]),
      chartData: convertToAggregateData(totalJSON, subJSON["usedColumns"],
          subJSON["data"], subJSON["xColumn"]),
      isDeleted: subJSON["isDeleted"],
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

    print(trueDataSource);
    return trueDataSource;
  }

  static List<ColumnModel> checkUsedColumns(json, usedCol, dataID, xColumn) {
    TableModel trueTableModel;
    List<ColumnModel> trueColumns = new List();
    List<TableModel> allTablesModel = new List();
    List<dynamic> allDataSourcesJSON = json["dataSources"];
    for (var newDataSource in allDataSourcesJSON) {
      allTablesModel.add(TableModel.fromJSON(newDataSource));
    }
    for (int i = 0; i < allTablesModel.length; i++) {
      if (allTablesModel[i].id == dataID) {
        trueTableModel = allTablesModel[i];
      }
    }
    for (int i = 0; i < trueTableModel.columnsList.length; i++) {
      if (usedCol.contains(trueTableModel.columnsList[i].id)) {
        trueColumns.add(trueTableModel.columnsList[i]);
      }
    }
    return trueColumns;
  }

  static List<FilterModel> checkUsedFilters(json, usedFilter) {
    List<FilterModel> trueFilters = new List();
    List<FilterModel> allFilters = new List();
    List<dynamic> allFiltersJSON = json["filters"];
    for (var newFilter in allFiltersJSON) {
      allFilters.add(new FilterModel.fromJSON(newFilter, json));
    }
    List<Filter> filtersList = new List();
    List<dynamic> filtersJSON = usedFilter;
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

  static convertToAggregateData(json, usedCol, dataID, xColumn) {
    List<ColumnModel> trueColumns =
        checkUsedColumns(json, usedCol, dataID, xColumn);
    return ChartData.fromVisualizer(json ,trueColumns, xColumn , dataID);
  }
}
