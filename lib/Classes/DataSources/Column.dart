import 'Cell.dart';
import 'ValueCategory.dart';

class Column {
  var name;
  int id;
  List<Cell> cells = new List();
  List<ValueCategory> valueCategories = new List();
  var columnType;
  bool isDeleted;

  Column(
      {this.name,
        this.id,
        this.cells,
        this.valueCategories,
        this.columnType,
        this.isDeleted});

  factory Column.fromJSON(Map<String, dynamic> json) {
    return Column(
        name: json["name"],
        id: json["id"],
        cells: convertToCellsList(json),
        valueCategories: convertToValueCategories(json),
        columnType: json["columnType"],
        isDeleted: json["isDeleted"]);
  }

  static List<Cell> convertToCellsList(json) {
    List<Cell> cellsList = new List();
    List<dynamic> cellsListJSON = json["cells"];
    for (var newCell in cellsListJSON) {
      cellsList.add(new Cell.fromJSON(newCell));
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
}
