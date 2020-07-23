import 'package:eyedatai/FontClass.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../ColorClass.dart';
import 'Series.dart';

String bottomStringLine = "", leftStringLine = "", rightStringLine = "";

class Line extends StatelessWidget {
  bool isStacked = false;
  final List<List<Series>> data;
  List<charts.Series<Series, num>> series = [];
  List<charts.Series<Series, DateTime>> seriesTime = [];
  static int barLength;
  List<dynamic> titles;
  bool isOnline;
  bool isItem = false;
  static ColorClass colorsClass = new ColorClass();
  List<Color> colors = colorsClass.generateColors();

  Line(
      {this.data, @required this.titles, @required this.isOnline, this.isItem});

  static void setLength(int lengthP) {
    barLength = lengthP;
    print("...$barLength");
  }

  int checkRowLength(int length) {
    if (length >= 8) {
      if (length <= 20)
        return length ~/ 4;
      else {
        if (length <= 30) return length ~/ 4;
        if (length < 40) return length ~/ 5;
        if (length < 50) return length ~/ 4;
        if (length < 60) return length ~/ 5;
        if (length < 70)
          return length ~/ 4;
        else
          return length ~/ 5;
      }
    }
    return 2;
  }

  void setDataInSeries() {

    for (int i = 0; i < data.length; i++) {
      series.add(
        charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(colors[i]),
          id: 'Line',
          data: data[i],
          domainFn: (Series sales, _) => sales.task,
          measureFn: (Series sales, _) => sales.taskValue,
        ),
      );
    }
  }

  void setDataInSeriesTime() {
    ColorClass colorsClass = new ColorClass();
    List<Color> colors = colorsClass.generateColors();
    for (int i = 0; i < data.length; i++) {
      seriesTime.add(
        charts.Series(
          colorFn: (__, _) => charts.ColorUtil.fromDartColor(colors[i]),
          id: 'Line',
          data: data[i],
          domainFn: (Series sales, _) => sales.task,
          measureFn: (Series sales, _) => sales.taskValue,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    series = [];
    seriesTime = [];
    isOnline ? setDataInSeriesTime() : setDataInSeries();

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: isOnline
              ? charts.TimeSeriesChart(
                  seriesTime,
                  animate: true,
                  animationDuration: Duration(seconds: 2),
                  behaviors: [
                    new charts.PanAndZoomBehavior(),
                    isItem
                        ? new charts.PanAndZoomBehavior()
                        : new charts.ChartTitle("Days",
                            titleStyleSpec: new charts.TextStyleSpec(
                                fontSize: 15, fontFamily: FontClass.appFont),
                            behaviorPosition: charts.BehaviorPosition.bottom,
                            titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea)
                  ],
                )
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Tools",
                                style: TextStyle(
                                    fontFamily: "DroidSans",
                                    color: colorsClass.lightFontColor,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: InkWell(
                              onTap: (){
                                isStacked = !isStacked;
                                (context as Element).markNeedsBuild();
                                print(isStacked);
                              },
                              child: isStacked ? Container(
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('Images/Icons/ActiveCheckBox.png'),
                                        fit: BoxFit.fill
                                    )
                                ),
                              ) : Container(
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('Images/Icons/UnActiveCheckBox.png')
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 15.0, left: 8.0, bottom: 4.0),
                      child:
                      Divider(color: colorsClass.lightFontColor, height: 0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, top: 8.0, bottom: 8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Chart",
                                style: TextStyle(
                                    fontFamily: "DroidSans",
                                    color: colorsClass.lightFontColor,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0 , top: 4.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(titles.length, (index) {
                              return Row(
                                children: <Widget>[
                                  Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 0.0,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100.0),
                                          topRight: Radius.circular(100.0),
                                          bottomRight: Radius.circular(100.0),
                                          bottomLeft: Radius.circular(100.0)),
                                      color: colors[index],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      titles[index],
                                      style: TextStyle(
                                          fontFamily: FontClass.appFont,
                                          fontSize: 10),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.0,
                    ),
                    Expanded(
                      child: charts.LineChart(
                        series,
                        defaultRenderer: new charts.LineRendererConfig(
                            includeArea: true, stacked: isStacked),
                        animate: true,
                        animationDuration: Duration(seconds: 2),
                        behaviors: [
                          new charts.PanAndZoomBehavior(),
                          bottomStringLine == ""
                              ? new charts.PanAndZoomBehavior()
                              : new charts.ChartTitle(bottomStringLine,
                                  titleStyleSpec: new charts.TextStyleSpec(
                                      fontSize: 15,
                                      fontFamily: FontClass.appFont),
                                  behaviorPosition:
                                      charts.BehaviorPosition.bottom,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea),
                          leftStringLine == ""
                              ? new charts.PanAndZoomBehavior()
                              : new charts.ChartTitle(leftStringLine,
                                  titleStyleSpec: new charts.TextStyleSpec(
                                      fontSize: 15,
                                      fontFamily: FontClass.appFont),
                                  behaviorPosition:
                                      charts.BehaviorPosition.start,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea),
                          rightStringLine == ""
                              ? new charts.PanAndZoomBehavior()
                              : new charts.ChartTitle(
                                  rightStringLine,
                                  titleStyleSpec: new charts.TextStyleSpec(
                                      fontSize: 15,
                                      fontFamily: FontClass.appFont),
                                  behaviorPosition: charts.BehaviorPosition.end,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea,
                                )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
