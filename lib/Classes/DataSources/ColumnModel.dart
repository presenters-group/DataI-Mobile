import 'CellModel.dart';
import 'ColumnStyleMode.dart';
import 'ValueCategory.dart';

class ColumnModel {
  var name;
  int id;
  List<CellModel> cells = new List();
  List<ValueCategory> valueCategories = new List();
  ColumnStyleMode columnStyleMode;
  var columnType;
  bool isDeleted;

  ColumnModel(
      {this.name,
        this.id,
        this.cells,
        this.valueCategories,
        this.columnType,
        this.isDeleted,
        this.columnStyleMode});

  factory ColumnModel.fromJSON(Map<String, dynamic> json) {
    return ColumnModel(
        name: json["name"],
        id: json["id"],
        cells: convertToCellsList(json),
        valueCategories: convertToValueCategories(json),
        columnStyleMode: ColumnStyleMode.fromJSON(json["style"]),
        columnType: json["columnType"],
        isDeleted: json["isDeleted"]);
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
    return 'ColumnModel{name: $name, id: $id, cells: $cells, valueCategories: $valueCategories, columnStyleMode: $columnStyleMode, columnType: $columnType, isDeleted: $isDeleted}';
  }


}
