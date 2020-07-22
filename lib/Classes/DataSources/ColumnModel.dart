import 'dart:ui';

import 'CellModel.dart';
import 'ColumnStyleMode.dart';
import 'ValueCategory.dart';

class ColumnModel {
  var name;
  int id;
  List<CellModel> cells = new List();
  List<ValueCategory> valueCategories = new List();

  //ColumnStyleMode columnStyleMode;
  var columnType;
  bool isDeleted;
  Color colorColumn;

  ColumnModel(
      {this.name,
      this.id,
      this.cells,
      this.valueCategories,
      this.columnType,
      this.isDeleted,
      this.colorColumn});

  factory ColumnModel.fromJSON(
      Map<String, dynamic> subJSON, Map<String, dynamic> totalJSON) {
    return ColumnModel(
        name: subJSON["name"],
        id: subJSON["id"],
        cells: convertToCellsList(subJSON),
        valueCategories: convertToValueCategories(subJSON),
        // columnStyleMode: ColumnStyleMode.fromJSON(json["style"]),
        colorColumn: HexColor(totalJSON["columnsColors"][subJSON["id"]]
            .toString()
            .substring(1,
                totalJSON["columnsColors"][subJSON["id"]].toString().length)),
        columnType: subJSON["columnType"],
        isDeleted: subJSON["isDeleted"]);
  }

  static List<CellModel> convertToCellsList(json) {
    List<CellModel> cellsList = new List();
    List<dynamic> cellsListJSON = json["cells"];
    for (var newCell in cellsListJSON) {
      cellsList.add(new CellModel.fromJSON(newCell));
    }
    return cellsList;
  }

  static List<ValueCategory> convertToValueCategories(json) {
    List<ValueCategory> valueCategoryList = new List();
    List<dynamic> valueCategoryJSON = json["valueCategories"];
    for (var newValueCategory in valueCategoryJSON) {
      valueCategoryList.add(new ValueCategory.fromJSON(newValueCategory));
    }
    return valueCategoryList;
  }

  @override
  String toString() {
    return 'ColumnModel{name: $name, id: $id, cells: $cells, valueCategories: $valueCategories, columnType: $columnType, isDeleted: $isDeleted}';
  }
}
