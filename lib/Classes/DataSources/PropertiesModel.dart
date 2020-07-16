class PropertiesModel {
  var sourceFileType;
  int zoomValue;

  PropertiesModel({this.sourceFileType, this.zoomValue});

  factory PropertiesModel.fromJSON(Map<String, dynamic> json) {
    return PropertiesModel(
        sourceFileType: json["sourceFileType"],
        zoomValue: json["zoomValue"]);
  }
}
