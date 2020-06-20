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

  FilterModel(
      {this.dataSource,
      this.name,
      this.id,
      this.dataSourceID,
      this.filteredColumn,
      this.initValue,
      this.type,
      this.isDeleted});

  factory FilterModel.fromJSON(
      Map<String, dynamic> json, Map<String, dynamic> totalJSON) {
    return FilterModel(
        dataSource: checkFilter(totalJSON, json["dataSource"]),
        name: json["name"],
        id: json["id"],
        dataSourceID: json["dataSource"],
        filteredColumn: json["filteredColumn"],
        initValue: json["initValue"].toString(),
        type: json["type"],
        isDeleted: json["isDeleted"]);
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
}
