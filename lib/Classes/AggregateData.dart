import 'package:eyedatai/Classes/DataSources/ColumnModel.dart';
import 'package:eyedatai/Classes/SeriesData.dart';

class AggregateData {
  List<List<SeriesData>> seriesData = new List();
  String typeChart;

  AggregateData({this.seriesData, this.typeChart});

  factory AggregateData.fromVisualizer(List<ColumnModel> colM, String typeChart) {
    return AggregateData(
        seriesData: convertToSeriesData(colM),
        typeChart: typeChart
    );
  }

  static List<List<SeriesData>> convertToSeriesData(List<ColumnModel> colM) {
    List<List<SeriesData>> data = new List();
    List<SeriesData> dataSingle = new List();
    /*for (int j = 1; j <= width - 1; j++) {
      for (int i = 1; i < dataCSV.length; i++) {
        if (width == 2) {
          dataSingle.add(
            new SeriesData(
                task: dataCSV[i][0],
                taskValue: int.parse(dataCSV[i][j].trim()),
                taskColor: colors[i]),
          );
        } else {
          dataSingle.add(
            new SeriesData(
                task: dataCSV[i][0],
                taskValue: int.parse(dataCSV[i][j].trim()),
                taskColor: colors[j]),
          );
        }
      }
      data.add(dataSingle);
      dataSingle = [];
    }*/
    return data;
  }
}
