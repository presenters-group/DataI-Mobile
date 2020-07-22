import 'package:eyedatai/Classes/SeriesData.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../../ColorClass.dart';
import '../../FontClass.dart';

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
    /*SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(data.length, (index){
            return Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    width: 20,
                    height: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: data[index][0].taskColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    data[1][0].task.toString(),
                    style: TextStyle(
                        fontSize: 12,
                        color: ColorClass.fontColor,
                        fontFamily: FontClass.appFont),
                  ),
                )
              ],
            );
          })
      ),
    ),*/
    return Container(
      child: charts.BarChart(
        series,
        animate: true,
        animationDuration: Duration(seconds: 1),
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
