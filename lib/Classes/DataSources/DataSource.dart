import 'package:eyedatai/Classes/DataSources/Column.dart';
import 'package:eyedatai/Classes/DataSources/Properties.dart';

class DataSource {
  var name;
  int id;
  List<Column> listColumns = new List();
  List<dynamic> columnsVisibility = new List();
  List<dynamic> rowsVisibility = new List();
  Properties property;
  bool rightToLeft;
  bool isDeleted;

  DataSource(
      {this.name,
        this.id,
        this.listColumns,
        this.columnsVisibility,
        this.rowsVisibility,
        this.property,
        this.rightToLeft,
        this.isDeleted});

  factory DataSource.fromJSON(Map<String, dynamic> json) {
    return DataSource(
        name: json["name"],
        id: json["id"],
        listColumns: convertToColumnsList(json),
        columnsVisibility: json["columnsVisibility"],
        rowsVisibility: json["rowsVisibility"],
        property: Properties.fromJSON(json["properties"]),
        rightToLeft: json["rightToLeft"],
        isDeleted: json["isDeleted"]);
  }

  static List<Column> convertToColumnsList(json) {
    List<Column> columnsList = new List();
    List<dynamic> columnsJSON = json["columns"];
    for (var newColumn in columnsJSON) {
      columnsList.add(new Column.fromJSON(newColumn));
    }
    return columnsList;
  }
}
