import 'package:flutter/cupertino.dart';

import 'DataSources/TableModel.dart';

class FilterModel {
  TableModel dataSource;
  var name;
  int id;
  int dataSourceID;
  int filteredColumn;
  var initValue;
  String type;
  bool isDeleted;
  bool isActive = false;
  TextEditingController textEditingController;
  List<bool> isActivatedCells = new List();

  FilterModel(
      {this.dataSource,
        this.name,
        this.id,
        this.dataSourceID,
        this.filteredColumn,
        this.initValue,
        this.type,
        this.isDeleted,
        this.isActive,
        this.textEditingController,
        this.isActivatedCells});

  factory FilterModel.fromJSON(
      Map<String, dynamic> subJSON, Map<String, dynamic> totalJSON) {
    return FilterModel(
        dataSource: checkFilter(totalJSON, subJSON["dataSource"]),
        name: subJSON["name"],
        id: subJSON["id"],
        dataSourceID: subJSON["dataSource"],
        filteredColumn: subJSON["filteredColumn"],
        initValue: subJSON["initValue"].toString(),
        type: subJSON["type"],
        isDeleted: subJSON["isDeleted"],
        isActive: false,
        textEditingController: new TextEditingController(),
        isActivatedCells: countNumberCellsAndCheckingFalse(
            totalJSON, subJSON["dataSource"], subJSON["filteredColumn"]));
  }

  static TableModel checkFilter(json, id) {
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

  static List<bool> countNumberCellsAndCheckingFalse(json, id, filteredColumn) {
    List<bool> zeroActivation = new List();
    TableModel trueTableModel = checkFilter(json, id);
    for (int i = 0;
    i < trueTableModel.columnsList[filteredColumn].cells.length;
    i++) {
      zeroActivation.add(false);
      print("$i : false");
    }
    print("Length : ${zeroActivation.length}");
    return zeroActivation;
  }
}
