import 'Measurements.dart';

class Filter {
  int id;
  int visioId;
  var value;
  bool isActive;
  Measurements measurements;

  Filter({this.id, this.visioId, this.value, this.isActive, this.measurements});

  factory Filter.fromJSON(Map<String, dynamic> json) {
    return Filter(
        id: json["id"],
        visioId: json["visioId"] == null ? -1 : json["visioId"],
        value: json["value"],
        isActive: json["isActive"],
        measurements: json["measurements"] == null
            ? new Measurements()
            : Measurements.fromJSON(json["measurements"]));
  }
}
