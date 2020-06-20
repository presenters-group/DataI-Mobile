import 'package:eyedatai/Classes/AggregateData.dart';
import 'package:eyedatai/Classes/DataSources/ColumnModel.dart';
import 'package:eyedatai/Classes/DataSources/TableModel.dart';
import 'package:eyedatai/Classes/FilterModel.dart';
import 'package:flutter/cupertino.dart';

class VisualizerModel {
  TableModel dataSource;
  int visualizerID;
  int dataID;
  var visualizerName;
  List<dynamic> usedColumns = new List();
  int xColumn;
  List<dynamic> filters = new List();
  List<ColumnModel> columnsModel = new List();
  List<FilterModel> filtersModel = new List();
  AggregateData aggregateData;
  bool isDeleted;
  bool isBar = true;
  bool isLine = false;
  bool isPie = false;

  VisualizerModel({
    @required this.visualizerID,
    @required this.dataID,
    @required this.visualizerName,
    @required this.usedColumns,
    @required this.xColumn,
    @required this.filters,
    @required this.columnsModel,
    @required this.filtersModel,
    @required this.aggregateData,
    @required this.isDeleted,
    @required this.isBar,
    @required this.isLine,
    @required this.isPie,
    @required this.dataSource,
  });

  factory VisualizerModel.fromJSON(
      Map<String, dynamic> json, Map<String, dynamic> totalJSON) {
    return VisualizerModel(
      dataSource: checkDataSource(totalJSON, json["data"]),
      visualizerID: json["id"],
      dataID: json["data"],
      visualizerName: json["name"],
      usedColumns: json["usedColumns"],
      xColumn: json["xColumn"],
      filters: json["filters"],
      columnsModel: checkUsedColumns(
          totalJSON, json["usedColumns"], json["data"], json["xColumn"]),
      filtersModel: checkUsedFilters(totalJSON, json["filters"]),
      aggregateData: convertToAggregateData(
          totalJSON, json["usedColumns"], json["data"], json["xColumn"]),
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
    print(trueDataSource);
    return trueDataSource;
  }

  static List<ColumnModel> checkUsedColumns(json, usedCol, dataID, xColumn) {
    /* List<ColumnModel> trueColumnModel = new List();
    List<dynamic> allDSJSON = json["dataSources"];
    List<TableModel>tablesModels =new List();
    TableModel truetableModel;
    for(var newTable in allDSJSON){
      tablesModels.add(new TableModel.fromJSON(newTable));
    }
    for(int i = 0 ; i < tablesModels.length ; i++){
      if(tablesModels[i].id == dataID){
        truetableModel = tablesModels[i];
      }
    }

    //TableModel tableModel = checkDataSource(json, dataID);
    for (int i = 0; i < truetableModel.listColumns.length; i++) {
      if (usedCol.contains(truetableModel.listColumns[i].id)) {
        print(truetableModel.listColumns[i].id);
        trueColumnModel.add(truetableModel.listColumns[i]);
      }
    }
    return trueColumnModel;*/
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
    for (int i = 0; i < trueTableModel.listColumns.length; i++) {
      if (usedCol.contains(trueTableModel.listColumns[i].id)) {
        trueColumns.add(trueTableModel.listColumns[i]);
      }
    }
    /*    ColumnModel tempColumnModel;
    for(int i = 0 ; i < trueColumns.length ; i++){
      if(trueColumns[i].id == xColumn){
        tempColumnModel = trueColumns[i];
        trueColumns.remove(trueColumns[i]);
      }
    }
    trueColumns.insert(0, tempColumnModel);*/
    return trueColumns;
  }

  static List<FilterModel> checkUsedFilters(json, usedFilter) {
    List<FilterModel> trueFilters = new List();
    List<FilterModel> allFilters = new List();
    List<dynamic> allFiltersJSON = json["filters"];
    for (var newFilter in allFiltersJSON) {
      allFilters.add(new FilterModel.fromJSON(newFilter, json));
    }
    for (int i = 0; i < allFilters.length; i++) {
      if (usedFilter.contains(allFilters[i].id)) {
        trueFilters.add(allFilters[i]);
      }
    }
    return trueFilters;
  }

  static convertToAggregateData(json, usedCol, dataID, xColumn) {
    List<ColumnModel> trueColumns =
        checkUsedColumns(json, usedCol, dataID, xColumn);
    /*    ColumnModel tempColumnModel;
    for(int i = 0 ; i < trueColumns.length ; i++){
      if(trueColumns[i].id == xColumn){
        tempColumnModel = trueColumns[i];
        trueColumns.remove(trueColumns[i]);
      }
    }
    trueColumns.insert(0, tempColumnModel);*/
    return AggregateData.fromVisualizer(trueColumns, xColumn);
  }
}
