class Properties {
  var sourceFileType;
  int zoomValue;
  int xColumn;

  Properties({this.sourceFileType, this.zoomValue, this.xColumn});

  factory Properties.fromJSON(Map<String, dynamic> json) {
    return Properties(
        sourceFileType: json["sourceFileType"],
        xColumn: json["xColumn"],
        zoomValue: json["zoomValue"]);
  }
}
