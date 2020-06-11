class Filter {
  var name;
  int id;
  int dataSource;
  int filteredColumn;
  var initValue;
  String type;
  bool isDeleted;

  Filter(
      {this.name,
      this.id,
      this.dataSource,
      this.filteredColumn,
      this.initValue,
      this.type,
      this.isDeleted});

  factory Filter.fromJSON(Map<String, dynamic> json) {
    return Filter(
        name: json["name"],
        id: json["id"],
        dataSource: json["dataSource"],
        filteredColumn: json["filteredColumn"],
        initValue: json["initValue"].toString(),
        type: json["type"],
        isDeleted: json["isDeleted"]);
  }
}
