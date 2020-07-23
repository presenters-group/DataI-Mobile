import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../ColorClass.dart';
import 'CoronaVirus.dart';
import 'package:flag/flag.dart';
import 'CoronaVirusConfirmedTracker.dart';
import 'CoronaVirusDeathsTracker.dart';
import 'CoronaVirusRecoveredTracker.dart';

String fontString = "Anton";
double fontSize = 15;
ThemeData themeData;
String themeString = "dark";
bool themeChange = false;
String searchWord;
List<Country> countries = new List();
List<Country> newCountries = new List();
final GlobalKey<ScaffoldState> _drawerHome = new GlobalKey<ScaffoldState>();
ColorClass colorsClass = new ColorClass();

class CoronaSearch extends StatefulWidget {
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

  static void setCountries(List<Country> countriesP) {
    countries = countriesP;
  }

  @override
  _CoronaSearchState createState() => _CoronaSearchState();
}

class _CoronaSearchState extends State<CoronaSearch> {
  TextEditingController searchController = new TextEditingController();


  @override
  void initState() {
    super.initState();
    print(newCountries);
    newCountries = [];
  }

//  @override
//  void dispose() {
//    myInterstitial?.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerHome,
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
                "Search Country",
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
      body: Padding(
        padding: const EdgeInsets.only(left: 0.0, right: 0.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, left: 12.0, right: 12.0, bottom: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: 50.0,
                  color: themeData == ThemeData.dark()
                      ? colorsClass.darkContainerBackground
                      : colorsClass.lightContainerBackground,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 2.0),
                      child: new TextField(
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            newCountries = [];
                            value = value.toLowerCase();
                            value = value.trim();
                            print(value);
                            searchWord = searchController.text;
                            if (searchController.text.length >= 50) {
                              searchController.clear();
                            }
                            for (Country country in countries) {
                              String newName =
                                  country.countriesName.toLowerCase();
                              if (newName.contains(value)) {
                                newCountries.add(country);
                              }
                            }
                          });
                        },
                        style: TextStyle(
                            color: themeData == ThemeData.dark()
                                ? Colors.white
                                : Colors.black,
                            fontFamily: fontString),
                        textAlign: TextAlign.left,
                        controller: searchController,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Padding(
                            padding:
                                const EdgeInsets.only(right: 0.0, top: 15.0),
                            child: InkWell(
                              onTap: () {},
                              child: FaIcon(
                                FontAwesomeIcons.searchLocation,
                                size: 20,
                                color: themeData == ThemeData.dark()
                                    ? Colors.grey
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: fontString,
                          ),
                          hintText: 'Country',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: searchWord == ""
                    ? Center(
                        child: Container(
                          child: Text(
                            "No Result",
                            style: TextStyle(
                                fontFamily: fontString,
                                color: themeData == ThemeData.dark()
                                    ? colorsClass.darkFontColor
                                    : colorsClass.lightFontColor),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: newCountries.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Slidable(
                            closeOnScroll: true,
                            actionPane: SlidableDrawerActionPane(),
                            showAllActionsThreshold: 0.2,
                            actionExtentRatio: 0.20,
                            actions: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                    right: 4.0,
                                    left: 12.0),
                                child: IconSlideAction(
                                    color:themeData == ThemeData.dark()
                                        ? colorsClass.darkContainerBackground
                                        : colorsClass.lightContainerBackground,
                                    icon: FontAwesomeIcons.skull,
                                    onTap: () {
                                      CoronaVirusDeathsTracker.setCountryName(
                                          newCountries[index].countriesName);
                                      CoronaVirusDeathsTracker.setCountrySlug(
                                          newCountries[index].countrySlug);
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new CoronaVirusDeathsTracker()));
                                    },
                                    foregroundColor:
                                        themeData == ThemeData.dark()
                                            ? Colors.red
                                            : Colors.red,
                                    closeOnTap: false,
                                  ),

                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                    right: 4.0,
                                    left: 12.0),
                                child:  IconSlideAction(
                                    color: themeData == ThemeData.dark()
                                        ? colorsClass.darkContainerBackground
                                        : colorsClass.lightContainerBackground,
                                    //FontAwesomeIcons.skull
                                    icon: Icons.track_changes,
                                    onTap: () {
                                      CoronaVirusConfirmedTracker
                                          .setCountryName(newCountries[index]
                                              .countriesName);
                                      CoronaVirusConfirmedTracker
                                          .setCountrySlug(
                                              newCountries[index].countrySlug);

                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new CoronaVirusConfirmedTracker()));
                                    },
                                    foregroundColor:
                                    themeData == ThemeData.dark()
                                        ? colorsClass.darkCasesColor
                                        : colorsClass.lightCasesColor,
                                    closeOnTap: false,
                                  ),

                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                    right: 8.0,
                                    left: 12.0),
                                child: IconSlideAction(
                                    color: themeData == ThemeData.dark()
                                        ? colorsClass.darkContainerBackground
                                        : colorsClass.lightContainerBackground,
                                    icon: FontAwesomeIcons.recycle,
                                    onTap: () {
                                      CoronaVirusRecoveredTracker
                                          .setCountryName(newCountries[index]
                                              .countriesName);
                                      CoronaVirusRecoveredTracker
                                          .setCountrySlug(
                                              newCountries[index].countrySlug);
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new CoronaVirusRecoveredTracker()));
                                    },
                                    foregroundColor:
                                    themeData == ThemeData.dark()
                                        ? colorsClass.darkRecycleColor
                                        : colorsClass.lightRecycleColor,
                                    closeOnTap: false,
                                  ),

                              ),
                            ],
                            child: InkWell(
                              onTap: () {
                                //Slidable.of(context).open(actionType: SlideActionType.primary);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    color: themeData == ThemeData.dark()
                                        ? colorsClass.darkContainerBackground
                                        : colorsClass.lightContainerBackground,
                                    height: fontSize >= 17 ? 150 : 140,
                                    width: MediaQuery.of(context).size.width,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Container(
                                            height: 50,
                                            width: 45,
                                            child: Flags.getMiniFlag(
                                                newCountries[index].countryCode,
                                                50,
                                                null),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4.0,
                                                            bottom: 4.0),
                                                    child: Text(
                                                      newCountries[index]
                                                          .countriesName,
                                                      style: TextStyle(
                                                          color: themeData ==
                                                                  ThemeData
                                                                      .dark()
                                                              ? colorsClass
                                                                  .darkFontColor
                                                              : colorsClass
                                                                  .lightFontColor,
                                                          fontFamily:
                                                              fontString,
                                                          fontSize:
                                                              fontSize + 3),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0,
                                                            left: 4.0),
                                                    child: Text(
                                                      "date : " +
                                                          newCountries[index]
                                                              .dateCountry
                                                              .substring(0, 10),
                                                      style: TextStyle(
                                                          color: themeData ==
                                                                  ThemeData
                                                                      .dark()
                                                              ? colorsClass
                                                                  .darkFontColor
                                                              : colorsClass
                                                                  .lightFontColor,
                                                          fontFamily:
                                                              fontString,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            left: 4.0),
                                                    child: Text(
                                                      "NC : " +
                                                          newCountries[index]
                                                              .newConfirmed
                                                              .toString() +
                                                          " , " +
                                                          "TC : " +
                                                          newCountries[index]
                                                              .totalConfirmed
                                                              .toString(),
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          color: themeData ==
                                                                  ThemeData
                                                                      .dark()
                                                              ? colorsClass
                                                                  .darkFontColor
                                                              : colorsClass
                                                                  .lightFontColor,
                                                          fontFamily:
                                                              fontString,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            left: 4.0),
                                                    child: Text(
                                                      "ND : " +
                                                          newCountries[index]
                                                              .newDeaths
                                                              .toString() +
                                                          " , " +
                                                          "TD : " +
                                                          newCountries[index]
                                                              .totalDeaths
                                                              .toString(),
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          color: themeData ==
                                                                  ThemeData
                                                                      .dark()
                                                              ? colorsClass
                                                                  .darkFontColor
                                                              : colorsClass
                                                                  .lightFontColor,
                                                          fontFamily:
                                                              fontString,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            left: 4.0),
                                                    child: Text(
                                                      "NR : " +
                                                          newCountries[index]
                                                              .activeCases
                                                              .toString() +
                                                          " , " +
                                                          "TR : " +
                                                          newCountries[index]
                                                              .totalRecovered
                                                              .toString(),
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          color: themeData ==
                                                                  ThemeData
                                                                      .dark()
                                                              ? colorsClass
                                                                  .darkFontColor
                                                              : colorsClass
                                                                  .lightFontColor,
                                                          fontFamily:
                                                              fontString,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ]),
                                    )),
                              ),
                            ),
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
