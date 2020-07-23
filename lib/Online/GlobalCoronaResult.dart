import 'package:flutter/material.dart';

import '../ColorClass.dart';
import 'CoronaVirus.dart';

Map<String, dynamic> globalMapAPI = new Map();
String fontString = "DroidSans";
double fontSize = 15;
ThemeData themeData;
String themeString = "dark";
bool themeChange = false;
ColorClass colorsClass = new ColorClass();

class GlobalCoronaResult extends StatelessWidget {
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

  GlobalCoronaResult();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 40,
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Total",
                      style: TextStyle(
                          fontFamily: fontString,
                          color: themeData == ThemeData.dark()
                              ? colorsClass.darkFontColor
                              : colorsClass.lightFontColor,
                          fontSize: fontSize),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 0.0, right: 50.0, left: 25.0, bottom: 8.0),
            child: Divider(
              color: themeData == ThemeData.dark()
                  ? colorsClass.darkFontColor
                  : colorsClass.lightFontColor,
              height: 0.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 50.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Total Cases : " + globalMapAPI["cases"].toString(),
                  style: TextStyle(
                      color: themeData == ThemeData.dark()
                          ? colorsClass.darkFontColor
                          : colorsClass.lightFontColor,
                      fontFamily: fontString,
                      fontSize: 13)),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 50.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "Total Recovered : " + globalMapAPI["recovered"].toString(),
                    style: TextStyle(
                        color: themeData == ThemeData.dark()
                            ? colorsClass.darkFontColor
                            : colorsClass.lightFontColor,
                        fontFamily: fontString,
                        fontSize: 13)),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, top: 4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Total Deaths : " + globalMapAPI["deaths"].toString(),
                  style: TextStyle(
                      color: themeData == ThemeData.dark()
                          ? colorsClass.darkFontColor
                          : colorsClass.lightFontColor,
                      fontFamily: fontString,
                      fontSize: 13)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 40,
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Today",
                      style: TextStyle(
                          fontFamily: fontString,
                          color: themeData == ThemeData.dark()
                              ? colorsClass.darkFontColor
                              : colorsClass.lightFontColor,
                          fontSize: fontSize),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 0.0, right: 50.0, left: 25.0, bottom: 8.0),
            child: Divider(
              color: themeData == ThemeData.dark()
                  ? colorsClass.darkFontColor
                  : colorsClass.lightFontColor,
              height: 0.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, top: 4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Today Cases : " + globalMapAPI["todayCases"].toString(),
                style: TextStyle(
                    color: themeData == ThemeData.dark()
                        ? colorsClass.darkFontColor
                        : colorsClass.lightFontColor,
                    fontFamily: fontString,
                    fontSize: 13),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 50.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Today Deaths : " + globalMapAPI["todayDeaths"].toString(),
                  style: TextStyle(
                      color: themeData == ThemeData.dark()
                          ? colorsClass.darkFontColor
                          : colorsClass.lightFontColor,
                      fontFamily: fontString,
                      fontSize: 13)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 40,
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Other",
                      style: TextStyle(
                          fontFamily: fontString,
                          color: themeData == ThemeData.dark()
                              ? colorsClass.darkFontColor
                              : colorsClass.lightFontColor,
                          fontSize: fontSize),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 0.0, right: 50.0, left: 25.0, bottom: 8.0),
            child: Divider(
              color: themeData == ThemeData.dark()
                  ? colorsClass.darkFontColor
                  : colorsClass.lightFontColor,
              height: 0.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 4.0, left: 50.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Active Cases : " +
                      globalMapAPI["active"].toString(),
                  style: TextStyle(
                      color: themeData == ThemeData.dark()
                          ? colorsClass.darkFontColor
                          : colorsClass.lightFontColor,
                      fontFamily: fontString,
                      fontSize: 13)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 4.0, left: 50.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Critical Cases : " +
                      globalMapAPI["critical"].toString(),
                  style: TextStyle(
                      color: themeData == ThemeData.dark()
                          ? colorsClass.darkFontColor
                          : colorsClass.lightFontColor,
                      fontFamily: fontString,
                      fontSize: 13)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 4.0, left: 50.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Cases Per One Million : " +
                      globalMapAPI["casesPerOneMillion"]
                          .toString(),
                  style: TextStyle(
                      color: themeData == ThemeData.dark()
                          ? colorsClass.darkFontColor
                          : colorsClass.lightFontColor,
                      fontFamily: fontString,
                      fontSize: 13)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 4.0, left: 50.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Deaths Per One Million : " +
                      globalMapAPI["deathsPerOneMillion"]
                          .toString(),
                  style: TextStyle(
                      color: themeData == ThemeData.dark()
                          ? colorsClass.darkFontColor
                          : colorsClass.lightFontColor,
                      fontFamily: fontString,
                      fontSize: 13)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 4.0, left: 50.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "Affected Countries : " +
                      globalMapAPI["affectedCountries"]
                          .toString(),
                  style: TextStyle(
                      color: themeData == ThemeData.dark()
                          ? colorsClass.darkFontColor
                          : colorsClass.lightFontColor,
                      fontFamily: fontString,
                      fontSize: 13)),
            ),
          ),
        ],
      ),
    );
    /*Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, top: 8.0, bottom: 8.0),
                                    child:  Container(
                                        width: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            "Total",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: fontString,
                                              color:
                                              themeData == ThemeData.dark()
                                                  ? colorsClass.darkFontColor
                                                  : colorsClass.lightFontColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 4.0),
                                  child: Text(
                                      "Total Cases : " +
                                          globalMapAPI["cases"].toString(),
                                      style: TextStyle(
                                          color: themeData == ThemeData.dark()
                                              ? Colors.deepOrangeAccent
                                              : Colors.white,
                                          fontFamily: fontString,
                                          fontSize: 13)),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0, left: 4.0),
                                    child: Text(
                                        "Total Recovered : " +
                                            globalMapAPI["recovered"]
                                                .toString(),
                                        style: TextStyle(
                                            color: themeData == ThemeData.dark()
                                                ? Colors.deepOrangeAccent
                                                : Colors.white,
                                            fontFamily: fontString,
                                            fontSize: 13))),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, top: 4.0),
                                  child: Text(
                                      "Total Deaths : " +
                                          globalMapAPI["deaths"].toString(),
                                      style: TextStyle(
                                          color: themeData == ThemeData.dark()
                                              ? Colors.deepOrangeAccent
                                              : Colors.white,
                                          fontFamily: fontString,
                                          fontSize: 13)),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, top: 8.0, bottom: 8.0),
                                    child:  Container(
                                        width: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            "Today",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: "Lobster",
                                              color:
                                              themeData == ThemeData.dark()
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, top: 4.0),
                                  child: Text(
                                    "Today Cases : " +
                                        globalMapAPI["todayCases"].toString(),
                                    style: TextStyle(
                                        color: themeData == ThemeData.dark()
                                            ? Colors.deepOrangeAccent
                                            : Colors.white,
                                        fontFamily: fontString,
                                        fontSize: 13),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 4.0),
                                  child: Text(
                                      "Today Deaths : " +
                                          globalMapAPI["todayDeaths"]
                                              .toString(),
                                      style: TextStyle(
                                          color: themeData == ThemeData.dark()
                                              ? Colors.deepOrangeAccent
                                              : Colors.white,
                                          fontFamily: fontString,
                                          fontSize: 13)),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, top: 8.0, bottom: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0.0),
                                          topRight: Radius.circular(15.0),
                                          bottomRight: Radius.circular(15.0),
                                          bottomLeft: Radius.circular(0.0)),
                                      child: Container(
                                        width: 40,
                                        color: Colors.red,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            "Other",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: "Lobster",
                                              color:
                                              themeData == ThemeData.dark()
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 4.0),
                                  child: Text(
                                      "Active Cases : " +
                                          globalMapAPI["active"].toString(),
                                      style: TextStyle(
                                          color: themeData == ThemeData.dark()
                                              ? Colors.deepOrangeAccent
                                              : Colors.white,
                                          fontFamily: fontString,
                                          fontSize: 13)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 4.0),
                                  child: Text(
                                      "Critical Cases : " +
                                          globalMapAPI["critical"].toString(),
                                      style: TextStyle(
                                          color: themeData == ThemeData.dark()
                                              ? Colors.deepOrangeAccent
                                              : Colors.white,
                                          fontFamily: fontString,
                                          fontSize: 13)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 4.0),
                                  child: Text(
                                      "Cases Per One Million : " +
                                          globalMapAPI["casesPerOneMillion"]
                                              .toString(),
                                      style: TextStyle(
                                          color: themeData == ThemeData.dark()
                                              ? Colors.deepOrangeAccent
                                              : Colors.white,
                                          fontFamily: fontString,
                                          fontSize: 13)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 4.0),
                                  child: Text(
                                      "Deaths Per One Million : " +
                                          globalMapAPI["deathsPerOneMillion"]
                                              .toString(),
                                      style: TextStyle(
                                          color: themeData == ThemeData.dark()
                                              ? Colors.deepOrangeAccent
                                              : Colors.white,
                                          fontFamily: fontString,
                                          fontSize: 13)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, left: 4.0),
                                  child: Text(
                                      "Affected Countries : " +
                                          globalMapAPI["affectedCountries"]
                                              .toString(),
                                      style: TextStyle(
                                          color: themeData == ThemeData.dark()
                                              ? Colors.deepOrangeAccent
                                              : Colors.white,
                                          fontFamily: fontString,
                                          fontSize: 13)),
                                ),
                              ]),
                        ),
                      ),
                      //here
                    ]),
                  )),

          ),
        ),
      );*/
  }
}
