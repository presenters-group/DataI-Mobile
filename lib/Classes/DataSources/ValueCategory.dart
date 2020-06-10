class ValueCategory {
  var value;
  var type;

  ValueCategory({this.value, this.type});

  factory ValueCategory.fromJSON(Map<String, dynamic> json) {
    return ValueCategory(value: json["value"], type: json["type"]);
  }
}
