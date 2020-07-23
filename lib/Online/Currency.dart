import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart' as kit;
import 'package:flutter/material.dart';
import '../ColorClass.dart';
import 'CurrencyTracker.dart';
import 'CurrencyTrackerResult.dart';
import 'Line.dart';
import 'Series.dart';
import 'package:http/http.dart' as http;

String fontString = "Anton";
double fontSize = 15;
ThemeData themeData;
String themeString = "dark";
bool themeChange = false;
String _value = "USD";
const request = "https://api.exchangeratesapi.io/latest";
List<String> dropDownItems = new List();
Map<String, dynamic> mapAPI = Map();
bool isLoading = false;
List<dynamic> dataAPI = new List();
String dateAPI, baseAPI;
List<CurrencyList> currencies = new List();
List<List<List<Series>>> currenciesSeries = new List();
List<Series> dataLinePerDay;
List<List<Series>> dataLineAPI;
bool isLoadingChart = false;
List<dynamic> mapForWeek;
List<List<dynamic>> valuesOfCurrenciesForWeek = new List();
List<String> dates = new List();
List<String> notEmptyDates = new List();
ColorClass colorsClass = new ColorClass();

class Currency extends StatefulWidget {
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

  @override
  _CurrencyState createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  getAPIData(String request) async {
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
    mapAPI = json.decode(response.body)["rates"];
    print(mapAPI);
    dateAPI = json.decode(response.body)["date"];
    baseAPI = json.decode(response.body)["base"];
    dropDownItems = loadDropDownData(response);

    dataAPI = loadDataFromAPI();
    loadChartForSingleCurrency();

    return json.decode(response.body);
  }

  List<dynamic> loadDataFromAPI() {
    List<dynamic> innerAPIData = new List();
    mapAPI.forEach(
      (data, val) {
        innerAPIData.add(val.toString());
      },
    );
    return innerAPIData;
  }

  List<String> loadDropDownData(http.Response res) {
    List<String> innerDropData = new List();
    mapAPI.forEach(
      (data, val) {
        innerDropData.add(data);
      },
    );
    //if (!innerDropData.contains("EUR")) innerDropData.add('EUR');
    return innerDropData;
  }

  loadChartForSingleCurrency() async {
    mapForWeek = [];
    dates = [];
    valuesOfCurrenciesForWeek = [];
    List<List<Series>> innerDataLineAPI = new List();
    List<dynamic> requests = new List();

    DateTime date = DateTime.now();
    //inverse "for" for draw data in true form
    for (int i = 30; i >= 0; i--) {
      var lastDay = date
          .subtract(
              Duration(days: date.weekday + (i - (date.day - date.weekday))))
          .toIso8601String();
      dates.add(lastDay.substring(0, 10));
    }

    print("...00");
    print(dates);
    for (int i = 0; i <= 30; i++) {
      requests.add(
          "https://api.exchangeratesapi.io/history?start_at=${dates[i].trim()}&end_at=${dates[i].trim()}&base=$_value");
    }
    setState(() {
      isLoadingChart = true;
    });
    for (int i = 0; i <= 30; i++) {
      mapForWeek.add(await http.get(Uri.encodeFull(requests[i]),
          headers: {"Accept": "Application/json"}));
    }

    if (mapForWeek[0].statusCode == 200) {
      setState(() {
        isLoadingChart = false;
      });
    } else {
      throw Exception('Failed Loading .... !!!! ');
    }

    List<CurrencyList> currencyForOneDay;
    List<List<CurrencyList>> currenciesWeek;
    currencyForOneDay = [];
    currenciesWeek = [];
    notEmptyDates = [];
    for (int i = 0; i < mapForWeek.length; i++) {
      Map<String, dynamic> mapAPIForIndex =
          json.decode(mapForWeek[i].body)["rates"][dates[i]];
      print(mapAPIForIndex);
      if (mapAPIForIndex == null) {
        print("Empty");
      } else {
        notEmptyDates.add(dates[i]);
        mapAPIForIndex.forEach((data, val) {
          currencyForOneDay.add(new CurrencyList(name: data, value: val));
        });
        currenciesWeek.add(currencyForOneDay);
        currencyForOneDay = [];
      }
    }
    print(dates.length);
    print(notEmptyDates);
    List<dynamic> currencyForDay = new List();
    for (int j = 0; j <= dropDownItems.length; j++) {
      for (int i = 0; i < currenciesWeek.length; i++) {
        currencyForDay.add(currenciesWeek[i][j].value);
      }
      valuesOfCurrenciesForWeek.add(currencyForDay);
      currencyForDay = [];
    }
    print("nanan");
    print(valuesOfCurrenciesForWeek.length);

    dataLinePerDay = [];
    dataLineAPI = [];
    currenciesSeries = [];
    ColorClass colorsClass = new ColorClass();
    List<Color> colors = colorsClass.generateColors();
    for (int j = 0; j <= dropDownItems.length; j++) {
      for (int i = 0; i < currenciesWeek.length; i++) {
        dataLinePerDay.add(Series(
            task: new DateTime(
                int.parse(dates[i].toString().substring(0, 4)),
                int.parse(dates[i].toString().substring(5, 7)),
                int.parse(dates[i].toString().substring(8, 10))),
            taskValue: currenciesWeek[i][j].value,
            taskColor: colors[i]));
      }
      dataLineAPI.add(dataLinePerDay);
      currenciesSeries.add(dataLineAPI);
      dataLinePerDay = [];
      dataLineAPI = [];
    }

    return innerDataLineAPI;
  }
  @override
  void initState() {
    super.initState();
    dropDownItems = [];
    dataAPI = [];
    getAPIData(request);
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
                "Currency",
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
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, right: 10.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: themeData == ThemeData.dark()
                          ? colorsClass.darkContainerBackground
                          : colorsClass.lightContainerBackground,
                    ),
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
                                  image: AssetImage('Images/Icons/Sort.png'))),
                        ),
                        iconSize: 24,
                        elevation: 16,
                        underline: Container(
                            height: 2,
                            color: themeData == ThemeData.dark() ? null : null),
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                            String dropRequest =
                                "https://api.exchangeratesapi.io/latest?base=" +
                                    _value;
                            getAPIData(dropRequest);
                          });
                        },
                        items: List.generate(dropDownItems.length, (index) {
                          return DropdownMenuItem<String>(
                            child: Text(
                              dropDownItems[index],
                              style: TextStyle(
                                  fontFamily: fontString,
                                  color: _value == dropDownItems[index]
                                      ? Colors.deepOrangeAccent
                                      : Colors.black),
                            ),
                            value: dropDownItems[index],
                          );
                        })),
                  ),
                )
              ],
            ),
          ),
          preferredSize: Size.fromHeight(65.0)),
      body: Container(
        child: Column(
          children: <Widget>[
            isLoading
                ? Container(
                    width: 0.0,
                    height: 0.0,
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 4.0, right: 10.0, bottom: 15.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Currencies comparing with '$baseAPI'",
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
            Expanded(
              child: isLoading
                  ? kit.SpinKitThreeBounce(
                      size: 20,
                      color: themeData == ThemeData.dark()
                          ? colorsClass.darkFontColor
                          : colorsClass.lightFontColor,
                    )
                  : ListView.builder(
                      itemCount: dataAPI.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            CurrencyTracker.setChartsData(
                                currenciesSeries[index]);
                            CurrencyTracker.setCurrencyName(
                                dropDownItems[index]);
                            CurrencyTracker.setBaseName(baseAPI);
                            CurrencyTrackerResult.setDates(notEmptyDates);
                            CurrencyTrackerResult.setValuesCurrencyForWeek(
                                valuesOfCurrenciesForWeek[index]);
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        new CurrencyTracker()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 12.0,
                                right: 15.0,
                                left: 15.0),
                            child: Container(
                                color: themeData == ThemeData.dark()
                                    ? colorsClass.darkContainerBackground
                                    : colorsClass.lightContainerBackground,
                                height: fontSize >= 17 ? 140 : 130,
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0,
                                          right: 8.0,
                                          left: 8.0,
                                          bottom: 8.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0, bottom: 15.0),
                                                child: Text(
                                                  dropDownItems[index],
                                                  style: TextStyle(
                                                      color: themeData ==
                                                              ThemeData.dark()
                                                          ? colorsClass
                                                              .darkFontColor
                                                          : colorsClass
                                                              .lightFontColor,
                                                      fontFamily: fontString,
                                                      fontSize: fontSize + 2),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0, left: 4.0),
                                                child: Text(
                                                  "Value Now : " +
                                                      dataAPI[index],
                                                  style: TextStyle(
                                                      color: themeData ==
                                                              ThemeData.dark()
                                                          ? colorsClass
                                                              .darkFontColor
                                                          : colorsClass
                                                              .lightFontColor,
                                                      fontFamily: fontString,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0, left: 4.0),
                                                child: Text(
                                                  "date : " + dateAPI,
                                                  style: TextStyle(
                                                      color: themeData ==
                                                              ThemeData.dark()
                                                          ? colorsClass
                                                              .darkFontColor
                                                          : colorsClass
                                                              .lightFontColor,
                                                      fontFamily: fontString,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                    isLoadingChart
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0,
                                                left: 75.0,
                                                right: 12.0,
                                                bottom: 12.0),
                                            child: kit.SpinKitThreeBounce(
                                                size: 15,
                                                color: themeData ==
                                                        ThemeData.dark()
                                                    ? colorsClass.darkFontColor
                                                    : colorsClass
                                                        .lightFontColor))
                                        : Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Container(
                                              height: 150,
                                              width: 150,
                                              child: Line(
                                                data: currenciesSeries[index],
                                                titles: [],
                                                isOnline: true,
                                                isItem: true,
                                              ),
                                            ),
                                          ),
                                  ]),
                                )),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrencyList {
  final name;
  final value;

  CurrencyList({this.name, this.value});
}
