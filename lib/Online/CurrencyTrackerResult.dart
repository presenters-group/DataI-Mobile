import 'package:eyedatai/FontClass.dart';
import 'package:flutter/material.dart';
import '../ColorClass.dart';

List<dynamic> valuesOfCurrencyForWeek = new List();
List<String> dates = new List();
final GlobalKey<ScaffoldState> _drawerHome = new GlobalKey<ScaffoldState>();
ColorClass colorsClass = new ColorClass();

class CurrencyTrackerResult extends StatelessWidget {
  static setValuesCurrencyForWeek(List<dynamic> valuesOfCurrencyForWeekP) {
    valuesOfCurrencyForWeek = valuesOfCurrencyForWeekP;
  }

  static setDates(List<String> datesP) {
    dates = datesP;
  }

  bool isScrollable(Widget widget) =>
      widget is ScrollView || widget is SingleChildScrollView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorsClass.lightScaffoldBackgroundColor,
      key: _drawerHome,
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, left: 4.0, right: 10.0, bottom: 0.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ListTile(
                        title: Text(
                          "Dates",
                          style: TextStyle(
                              fontFamily: FontClass.appFont,
                              color:  colorsClass.lightFontColor,
                              fontSize: 17),
                        ),
                        trailing: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('Images/Icons/Date.png'))),
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Container(
                color: colorsClass.lightContainerBackground,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                            children: List.generate(dates.length, (index) {
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    dates[index] +
                                        "   |   " +
                                        valuesOfCurrencyForWeek[index]
                                            .toString(),
                                    style: TextStyle(
                                        color:colorsClass.lightFontColor,
                                        fontFamily: FontClass.appFont,
                                        fontSize: 15)),
                              ),
                              Text(
                                  "_____________________________________________"),
                            ],
                          );
                        })),
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
