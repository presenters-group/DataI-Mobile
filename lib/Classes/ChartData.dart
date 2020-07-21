import 'dart:ui';

import 'package:eyedatai/Classes/DataSources/ColumnModel.dart';
import 'package:eyedatai/Classes/SeriesData.dart';
import 'package:eyedatai/ColorClass.dart';

class ChartData {
  List<List<SeriesData>> seriesDataBar = new List();
  List<List<SeriesData>> seriesDataLine = new List();
  List<SeriesData> seriesDataPie = new List();
  int xColumn;

  ChartData(
      {this.seriesDataBar,
      this.seriesDataPie,
      this.seriesDataLine,
      this.xColumn});

  factory ChartData.fromVisualizer(
      json, List<ColumnModel> colM, int xColumn, int dataID) {
    return ChartData(
        seriesDataBar: convertToSeriesDataBar(json, colM, xColumn, dataID),
        seriesDataLine: convertToSeriesDataLine(colM, xColumn),
        seriesDataPie: convertToSeriesDataPie(json, colM, xColumn, dataID),
        xColumn: xColumn);
  }

  static List<List<SeriesData>> convertToSeriesDataBar(
      json, List<ColumnModel> colM, int xColumn, int dataID) {
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
    for (int j = 0; j < colM[0].cells.length; j++) {
      for (int i = 0; i < colM.length; i++) {
        row.add(colM[i].cells[j].value);
      }
      dataUsed.add(row);
      print(row);
      row = [];
    }
    print("//++++++++++++++++++++++++++++++++++++++++++++++//");
    print(dataUsed);

    List<dynamic> dynamicColors = new List();
    dynamicColors = json["dataSources"][dataID]["columnsColors"];
    List<Color> columnsColors = new List();
    for (int i = 0; i < dynamicColors.length; i++) {
      columnsColors.add(HexColor(dynamicColors[i]
          .toString()
          .substring(1, dynamicColors[i].toString().length)));
    }

    for (int j = 1; j <= colM.length - 1; j++) {
      for (int i = 1; i < dataUsed.length; i++) {
        dataSingle.add(new SeriesData(
            task: dataUsed[i][0].toString(),
            taskValue: dataUsed[i][j],
            taskColor: columnsColors[j])); //colors[j]
        //colM[j].columnStyleMode.color
      }
      seriesData.add(dataSingle);
      dataSingle = [];
    }

    return seriesData;
  }

  static isNumeric(string) => num.tryParse(string) != null;

  static List<List<SeriesData>> convertToSeriesDataLine(colM, xColumn) {
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

    print("***********////////**********");
    print(dataUsed[1][0].toString());
    if (isNumeric(dataUsed[1][0])) {
      print("yes");
      for (int j = 1; j <= colM.length - 1; j++) {
        for (int i = 1; i < dataUsed.length; i++) {
          dataSingle.add(
            new SeriesData(
                task: int.parse(dataUsed[i][0].trim()),
                taskValue: int.parse(dataUsed[i][j].trim())),
          );
        }
        seriesData.add(dataSingle);
        dataSingle = [];
      }
    }

    return seriesData;
  }

  static List<SeriesData> convertToSeriesDataPie(
      json, List<ColumnModel> colM, int xColumn, int dataID) {
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

    List<dynamic> dynamicColors = new List();
    dynamicColors = json["dataSources"][dataID]["columnsColors"];
    List<Color> columnsColors = new List();
    for (int i = 0; i < dynamicColors.length; i++) {
      columnsColors.add(HexColor(dynamicColors[i]
          .toString()
          .substring(1, dynamicColors[i].toString().length)));
    }

    ColorClass colorClass = new ColorClass();
    List<Color> colors = colorClass.generateColors();
    for (int i = 0; i < colM.length; i++) {
      colors.insert(i, columnsColors[i]); //colM[i].columnStyleMode.color
    }
    for (int i = 1; i < dataUsed.length; i++) {
      dataPieChart.add(new SeriesData(
          task: dataUsed[i][0],
          taskValue: sumRows[i - 1],
          taskColor: colors[i]));
      //colM[0].columnStyleMode.color
    }
    return dataPieChart;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
