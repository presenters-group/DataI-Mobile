import 'package:flutter/material.dart';

import 'CoronaVirusTrackerResult.dart';

String fontString = "Anton";
double fontSize = 15;
ThemeData themeData;
String themeString = "dark";
bool themeChange = false;
String countryName;

class CoronaVirusTracker extends StatefulWidget {
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

  static void setCountryName(String countryNameP){
    countryName = countryNameP;
  }

  @override
  _CoronaVirusTrackerState createState() => _CoronaVirusTrackerState();
}

class _CoronaVirusTrackerState extends State<CoronaVirusTracker>
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
          ? Color.fromARGB(255, 45, 45, 45)
          : Colors.white,
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
                        ? Colors.deepOrangeAccent
                        : Colors.deepOrangeAccent,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              title: Text(
                countryName,
                style: TextStyle(
                  color: themeData == ThemeData.dark()
                      ? Colors.deepOrangeAccent
                      : Colors.deepOrangeAccent,
                  fontFamily: fontString,
                ),
              ),
              centerTitle: true,
              backgroundColor: themeData == ThemeData.dark()
                  ? Color.fromARGB(255, 45, 45, 45)
                  : Colors.white,
              elevation: 0.0,
            ),
          ),
          preferredSize: Size.fromHeight(65.0)),
      bottomNavigationBar: Material(
        child: Container(
          color: themeData == ThemeData.dark() ? null : Colors.white,
          decoration: themeData == ThemeData.dark()
              ? BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Colors.orangeAccent,
                //Colors.orange,
                Colors.yellow,
              ], begin: Alignment.bottomRight, end: Alignment.bottomLeft))
              : null,
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
                    ),
                CoronaVirusTrackerResult()
              ],
            )),
      ),
    );
  }
}
