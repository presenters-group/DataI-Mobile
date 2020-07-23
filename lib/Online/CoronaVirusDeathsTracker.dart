import 'dart:convert';

import 'package:flutter/material.dart';
import '../ColorClass.dart';
import 'CoronaVirusTrackerResult.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart' as kit;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Line.dart';
import 'Series.dart';

String fontString = "Anton";
double fontSize = 15;
ThemeData themeData;
String themeString = "dark";
bool themeChange = false;
String countryName, countrySlug, request;
List<dynamic> dataAPI = new List();
bool isLoading = false;
List<int> deathsData = new List();
List<List<Series>> dataLineAPI;
List<dynamic> datesAPI = new List();
String _value = "All Data", kind;
ColorClass colorsClass = new ColorClass();

class CoronaVirusDeathsTracker extends StatefulWidget {
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

  static void setCountryName(String countryNameP) {
    countryName = countryNameP;
  }

  static void setCountrySlug(String slugP) {
    countrySlug = slugP;
  }

  @override
  _CoronaVirusDeathsTrackerState createState() =>
      _CoronaVirusDeathsTrackerState();
}

class _CoronaVirusDeathsTrackerState extends State<CoronaVirusDeathsTracker>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  getDataAPI() async {
    deathsData = [];
    dataLineAPI = [];
    datesAPI = [];
    print(request);
    setState(() {
      isLoading = true;
    });
    http.Response response = await http
        .get(Uri.encodeFull(request), headers: {"Accept": "Application/json"});

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed Loading .... !!!! ');
    }
    dataAPI = json.decode(response.body);

    print(dataAPI);
    for (var data in dataAPI) {
      data.forEach((data, val) {
        //Cases
        //Deaths
        if (data == kind) {
          deathsData.add(val.toInt());
        }
      });
      datesAPI.add(data["Date"]);
    }
    print(deathsData);
    print(datesAPI);
    List<int> days = new List();

    for (var value in datesAPI) {
      days.add(int.parse(value.substring(8, 10)));
    }

    print(datesAPI[0].toString().substring(0, 4));
    print(datesAPI[0].toString().substring(5, 7));
    print(datesAPI[0].toString().substring(8, 10));
    List<Series> dayDeaths = new List();
    for (int i = 0; i < deathsData.length; i++) {
      dayDeaths.add(Series(
        task: new DateTime(
            int.parse(datesAPI[i].toString().substring(0, 4)),
            int.parse(datesAPI[i].toString().substring(5, 7)),
            int.parse(datesAPI[i].toString().substring(8, 10))),
        taskValue: deathsData[i],
      ));
    }
    dataLineAPI.add(dayDeaths);
    dayDeaths = [];
  }


  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    //https://api.covid19api.com/total/country/$countrySlug/status/confirmed
    //"https://api.covid19api.com/live/country/$countrySlug/status/deaths/date/2020-03-21T13:13:30Z"
    request =
        "https://api.covid19api.com/total/country/$countrySlug/status/deaths";
    kind = "Cases";
    _value = "All Data";
    dataAPI = [];
    getDataAPI();
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
                  tooltip: "Back",
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
              title: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      countryName,
                      style: TextStyle(
                          color: themeData == ThemeData.dark()
                              ? colorsClass.darkFontColor
                              : colorsClass.lightFontColor,
                          fontFamily: fontString,
                          fontSize: 17),
                    ),
                    Text(
                      "Deaths",
                      style: TextStyle(
                          color: themeData == ThemeData.dark()
                              ? colorsClass.darkFontColor
                              : colorsClass.lightFontColor,
                          fontFamily: fontString,
                          fontSize: 10),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              backgroundColor: themeData == ThemeData.dark()
                  ? colorsClass.darkScaffoldBackgroundColor
                  : colorsClass.lightScaffoldBackgroundColor,
              elevation: 0.0,
              /*actions: <Widget>[
                isLoading
                    ? Container(
                        width: 0,
                        height: 0,
                      )
                    : Tooltip(
                        message: 'Date',
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            canvasColor: themeData == ThemeData.dark()
                                ? Color.fromARGB(255, 45, 45, 45)
                                : Colors.white,
                          ),
                          child: DropdownButton<String>(
                              style: TextStyle(
                                  color: themeData == ThemeData.dark()
                                      ? Color.fromARGB(255, 45, 45, 45)
                                      : Colors.white),
                              icon: Padding(
                                padding: const EdgeInsets.only(
                                    right: 12.0, top: 4.0),
                                child: FaIcon(FontAwesomeIcons.calendar,
                                    size: 21, color: Colors.deepOrangeAccent),
                              ),
                              iconSize: 24,
                              elevation: 16,
                              underline: Container(
                                  height: 2,
                                  color: themeData == ThemeData.dark()
                                      ? null
                                      : null),
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                  if (value == "All Data") {
                                    request =
                                        "https://api.covid19api.com/total/country/$countrySlug/status/deaths";
                                    kind = "Cases";
                                  } else {
                                    request =
                                        "https://api.covid19api.com/live/country/$countrySlug/status/deaths/date/2020-03-21T13:13:30Z";
                                    kind = "Deaths";
                                  }
                                  getDataAPI();
                                });
                              },
                              items: [
                                DropdownMenuItem<String>(
                                  child: Text(
                                    "All Data",
                                    style: TextStyle(
                                        fontFamily: fontString,
                                        color: _value == "All Data"
                                            ? Colors.deepOrangeAccent
                                            : Colors.black),
                                  ),
                                  value: 'All Data',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text(
                                    "Last Period",
                                    style: TextStyle(
                                        fontFamily: fontString,
                                        color: _value == "Last Period"
                                            ? Colors.deepOrangeAccent
                                            : Colors.black),
                                  ),
                                  value: "Last Period",
                                ),
                              ]),
                        ),
                      ),
                isLoading
                    ? Container(
                        width: 0,
                        height: 0,
                      )
                    : IconButton(
                        tooltip: "Refresh",
                        onPressed: () => getDataAPI(),
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.deepOrangeAccent,
                          size: 27,
                        ),
                      ),
              ],*/
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
      body: Column(
        children: <Widget>[
          isLoading
              ? Container(
                  width: 0.0,
                  height: 0.0,
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 4.0, right: 10.0, bottom: 0.0),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Tool",
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
          isLoading
              ? Container(
                  width: 0.0,
                  height: 0.0,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Container(
                        color: themeData == ThemeData.dark()
                            ? colorsClass.darkContainerBackground
                            : colorsClass.lightContainerBackground,
                        height: 60,
                        width: 60,
                        child: Tooltip(
                          message: 'Date',
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Tooltip(
                              message: 'Sort',
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    canvasColor: themeData == ThemeData.dark()
                                        ? colorsClass
                                            .darkScaffoldBackgroundColor
                                        : colorsClass
                                            .lightScaffoldBackgroundColor),
                                child: DropdownButton<String>(
                                    style: TextStyle(
                                        color: themeData == ThemeData.dark()
                                            ? colorsClass.darkFontColor
                                            : colorsClass.lightFontColor),
                                    icon: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'Images/Icons/Sort.png'))),
                                    ),
                                    iconSize: 24,
                                    elevation: 16,
                                    underline: Container(
                                        height: 2,
                                        color: themeData == ThemeData.dark()
                                            ? null
                                            : null),
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value;
                                        if (value == "All Data") {
                                          request =
                                              "https://api.covid19api.com/total/country/$countrySlug/status/deaths";
                                          kind = "Cases";
                                        } else {
                                          request =
                                              "https://api.covid19api.com/live/country/$countrySlug/status/deaths/date/2020-03-21T13:13:30Z";
                                          kind = "Deaths";
                                        }
                                        getDataAPI();
                                      });
                                    },
                                    items: [
                                      DropdownMenuItem<String>(
                                        child: Text(
                                          "Al",
                                          style: TextStyle(
                                              fontFamily: fontString,
                                              color: _value == "All Data"
                                                  ? colorsClass.lightFontColor
                                                  : Colors.grey),
                                        ),
                                        value: 'All Data',
                                      ),
                                      DropdownMenuItem<String>(
                                        child: Text(
                                          "La",
                                          style: TextStyle(
                                              fontFamily: fontString,
                                              color: _value == "Last Period"
                                                  ? colorsClass.lightFontColor
                                                  : Colors.grey),
                                        ),
                                        value: "Last Period",
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                      child: Container(
                        color: themeData == ThemeData.dark()
                            ? colorsClass.darkContainerBackground
                            : colorsClass.lightContainerBackground,
                        height: 60,
                        width: 60,
                        child: IconButton(
                          onPressed: () => getDataAPI(),
                          icon: Icon(Icons.refresh),
                        ),
                      ),
                    )
                  ],
                ),
          isLoading
              ? Container(
                  width: 0.0,
                  height: 0.0,
                )
              : Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, right: 15.0, left: 8.0, bottom: 8.0),
                  child: Divider(
                      color: themeData == ThemeData.dark()
                          ? colorsClass.darkFontColor
                          : colorsClass.lightFontColor,
                      height: 0.5),
                ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 4.0, right: 10.0, bottom: 0.0),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Chart",
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
                        Container(
                            child: Expanded(
                          child: isLoading
                              ? kit.SpinKitThreeBounce(
                                  size: 20,
                                  color: themeData == ThemeData.dark()
                                      ? colorsClass.darkFontColor
                                      : colorsClass.lightFontColor,
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.0, left: 0.0, right: 0.0),
                                  child: Line(
                                    data: dataLineAPI,
                                    isOnline: true,
                                    titles: ["haha"],
                                    isItem: false,
                                  ),
                                ),
                        )),
                      ],
                    ),
                    isLoading
                        ? Container(
                            child: kit.SpinKitThreeBounce(
                            size: 20,
                            color: themeData == ThemeData.dark()
                                ? colorsClass.darkFontColor
                                : colorsClass.lightFontColor,
                          ))
                        : CoronaVirusTrackerResult(
                            data: deathsData, datesAPI: datesAPI, keyType: 1)
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
