class Measurements {
  double width = 50.0;
  double height = 50.0;
  double x = 0.0;
  double y = 0.0;

  Measurements({this.width, this.height, this.x, this.y});

  factory Measurements.fromJSON(Map<String, dynamic> json) {
    return Measurements(
        width: json["width"],
        height: json["height"],
        x: json["x"],
        y: json["y"]);
  }
}
