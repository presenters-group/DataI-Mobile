class PropertiesModel {
  var sourceFileType;
  int zoomValue;
  int xColumn;

  PropertiesModel({this.sourceFileType, this.zoomValue, this.xColumn});

  factory PropertiesModel.fromJSON(Map<String, dynamic> json) {
    return PropertiesModel(
        sourceFileType: json["sourceFileType"],
        xColumn: json["xColumn"],
        zoomValue: json["zoomValue"]);
  }
}
