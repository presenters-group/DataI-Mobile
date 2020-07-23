import 'package:flutter/material.dart';
import '../ColorClass.dart';
import 'Bar.dart';
import 'GlobalCoronaResult.dart';

import 'Series.dart';

String fontString = "DroidSans";
double fontSize = 15;
ThemeData themeData;
String themeString = "dark";
bool themeChange = false;
List<List<Series>> globalData = new List();
List<Series> singleGlobalData = new List();
Map<String, dynamic> globalMapAPI = new Map();
List<Color> thingsColors = [Colors.indigo, Colors.green, Colors.red];
List<String> thingsTitle = [
  " Total Confirmed ",
  " Total Recovered ",
  " Total Deaths "
];
ColorClass colorsClass = new ColorClass();

class GlobalCoronaVirus extends StatefulWidget {
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

  static setGlobalData(Map<String, dynamic> globalMapAPIP) {
    globalMapAPI = globalMapAPIP;
  }

  @override
  _GlobalCoronaVirusState createState() => _GlobalCoronaVirusState();
}

class _GlobalCoronaVirusState extends State<GlobalCoronaVirus>
    with SingleTickerProviderStateMixin {
  TabController tabController;


  @override
  void initState() {
    super.initState();
    singleGlobalData = [];
    globalData = [];

    var deaths = [
      new Series(
          task: ".", taskValue: globalMapAPI["deaths"], taskColor: Colors.red)
    ];
    var confirmed = [
      new Series(
          task: ".", taskValue: globalMapAPI["cases"], taskColor: Colors.indigo)
    ];
    var recovered = [
      new Series(
          task: ".",
          taskValue: globalMapAPI["recovered"],
          taskColor: Colors.green)
    ];
    globalData.add(confirmed);
    globalData.add(recovered);
    globalData.add(deaths);

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
                "Corona Virus World Wide",
                style: TextStyle(
                    color: themeData == ThemeData.dark()
                        ? colorsClass.darkFontColor
                        : colorsClass.lightFontColor,
                    fontFamily: fontString,
                    fontSize: 16),
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
                  Icons.equalizer,
                  size: 27,
                ),
                Icon(
                  Icons.table_chart,
                  size: 27,
                ),
              ]),
        ),
      ),
      body:  Container(
          child: TabBarView(
            controller: tabController,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 15.0),
                    child: Row(
                        children: List.generate(3, (index) {
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
                              color: thingsColors[index],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              thingsTitle[index],
                              style: TextStyle(
                                  fontFamily: fontString, fontSize: 10),
                            ),
                          ),
                        ],
                      );
                    })),
                  ),
                  Expanded(
                    child: Bar(
                      data: globalData,
                      isOnline: true,
                      width: 3,
                      titles: [],
                    ),
                  ),
                ],
              ),
              GlobalCoronaResult()
            ],
          ),
        ),

    );
  }
}
