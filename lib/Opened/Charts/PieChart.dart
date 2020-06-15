import 'package:eyedatai/Classes/SeriesData.dart';
import 'package:eyedatai/FontClass.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChart extends StatelessWidget {
  final List<SeriesData> data;
  List<charts.Series<SeriesData, String>> series = [];

  PieChart(this.data);

  @override
  Widget build(BuildContext context) {
    series = [];
    series.add(
      charts.Series(
        domainFn: (SeriesData seriesData, _) => seriesData.task,
        measureFn: (SeriesData seriesData, _) => seriesData.taskValue,
        colorFn: (SeriesData seriesData, _) =>
            charts.ColorUtil.fromDartColor(seriesData.taskColor),
        id: 'Pie',
        data: data,
        labelAccessorFn: (SeriesData series, _) => '${series.taskValue}',
      ),
    );
    return Container(
      child: charts.PieChart(series,
          animate: true,
          animationDuration: Duration(seconds: 2),
          behaviors: [
            new charts.DatumLegend(
              outsideJustification: charts.OutsideJustification.endDrawArea,
              horizontalFirst: false,
              desiredMaxRows: 5,
              cellPadding: new EdgeInsets.only(right: 4.0, bottom: 0.0),
              entryTextStyle:
                  charts.TextStyleSpec(fontFamily: FontClass.appFont, fontSize: 11),
            )
          ],
          defaultRenderer: new charts.ArcRendererConfig(
              arcWidth: 85,
              arcRendererDecorators: [
                new charts.ArcLabelDecorator(
                    labelPosition: charts.ArcLabelPosition.inside)
              ])),
    );
  }
}
