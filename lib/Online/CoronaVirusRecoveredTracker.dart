import 'dart:convert';
import 'package:flutter/material.dart';
import 'CoronaVirusTrackerResult.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as kit;
import 'package:http/http.dart' as http;
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
List<int> recoveredData = new List();
List<List<Series>> dataLineAPI;
List<dynamic> datesAPI = new List();
String _value = "All Data", kind;

class CoronaVirusRecoveredTracker extends StatefulWidget {
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
  _CoronaVirusRecoveredTrackerState createState() =>
      _CoronaVirusRecoveredTrackerState();
}

class _CoronaVirusRecoveredTrackerState
    extends State<CoronaVirusRecoveredTracker>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  getDataAPI() async {
    recoveredData = [];
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
        //Recovered
        if (data == kind) {
          recoveredData.add(val.toInt());
        }
      });
      datesAPI.add(data["Date"]);
    }
    print(recoveredData);
    List<int> days = new List();

    for (var value in datesAPI) {
      days.add(int.parse(value.substring(8, 10)));
    }

    List<Series> dayDeaths = new List();
    for (int i = 0; i < recoveredData.length; i++) {
      dayDeaths.add(Series(
        task: new DateTime(
            int.parse(datesAPI[i].toString().substring(0, 4)),
            int.parse(datesAPI[i].toString().substring(5, 7)),
            int.parse(datesAPI[i].toString().substring(8, 10))),
        taskValue: recoveredData[i],
      ));
    }
    dataLineAPI.add(dayDeaths);
    dayDeaths = [];
  }


  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    request =
    "https://api.covid19api.com/total/country/$countrySlug/status/recovered";
    kind = "Cases";
    _value = "All Data";
    dataAPI = [];
    getDataAPI();
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
                  tooltip: "Back",
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
              title: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      countryName,
                      style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontFamily: fontString,
                          fontSize: 17),
                    ),
                    Text(
                      "Recovered",
                      style: TextStyle(
                          color: Colors.deepOrangeAccent[100],
                          fontFamily: fontString,
                          fontSize: 10),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              backgroundColor: themeData == ThemeData.dark()
                  ? Color.fromARGB(255, 45, 45, 45)
                  : Colors.white,
              elevation: 0.0,
              actions: <Widget>[
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
                              "https://api.covid19api.com/total/country/$countrySlug/status/recovered";
                              kind = "Cases";
                            } else {
                              request =
                              "https://api.covid19api.com/live/country/$countrySlug/status/recovered/date/2020-03-21T13:13:30Z";
                              kind = "Recovered";
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
              ],
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
                    child: isLoading
                        ? kit.SpinKitThreeBounce(
                      size: 20,
                      color: themeData == ThemeData.dark()
                          ? Colors.black
                          : Colors.deepOrangeAccent,
                    )
                        : Padding(
                      padding: const EdgeInsets.only(
                          top: 50.0, left: 0.0, right: 0.0),
                      child: Line(
                        data: dataLineAPI,
                        isOnline: true,
                        titles: ["haha"],
                        isItem: false,
                      ),
                    )),
                isLoading
                    ? Container(
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
                    child: kit.SpinKitThreeBounce(
                      size: 20,
                      color: themeData == ThemeData.dark()
                          ? Colors.black
                          : Colors.deepOrangeAccent,
                    ))
                    : CoronaVirusTrackerResult(
                    data: recoveredData, datesAPI: datesAPI, keyType: 3)
              ],
            )),
      ),
    );
  }
}
