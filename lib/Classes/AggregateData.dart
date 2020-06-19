import 'package:eyedatai/Classes/DataSources/ColumnModel.dart';
import 'package:eyedatai/Classes/SeriesData.dart';


class AggregateData {
  List<List<SeriesData>> seriesDataBar = new List();
  List<SeriesData> seriesDataPie = new List();
  int xColumn;

  AggregateData({this.seriesDataBar, this.seriesDataPie, this.xColumn});

  factory AggregateData.fromVisualizer(List<ColumnModel> colM, int xColumn) {
    return AggregateData(
        seriesDataBar: convertToSeriesData(colM, xColumn),
        seriesDataPie: convertToSeriesDataPie(colM, xColumn),
        xColumn: xColumn);
  }

  static List<List<SeriesData>> convertToSeriesData(
      List<ColumnModel> colM, int xColumn) {
    List<List<SeriesData>> seriesData = new List();
    List<SeriesData> dataSingle = new List();
    List<List<dynamic>> dataUsed = new List();
    List<dynamic> row = new List();
    ColumnModel tempColumnModel;

    for (int i = 0; i < colM.length; i++) {
      if (colM[i].id == xColumn) {
        tempColumnModel = colM[i];
        colM.remove(colM[i]);
      }
    }
    colM.insert(0, tempColumnModel);

    //cells
    for (int j = 0; j < colM[0].valueCategories.length; j++) {
      for (int i = 0; i < colM.length; i++) {
        row.add(colM[i].valueCategories[j].value);
      }
      dataUsed.add(row);
      print(row);
      row = [];
    }
    print(dataUsed[0][0]);

    /*
    print(dataUsed);
    for (int j = 1; j <= dataUsed[0].length - 1; j++) {
      for (int i = 1; i < dataUsed.length; i++) {
        if (dataUsed[0].length == 2) {
          dataSingle.add(
            new SeriesData(
                task: dataUsed[i][0],
                taskValue: int.parse(dataUsed[i][j].toString().trim()),
                taskColor: colM[0].columnStyleMode.color),
          );
        } else {
          dataSingle.add(
            new SeriesData(
                task: dataUsed[i][0],
                taskValue: dataUsed[i][j],
                taskColor: colM[0].columnStyleMode.color),
          );
        }
      }
      seriesData.add(dataSingle);
      dataSingle = [];
    }*/

    for (int j = 1; j <= colM.length - 1; j++) {
      for (int i = 1; i < dataUsed.length; i++) {
        dataSingle.add(new SeriesData(
            task: dataUsed[i][0].toString(),
            taskValue: dataUsed[i][j],
            taskColor: colM[j].columnStyleMode.color)); //colors[j]
      }
      seriesData.add(dataSingle);
      dataSingle = [];
    }

    return seriesData;
  }

  static List<SeriesData> convertToSeriesDataPie(
      List<ColumnModel> colM, int xColumn) {
    List<SeriesData> dataPieChart = new List();
    List<List<dynamic>> dataUsed = new List();
    List<dynamic> row = new List();
    ColumnModel tempColumnModel;

    for (int i = 0; i < colM.length; i++) {
      if (colM[i].id == xColumn) {
        tempColumnModel = colM[i];
        colM.remove(colM[i]);
      }
    }
    colM.insert(0, tempColumnModel);

    //cells
    for (int j = 0; j < colM[0].valueCategories.length; j++) {
      for (int i = 0; i < colM.length; i++) {
        row.add(colM[i].valueCategories[j].value);
      }
      dataUsed.add(row);
      print(row);
      row = [];
    }

    List<dynamic> sumRows = new List();
    List<List<dynamic>> listRows = new List();
    List<dynamic> sumRow = new List();
    for (int i = 1; i < dataUsed.length; i++) {
      for (int j = 1; j <= colM.length - 1; j++) {
        sumRow.add(dataUsed[i][j]);
      }
      listRows.add(sumRow);
      print(sumRow);
      sumRow = new List();
    }
    print(listRows);
    for (int i = 0; i < listRows.length; i++) {
      sumRows.add(listRows[i].reduce((a, b) => a + b));
    }
    print(sumRows);
    print("*********************************");
    print(dataUsed.length);
    print(colM.length);
    print("*********************************");
    for (int i = 1; i < dataUsed.length; i++) {
      dataPieChart.add(new SeriesData(
          task: dataUsed[i][0],
          taskValue: sumRows[i - 1],
          taskColor: colM[0].columnStyleMode.color));
    }
    return dataPieChart;
  }
}
