import 'package:eyedatai/Classes/DataSources/ColumnModel.dart';
import 'package:eyedatai/Classes/DataSources/TableModel.dart';
import 'package:eyedatai/Classes/Filter.dart';
import 'package:eyedatai/DataI.dart';
import 'package:flutter/cupertino.dart';

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
      dataSource: checkDataSource(totalJSON, json["data"]),
      visualizerID: json["id"],
      dataID: json["data"],
      visualizerName: json["name"],
      usedColumns: json["usedColumns"],
      filters: json["filters"],
      columnsModel:
      checkUsedColumns(totalJSON, json["usedColumns"], json["data"]),
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
    print(trueDataSource);
    return trueDataSource;
  }

  static List<ColumnModel> checkUsedColumns(json, usedCol, dataID) {
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
    return trueColumns;
  }

  static List<Filter> checkUsedFilters(json, usedFilter) {
    List<Filter> trueFilters = new List();
    List<Filter> allFilters = new List();
    List<dynamic> allFiltersJSON = json["filters"];
    for (var newFilter in allFiltersJSON) {
      allFilters.add(new Filter.fromJSON(newFilter, json));
    }
    for (int i = 0; i < allFilters.length; i++) {
      if (usedFilter.contains(allFilters[i].id)) {
        trueFilters.add(allFilters[i]);
      }
    }
    return trueFilters;
  }
}
