class CellModel {
  var value;
  var type;

  CellModel({this.value, this.type});

  factory CellModel.fromJSON(Map<String, dynamic> json) {
    return CellModel(value: json["value"], type: json["type"]);
  }
}
