
import 'package:eyedatai/FontClass.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../ColorClass.dart';
import 'Series.dart';

bool isVertical = true;
bool isStacked = false;
String pattern;
List<charts.Series<Series, String>> series = [];

// ignore: must_be_immutable
class Bar extends StatelessWidget {
  static int barLength;
  final List<List<Series>> data;
  List<dynamic> titles;
  int width;
  bool isOnline;
  ColorClass colorsClass = new ColorClass();

  Bar(
      {@required this.data,
      @required this.titles,
      @required this.width,
      @required this.isOnline});

  static void setLength(int lengthP) {
    barLength = lengthP;
    print("...$barLength");
  }

  static void setPatternFile(String patternP) {
    pattern = patternP;
  }

  int checkBarLength(int length) {
    if (length >= 9) {
      if (length > 40) {
        return length ~/ 10;
      } else {
        if (length > 30) {
          return length ~/ 5;
        } else {
          return length ~/ 3;
        }
      }
    }
    return 8;
  }

  @override
  Widget build(BuildContext context) {
    series = [];
    for (int i = 0; i < data.length; i++) {
      series.add(charts.Series(
        id: "Bar",
        data: data[i],
        domainFn: (Series series, _) => series.task,
        measureFn: (Series series, _) => series.taskValue,
        colorFn: (Series series, _) =>
            charts.ColorUtil.fromDartColor(series.taskColor),
      ));
    }
    print("hoho");
    print(width);
    print(isOnline);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(8.0),
        child: isOnline == true
            ? Container(
                child: charts.BarChart(
                  series,
                  animate: true,
                  animationDuration: Duration(seconds: 2),
                ),
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
                        /*Container(
                          child: Checkbox(
                            value: isStacked,
                            activeColor: prefix1.themeData == ThemeData.dark()
                                ? Colors.blue
                                : Colors.deepOrangeAccent,
                            onChanged: (bool value) {
                              isStacked = !isStacked;
                              value = isStacked;
                              (context as Element).markNeedsBuild();
                              print(isStacked);
                            },
                          ),
                        ),*/
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 15.0),
                          child: InkWell(
                            onTap: () {
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'Images/Icons/Rotate.png'))),
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
                    child: (width == 2)
                        ? Container(
                            width: 0.0,
                            height: 0.0,
                          )
                        : Align(
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
                                          color: data[index][index].taskColor,
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
                  Expanded(
                    child: charts.BarChart(
                      series,
                      animate: true,
                      vertical: isVertical,
                      barGroupingType: isStacked == true
                          ? charts.BarGroupingType.stacked
                          : charts.BarGroupingType.grouped,
                      animationDuration: Duration(seconds: 2),
                      domainAxis: new charts.OrdinalAxisSpec(
                          renderSpec: new charts.SmallTickRendererSpec(
                              minimumPaddingBetweenLabelsPx: 0,
                              labelStyle: new charts.TextStyleSpec(
                                  fontSize: checkBarLength(barLength),
                                  color: charts.MaterialPalette.black),

                              // Change the line colors to match text color.
                              lineStyle: new charts.LineStyleSpec(
                                  color: charts.MaterialPalette.black))),

                      /* primaryMeasureAxis: new charts.NumericAxisSpec(
                    renderSpec: new charts.GridlineRendererSpec(

                      // Tick and Label styling here.
                        labelStyle: new charts.TextStyleSpec(
                            fontFamily: "Lobster",// size in Pts.
                            color: charts.MaterialPalette.black),

                        // Change the line colors to match text color.
//                  lineStyle: new charts.LineStyleSpec(
//                      color: charts.MaterialPalette.black)
                       )),*/
                      /*domainAxis: charts.OrdinalAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(labelRotation: 60),
                ),*/
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
