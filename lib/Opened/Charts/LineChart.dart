import 'package:eyedatai/Classes/SeriesData.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LineChart extends StatelessWidget {
  final List<List<SeriesData>> data;
  List<charts.Series<SeriesData, num>> series = [];


  LineChart(this.data);

  @override
  Widget build(BuildContext context) {
    series = [];
    for (int i = 0; i < data.length; i++) {
      series.add(
        charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.green),
          id: 'Line',
          data: data[i],
          domainFn: (SeriesData seriesData, _) => seriesData.task,
          measureFn: (SeriesData seriesData, _) => seriesData.taskValue,
        ),
      );
    }
    return Container(
      child: charts.LineChart(
        series,
        defaultRenderer: new charts.LineRendererConfig(
            includeArea: true, stacked: true),
        animate: true,
        animationDuration: Duration(seconds: 1),
        behaviors: [
          new charts.PanAndZoomBehavior(),
        ],
      ),
    );
  }
}
