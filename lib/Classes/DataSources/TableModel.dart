import 'dart:ui';

import 'package:eyedatai/Classes/DataSources/ColumnModel.dart';
import 'package:eyedatai/Classes/DataSources/PropertiesModel.dart';

import '../ChartData.dart';
import 'Filter.dart';

class TableModel {
  var name;
  int id;
  List<ColumnModel> columnsList = new List();
  List<dynamic> columnsVisibility = new List();
  List<dynamic> rowsVisibility = new List();
  PropertiesModel property;
  bool rightToLeft;
  bool isDeleted;
  List<Filter> filters = new List();
  List<Color> columnsColors = new List();

  TableModel(
      {this.name,
      this.id,
      this.columnsList,
      this.columnsVisibility,
      this.rowsVisibility,
      this.property,
      this.rightToLeft,
      this.isDeleted,
      this.filters,
        this.columnsColors
      });

  factory TableModel.fromJSON(Map<String, dynamic> subJSON) {
    return TableModel(
        name: subJSON["name"],
        id: subJSON["id"],
        columnsList: convertToColumnsList(subJSON),
        columnsVisibility: subJSON["columnsVisibility"],
        rowsVisibility: subJSON["rowsVisibility"],
        property: PropertiesModel.fromJSON(subJSON["properties"]),
        rightToLeft: subJSON["rightToLeft"],
        isDeleted: subJSON["isDeleted"],
        filters: convertToFiltersList(subJSON),
        columnsColors : convertToColumnsColors(subJSON["columnsColors"]));
  }

  static List<Color> convertToColumnsColors(dynamicColors){
    List<Color> columnsColors = new List();
    for (int i = 0; i < dynamicColors.length; i++) {
      columnsColors.add(HexColor(dynamicColors[i]
          .toString()
          .substring(1, dynamicColors[i].toString().length)));
    }
    return columnsColors;
  }

  static List<Filter> convertToFiltersList(json) {
    List<Filter> filtersList = new List();
    List<dynamic> filtersJSON = json["filters"];
    for (var newFilter in filtersJSON) {
      filtersList.add(Filter.fromJSON(newFilter));
    }
    return filtersList;
  }

  static List<ColumnModel> convertToColumnsList(json) {
    List<ColumnModel> columnsList = new List();
    List<dynamic> columnsJSON = json["columns"];
    for (var newColumn in columnsJSON) {
      columnsList.add(new ColumnModel.fromJSON(newColumn , json));
    }
    return columnsList;
  }

  @override
  String toString() {
    return 'TableModel{name: $name, id: $id, columnsList: $columnsList, columnsVisibility: $columnsVisibility, rowsVisibility: $rowsVisibility, property: $property, rightToLeft: $rightToLeft, isDeleted: $isDeleted, filter: $filters}';
  }
}
