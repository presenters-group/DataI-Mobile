import 'package:flutter/material.dart';

import '../ColorClass.dart';
import 'CurrencyTrackerResult.dart';
import 'Line.dart';
import 'Series.dart';

List<List<Series>> chartsData;
String fontString = "DroidSans";
double fontSize = 15;
ThemeData themeData;
String themeString = "dark";
bool themeChange = false;
String currencyName, baseName;
ColorClass colorsClass = new ColorClass();

class CurrencyTracker extends StatefulWidget {
  static void setFont(String fontName) {
    fontString = fontName;
  }

  static void setFontSize(double fontSizeP) {
    fontSize = fontSizeP;
  }

  static void setThemeData(ThemeData themeDataP) {
    themeData = themeDataP;
  }

  static void setThemeString(String themeStringP) {
    themeString = themeStringP;
  }

  static void setThemeChange(bool themeChangeP) {
    themeChange = themeChangeP;
  }

  static setChartsData(List<List<Series>> chartsDataP) {
    chartsData = chartsDataP;
  }

  static setCurrencyName(String nameP) {
    currencyName = nameP;
  }

  static setBaseName(String baseP) {
    baseName = baseP;
  }

  @override
  _CurrencyTrackerState createState() => _CurrencyTrackerState();
}

class _CurrencyTrackerState extends State<CurrencyTracker>
    with SingleTickerProviderStateMixin {
  TabController tabController;


  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeData == ThemeData.dark()
          ? colorsClass.darkScaffoldBackgroundColor
          : colorsClass.lightScaffoldBackgroundColor,
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: themeData == ThemeData.dark()
                        ? colorsClass.darkFontColor
                        : colorsClass.lightFontColor,
                      size: 16,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: Text(
                baseName + " >> " + currencyName,
                style: TextStyle(
                  color: themeData == ThemeData.dark()
                      ? colorsClass.darkFontColor
                      : colorsClass.lightFontColor,
                    fontFamily: fontString,
                    fontSize: 16
                ),
              ),
              centerTitle: true,
              backgroundColor: themeData == ThemeData.dark()
                  ? colorsClass.darkScaffoldBackgroundColor
                  : colorsClass.lightScaffoldBackgroundColor,
              elevation: 0.0,
            ),
          ),
          preferredSize: Size.fromHeight(65.0)),
      bottomNavigationBar: Material(
        child: Container(
          color: themeData == ThemeData.dark()
              ? colorsClass.darkScaffoldBackgroundColor
              : colorsClass.lightScaffoldBackgroundColor,
          child: TabBar(
              unselectedLabelColor:
                  themeData == ThemeData.dark() ? Colors.black : Colors.black,
              controller: tabController,
              indicatorColor: Colors.deepOrangeAccent,
              labelColor: Colors.deepOrangeAccent,
              indicatorWeight: 2.5,
              tabs: [
                Icon(
                  Icons.show_chart,
                  size: 27,
                ),
                Icon(
                  Icons.table_chart,
                  size: 27,
                ),
              ]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 0.0, right: 0.0),
        child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    themeData == ThemeData.dark() ? 100.0 : 0.0),
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(0.0),
                bottomLeft: Radius.circular(0.0)),
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                Container(
                    decoration: themeData == ThemeData.dark()
                        ? BoxDecoration(
                            gradient: LinearGradient(
                                colors: <Color>[
                                Colors.orangeAccent,
                                Colors.orange,
                                Colors.yellow
                              ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft))
                        : null,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top : 60.0 , left: 12 , bottom: 8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
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
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "'$baseName' Comparing With '$currencyName' last period",
                                      style: TextStyle(
                                          fontFamily: fontString,
                                          fontSize: 12,
                                          color: themeData == ThemeData.dark()
                                              ? colorsClass.darkFontColor
                                              : colorsClass.lightFontColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Line(
                            data: chartsData,
                            titles: ["$baseName Comparing With $currencyName"],
                            isOnline: true,
                            isItem: false,
                          ),
                        ),
                      ],
                    )),
                CurrencyTrackerResult()
              ],
            )),
      ),
    );
  }
}
