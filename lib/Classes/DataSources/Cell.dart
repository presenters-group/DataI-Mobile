class Cell {
  var value;
  var type;

  Cell({this.value, this.type});

  factory Cell.fromJSON(Map<String, dynamic> json) {
    return Cell(value: json["value"], type: json["type"]);
  }
}
