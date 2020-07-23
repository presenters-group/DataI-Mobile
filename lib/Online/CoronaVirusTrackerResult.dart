import 'package:eyedatai/FontClass.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../ColorClass.dart';

int newDeaths, newRecovered, newConfirmed;
int totalDeaths, totalConfirmed, totalRecovered;
final GlobalKey<ScaffoldState> _drawerHome = new GlobalKey<ScaffoldState>();

class CoronaVirusTrackerResult extends StatelessWidget {
  List<dynamic> datesAPI = new List();
  List<int> data = new List();
  int keyType;

  CoronaVirusTrackerResult({this.datesAPI, this.data, this.keyType});

  static void setNewDeaths(int deathsP) {
    newDeaths = deathsP;
  }

  static void setNewRecovered(int recoveredP) {
    newRecovered = recoveredP;
  }

  static void setNewConfirmed(int confirmedP) {
    newConfirmed = confirmedP;
  }

  static void setTotalDeaths(int deathsP) {
    totalDeaths = deathsP;
  }

  static void setTotalConfirmed(int confirmedP) {
    totalConfirmed = confirmedP;
  }

  static setTotalRecovered(int recoveredP) {
    totalRecovered = recoveredP;
  }

  bool isScrollable(Widget widget) =>
      widget is ScrollView || widget is SingleChildScrollView;
  ColorClass colorsClass = new ColorClass();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorsClass.lightScaffoldBackgroundColor,
      key: _drawerHome,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 4.0, right: 10.0, bottom: 0.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Dates",
                      style: TextStyle(
                          fontFamily: FontClass.appFont,
                          color: colorsClass.lightFontColor,
                          fontSize: 17),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: colorsClass.lightContainerBackground,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(data.length, (index) {
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              datesAPI[index]
                                                      .toString()
                                                      .substring(0, 10) +
                                                  "   |   " +
                                                  data[index].toString(),
                                              style: TextStyle(
                                                  color: colorsClass
                                                          .lightFontColor,
                                                  fontFamily: FontClass.appFont,
                                                  fontSize: 15)),
                                        ),
                                        Text(
                                            "_____________________________________________"),
                                      ],
                                    );
                                  })),
                            ),
                          ),
                        ]),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
