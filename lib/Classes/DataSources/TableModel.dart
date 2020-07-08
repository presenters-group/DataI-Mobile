import 'package:eyedatai/Classes/DataSources/ColumnModel.dart';
import 'package:eyedatai/Classes/DataSources/PropertiesModel.dart';

class TableModel {
  var name;
  int id;
  List<ColumnModel> columnsList = new List();
  List<dynamic> columnsVisibility = new List();
  List<dynamic> rowsVisibility = new List();
  PropertiesModel property;
  bool rightToLeft;
  bool isDeleted;

  TableModel(
      {this.name,
        this.id,
        this.columnsList,
        this.columnsVisibility,
        this.rowsVisibility,
        this.property,
        this.rightToLeft,
        this.isDeleted});

  factory TableModel.fromJSON(Map<String, dynamic> json) {
    return TableModel(
        name: json["name"],
        id: json["id"],
        columnsList: convertToColumnsList(json),
        columnsVisibility: json["columnsVisibility"],
        rowsVisibility: json["rowsVisibility"],
        property: PropertiesModel.fromJSON(json["properties"]),
        rightToLeft: json["rightToLeft"],
        isDeleted: json["isDeleted"]);
  }

  static List<ColumnModel> convertToColumnsList(json) {
    List<ColumnModel> columnsList = new List();
    List<dynamic> columnsJSON = json["columns"];
    for (var newColumn in columnsJSON) {
      columnsList.add(new ColumnModel.fromJSON(newColumn));
    }
    //columnsList.sort((a, b) => b.columnType.compareTo(a.columnType));
    return columnsList;
  }

  @override
  String toString() {
    return 'TableModel{name: $name, id: $id, listColumns: $columnsList, columnsVisibility: $columnsVisibility, rowsVisibility: $rowsVisibility, property: $property, rightToLeft: $rightToLeft, isDeleted: $isDeleted}';
  }
}
