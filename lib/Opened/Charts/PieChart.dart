import 'package:eyedatai/Classes/SeriesData.dart';
import 'package:eyedatai/FontClass.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../ColorClass.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(data.length, (index) {
              return Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      width: 20,
                      height: 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: data[index].taskColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      data[index].task.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          color: ColorClass.fontColor,
                          fontFamily: FontClass.appFont),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
        Expanded(
          child: Container(
            child: charts.PieChart(series,
                animate: true,
                animationDuration: Duration(seconds: 1),
                /*behaviors: [
                  new charts.DatumLegend(
                    outsideJustification: charts.OutsideJustification.endDrawArea,
                    horizontalFirst: false,
                    desiredMaxRows: 1,
                    cellPadding: new EdgeInsets.only(right: 4.0, bottom: 0.0),
                    entryTextStyle:
                        charts.TextStyleSpec(fontFamily: FontClass.appFont, fontSize: 11),
                  )
                ],*/
                defaultRenderer: new charts.ArcRendererConfig(
                    arcWidth: 85,
                    arcRendererDecorators: [
                      new charts.ArcLabelDecorator(
                          labelPosition: charts.ArcLabelPosition.inside)
                    ])),
          ),
        ),
      ],
    );
  }
}
