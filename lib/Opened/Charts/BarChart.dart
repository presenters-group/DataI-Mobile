import 'package:eyedatai/Classes/SeriesData.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChart extends StatelessWidget {
  List<charts.Series<SeriesData, String>> series = [];
  final List<List<SeriesData>> data;

  BarChart(this.data);

  @override
  Widget build(BuildContext context) {
    series = [];
    for (int i = 0; i < data.length; i++) {
      series.add(charts.Series(
        id: "Bar",
        data: data[i],
        domainFn: (SeriesData series, _) => series.task,
        measureFn: (SeriesData series, _) => series.taskValue,
        colorFn: (SeriesData series, _) =>
            charts.ColorUtil.fromDartColor(series.taskColor),
      ));
    }
    return Container(
      child: charts.BarChart(
        series,
        animate: true,
        animationDuration: Duration(seconds: 2),
        domainAxis: new charts.OrdinalAxisSpec(
            renderSpec: new charts.SmallTickRendererSpec(
                minimumPaddingBetweenLabelsPx: 0,
                labelStyle: new charts.TextStyleSpec(
                    fontSize: 10, color: charts.MaterialPalette.black),
                lineStyle: new charts.LineStyleSpec(
                    color: charts.MaterialPalette.black))),
      ),
    );
  }
}
