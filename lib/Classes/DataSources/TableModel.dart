import 'package:eyedatai/Classes/DataSources/ColumnModel.dart';
import 'package:eyedatai/Classes/DataSources/PropertiesModel.dart';

class TableModel {
  var name;
  int id;
  List<ColumnModel> listColumns = new List();
  List<dynamic> columnsVisibility = new List();
  List<dynamic> rowsVisibility = new List();
  PropertiesModel property;
  bool rightToLeft;
  bool isDeleted;

  TableModel(
      {this.name,
      this.id,
      this.listColumns,
      this.columnsVisibility,
      this.rowsVisibility,
      this.property,
      this.rightToLeft,
      this.isDeleted});

  factory TableModel.fromJSON(Map<String, dynamic> json) {
    return TableModel(
        name: json["name"],
        id: json["id"],
        listColumns: convertToColumnsList(json),
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
    return columnsList;
  }

  @override
  String toString() {
    return 'DataSource{name: $name, id: $id, listColumns: $listColumns, columnsVisibility: $columnsVisibility, rowsVisibility: $rowsVisibility, property: $property, rightToLeft: $rightToLeft, isDeleted: $isDeleted}';
  }
}
