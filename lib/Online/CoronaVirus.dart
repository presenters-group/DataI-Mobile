import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart' as kit;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flag/flag.dart';
import '../ColorClass.dart';
import 'CoronaSearch.dart';
import 'CoronaVirusConfirmedTracker.dart';
import 'CoronaVirusDeathsTracker.dart';
import 'CoronaVirusRecoveredTracker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'GlobalCoranaVirus.dart';
import 'GlobalCoronaResult.dart';

final GlobalKey<ScaffoldState> _drawerHome = new GlobalKey<ScaffoldState>();
String fontString = "Anton";
double fontSize = 15;
ThemeData themeData;
String themeString = "dark";
bool themeChange = false;
const request = "https://api.covid19api.com/summary";
bool isLoading = false;
Map<String, dynamic> globalMapAPI = new Map();
List<dynamic> countriesMapAPI = new List();
List<Country> countries = new List();
String _value = "TC";
List<dynamic> newCountriesMapAPI = new List();
List<Country> newCountries = new List();
ColorClass colorsClass = new ColorClass();

class CoronaVirus extends StatefulWidget {
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
  _CoronaVirusState createState() => _CoronaVirusState();
}

class _CoronaVirusState extends State<CoronaVirus> {


  String checkCountrySlug(String slug) {
    if (slug == "Antigua and Barbuda") {
      return "antigua-and-barbuda";
    }
    if (slug == "British Virgin Islands") {
      return "british-virgin-islands";
    }
    if (slug == "Caribbean Netherlands") {
      return slug.toLowerCase();
    }
    if (slug == "Burkina Faso") {
      return "burkina-faso";
    }
    if (slug == "Cayman Islands") {
      return "cayman-islands";
    }
    if (slug == "Central African Republic") {
      return "central-african-republic";
    }
    if (slug == "Channel Islands") {
      return slug.toLowerCase();
    }
    if (slug == "Costa Rica") {
      return "costa-rica";
    }
    if (slug == "Côte d'Ivoire") {
      return "cote-divoire";
    }
    if (slug == "Diamond Princess") {
      return slug.toLowerCase();
    }
    if (slug == "Dominican Republic") {
      return "dominican-republic";
    }
    if (slug == "Equatorial Guinea") {
      return "equatorial-guinea";
    }
    if (slug == "Falkland Islands (Malvinas)") {
      return "falkland-islands-malvinas";
    }
    if (slug == "Faroe Islands") {
      return "faroe-islands";
    }
    if (slug == "French Guiana") {
      return "french-guiana";
    }
    if (slug == "French Polynesia") {
      return "french-polynesia";
    }
    if (slug == "Holy See (Vatican City State)") {
      return "holy-see-vatican-city-state";
    }
    if (slug == "Hong Kong") {
      return "hong-kong-sar-china";
    }
    if (slug == "Isle of Man") {
      return "isle-of-man";
    }
    if (slug == "Lao People's Democratic Republic") {
      return "lao-pdr";
    }
    if (slug == "Libyan Arab Jamahiriya") {
      return "libya";
    }
    if (slug == "MS Zaandam") {
      return slug.toLowerCase();
    }
    if (slug == "New Caledonia") {
      return "new-caledonia";
    }
    if (slug == "New Zealand") {
      return "new-zealand";
    }
    if (slug == "Papua New Guinea") {
      return "papua-new-guinea";
    }
    if (slug == "S. Korea") {
      return "korea-south";
    }
    if (slug == "Saint Kitts and Nevis") {
      return "saint-kitts-and-nevis";
    }
    if (slug == "Saint Lucia") {
      return "saint-lucia";
    }
    if (slug == "Saint Martin") {
      return "saint-martin-french-part";
    }
    if (slug == "Saint Pierre Miquelon") {
      return "saint-pierre-and-miquelon";
    }
    if (slug == "Saint Vincent and the Grenadines") {
      return "saint-vincent-and-the-grenadines";
    }
    if (slug == "San Marino") {
      return "san-marino";
    }
    if (slug == "Sao Tome and Principe") {
      return "sao-tome-and-principe";
    }
    if (slug == "Saudi Arabia") {
      return "saudi-arabia";
    }
    if (slug == "Sierra Leone") {
      return "sierra-leone";
    }
    if (slug == "Sint Maarten") {
      return slug.toLowerCase();
    }
    if (slug == "South Africa") {
      return "south-africa";
    }
    if (slug == "South Sudan") {
      return "south-sudan";
    }
    if (slug == "Sri Lanka") {
      return "sri-lanka";
    }
    if (slug == "St. Barth") {
      return slug.toLowerCase();
    }
    if (slug == "Syrian Arab Republic") {
      return "syria";
    }
    if (slug == "Timor-Leste") {
      return "timor-leste";
    }
    if (slug == "Trinidad and Tobago") {
      return "trinidad-and-tobago";
    }
    if (slug == "Turks and Caicos Islands") {
      return "turks-and-caicos-islands";
    }
    if (slug == "USA") {
      return "united-states";
    }
    if (slug == "UAE") {
      return "united-arab-emirates";
    }
    if (slug == "UK") {
      return "united-kingdom";
    }
    if (slug == "Western Sahara") {
      return "western-sahara";
    } else
      return slug.toLowerCase();
  }

  getAPIData() async {
    countries = [];
    newCountries = [];
    setState(() {
      isLoading = true;
    });
    http.Response response = await http
        .get(Uri.encodeFull(request), headers: {"Accept": "Application/json"});

    http.Response newResponse = await http.get(
        Uri.encodeFull("https://corona.lmao.ninja/v2/countries"),
        headers: {"Accept": "Application/json"});

    http.Response responseWorldWide = await http.get(
        Uri.encodeFull("https://corona.lmao.ninja/v2/all"),
        headers: {"Accept": "Application/json"});

    if (response.statusCode == 200 && responseWorldWide.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed Loading .... !!!! ');
    }
    globalMapAPI = json.decode(responseWorldWide.body);
    GlobalCoronaResult.setGlobalData(globalMapAPI);
    GlobalCoronaVirus.setGlobalData(globalMapAPI);

    countriesMapAPI = json.decode(response.body)["Countries"];
    newCountriesMapAPI = json.decode(newResponse.body);
    for (var newCountry in newCountriesMapAPI) {
      newCountries.add(new Country(
        countriesName: newCountry["country"],
        countryCode: newCountry["countryInfo"]["iso2"],
        newConfirmed: newCountry["todayCases"],
        totalConfirmed: newCountry["cases"],
        newDeaths: newCountry["todayDeaths"],
        totalDeaths: newCountry["deaths"],
        totalRecovered: newCountry["recovered"],
        dateCountry: DateTime.now().toIso8601String().substring(0, 10),
        activeCases: newCountry["active"],
        countrySlug: checkCountrySlug(newCountry["country"]),
      ));
      print(newCountry["country"]);
    }
    print(newCountries.length);
    for (var country in countriesMapAPI) {
      countries.add(new Country(
          countriesName: country["Country"],
          countryCode: country["CountryCode"],
          countrySlug: country["Slug"],
          newConfirmed: country["NewConfirmed"],
          totalConfirmed: country["TotalConfirmed"],
          newDeaths: country["NewDeaths"],
          totalDeaths: country["TotalDeaths"],
          activeCases: country["NewRecovered"],
          totalRecovered: country["TotalRecovered"],
          dateCountry: country["Date"]));
    }

    if (_value == "TC") {
      newCountries.sort((a, b) => b.totalConfirmed.compareTo(a.totalConfirmed));
    }
    if (_value == "TR") {
      newCountries.sort((a, b) => b.totalRecovered.compareTo(a.totalRecovered));
    }
    if (_value == "TD") {
      newCountries.sort((a, b) => b.totalDeaths.compareTo(a.totalDeaths));
    }
    if (_value == "NC") {
      newCountries.sort((a, b) => b.newConfirmed.compareTo(a.newConfirmed));
    }
    if (_value == "A") {
      newCountries.sort((a, b) => b.activeCases.compareTo(a.activeCases));
    }
    if (_value == "ND") {
      newCountries.sort((a, b) => b.newDeaths.compareTo(a.newDeaths));
    }
    if (_value == "Alp") {}
    print("countries length");
    print(newCountries.length);
    return json.decode(response.body);
  }


  @override
  void initState() {
    super.initState();
//    FirebaseAdMob.instance.initialize(appId: appId);
//    myBanner = buildBanner()
//      ..load();
    getAPIData();
  }

  @override
  void dispose() {
    //myBanner?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    myBanner
//      ..load()
//      ..show();
    return Scaffold(
      key: _drawerHome,
      backgroundColor: themeData == ThemeData.dark()
          ? colorsClass.darkScaffoldBackgroundColor
          : colorsClass.lightScaffoldBackgroundColor,
      appBar: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: AppBar(
              leading: isLoading
                  ? Container(
                      width: 0.0,
                      height: 0.0,
                    )
                  : IconButton(
                      tooltip: "Refresh",
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: themeData == ThemeData.dark()
                            ? colorsClass.darkFontColor
                            : colorsClass.lightFontColor,
                        size: 16,
                      ),
                    ),
              title: Text(
                "Corona Virus",
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
                  padding: const EdgeInsets.only(right: 15.0),
                  child: isLoading
                      ? Container(
                          width: 0.0,
                          height: 0.0,
                        )
                      : InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => GlobalCoronaVirus()));
                          },
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('Images/Icons/Earth.png'))),
                          ),
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
                        top: 20.0, left: 0.0, right: 10.0, bottom: 15.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Tools",
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
            isLoading
                ? Container(
                    width: 0.0,
                    height: 0.0,
                  )
                : SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            _drawerHome.currentState
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  backgroundColor: themeData == ThemeData.dark()
                                      ? Color.fromARGB(255, 45, 45, 45)
                                      : Colors.white,
                                  duration: new Duration(seconds: 5),
                                  content: Text(
                                    "- Swipe Item to Right to Show Info \n  Shortcuts : \n- NC : New Cases , TC : Total Cases \n- ND : New Deaths , TD : Total Deaths \n- TR : Total Recovered , A : Active Cases\n- Alp : Sort countries in alphabetical order \n- The Sort is from Larger to Smaller",
                                    style: TextStyle(
                                        fontFamily: fontString,
                                        fontSize: 15.0,
                                        color: themeData == ThemeData.dark()
                                            ? colorsClass.darkFontColor
                                            : colorsClass.lightFontColor),
                                  ),
                                ),
                              );
                          },
                          child: Container(
                            width: 55,
                            height: 55,
                            color: themeData == ThemeData.dark()
                                ? colorsClass.darkContainerBackground
                                : colorsClass.lightContainerBackground,
                            child: Icon(
                              Icons.help,
                              color: themeData == ThemeData.dark()
                                  ? colorsClass.darkFontColor
                                  : colorsClass.darkFontColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: InkWell(
                            onTap: () => getAPIData(),
                            child: Container(
                              width: 55,
                              height: 55,
                              color: themeData == ThemeData.dark()
                                  ? colorsClass.darkContainerBackground
                                  : colorsClass.lightContainerBackground,
                              child: Icon(
                                Icons.refresh,
                                color: themeData == ThemeData.dark()
                                    ? colorsClass.darkFontColor
                                    : colorsClass.darkFontColor,
                              ),
                            ),
                          ),
                        ),
                        //equalizer
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Container(
                            width: 65,
                            height: 55,
                            color: themeData == ThemeData.dark()
                                ? colorsClass.darkContainerBackground
                                : colorsClass.lightContainerBackground,
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
                                          getAPIData();
                                        });
                                      },
                                      items: [
                                        DropdownMenuItem<String>(
                                          child: Text(
                                            "TC",
                                            style: TextStyle(
                                                fontFamily: fontString,
                                                color: _value == "TC"
                                                    ? colorsClass.lightFontColor
                                                    : Colors.grey),
                                          ),
                                          value: 'TC',
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text(
                                            "TR",
                                            style: TextStyle(
                                                fontFamily: fontString,
                                                color: _value == "TR"
                                                    ? colorsClass.lightFontColor
                                                    : Colors.grey),
                                          ),
                                          value: "TR",
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text(
                                            "TD",
                                            style: TextStyle(
                                                fontFamily: fontString,
                                                color: _value == "TD"
                                                    ? colorsClass.lightFontColor
                                                    : Colors.grey),
                                          ),
                                          value: "TD",
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text(
                                            "NC",
                                            style: TextStyle(
                                                fontFamily: fontString,
                                                color: _value == "NC"
                                                    ? colorsClass.lightFontColor
                                                    : Colors.grey),
                                          ),
                                          value: "NC",
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text(
                                            "ND",
                                            style: TextStyle(
                                                fontFamily: fontString,
                                                color: _value == "ND"
                                                    ? colorsClass.lightFontColor
                                                    : Colors.grey),
                                          ),
                                          value: "ND",
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text(
                                            "A",
                                            style: TextStyle(
                                                fontFamily: fontString,
                                                color: _value == "A"
                                                    ? colorsClass.lightFontColor
                                                    : Colors.grey),
                                          ),
                                          value: "A",
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text(
                                            "Alp",
                                            style: TextStyle(
                                                fontFamily: fontString,
                                                color: _value == "Alp"
                                                    ? colorsClass.lightFontColor
                                                    : Colors.grey),
                                          ),
                                          value: "Alp",
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: InkWell(
                            onTap: () {
                              CoronaSearch.setCountries(newCountries);
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => CoronaSearch()));
                            },
                            child: Container(
                              width: 55,
                              height: 55,
                              color: themeData == ThemeData.dark()
                                  ? colorsClass.darkContainerBackground
                                  : colorsClass.lightContainerBackground,
                              child: Icon(
                                Icons.search,
                                color: themeData == ThemeData.dark()
                                    ? colorsClass.darkFontColor
                                    : colorsClass.darkFontColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
            isLoading
                ? Container(
                    width: 0.0,
                    height: 0.0,
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, right: 15.0, left: 8.0, bottom: 8.0),
                    child: Divider(
                        color: themeData == ThemeData.dark()
                            ? colorsClass.darkFontColor
                            : colorsClass.lightFontColor,
                        height: 0.5),
                  ),
            isLoading
                ? Container(
                    width: 0.0,
                    height: 0.0,
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, left: 12.0, right: 10.0),
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
                              "Countries",
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
            Expanded(
              child: isLoading
                  ? kit.SpinKitThreeBounce(
                      size: 20,
                      color: themeData == ThemeData.dark()
                          ? colorsClass.darkFontColor
                          : colorsClass.lightFontColor,
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
                            Tooltip(
                              message: 'Deaths',
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                    right: 4.0,
                                    left: 12.0),
                                child: IconSlideAction(
                                  color: themeData == ThemeData.dark()
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
                                  foregroundColor: themeData == ThemeData.dark()
                                      ? Colors.red
                                      : Colors.red,
                                  closeOnTap: false,
                                ),
                              ),
                            ),
                            Tooltip(
                              message: 'Cases',
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8.0,
                                    right: 4.0,
                                    left: 12.0),
                                child: IconSlideAction(
                                  color: themeData == ThemeData.dark()
                                      ? colorsClass.darkContainerBackground
                                      : colorsClass.lightContainerBackground,
                                  //FontAwesomeIcons.skull
                                  icon: Icons.track_changes,
                                  onTap: () {
                                    CoronaVirusConfirmedTracker.setCountryName(
                                        newCountries[index].countriesName);
                                    CoronaVirusConfirmedTracker.setCountrySlug(
                                        newCountries[index].countrySlug);

                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new CoronaVirusConfirmedTracker()));
                                  },
                                  foregroundColor: themeData == ThemeData.dark()
                                      ? colorsClass.darkCasesColor
                                      : colorsClass.lightCasesColor,
                                  closeOnTap: false,
                                ),
                              ),
                            ),
                            Tooltip(
                              message: 'Recovered',
                              child: Padding(
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
                                    CoronaVirusRecoveredTracker.setCountryName(
                                        newCountries[index].countriesName);
                                    CoronaVirusRecoveredTracker.setCountrySlug(
                                        newCountries[index].countrySlug);
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) =>
                                                new CoronaVirusRecoveredTracker()));
                                  },
                                  foregroundColor: themeData == ThemeData.dark()
                                      ? colorsClass.darkRecycleColor
                                      : colorsClass.lightRecycleColor,
                                  closeOnTap: false,
                                ),
                              ),
                            ),
                          ],
                          child: InkWell(
                            onTap: () {
                              //Slidable.of(context).open(actionType: SlideActionType.primary);
                              _drawerHome.currentState
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    duration: new Duration(seconds: 5),
                                    content: Text(
                                      "Swipe Item To Right",
                                      style: TextStyle(
                                          fontFamily: fontString,
                                          fontSize: 15.0,
                                          color: Colors.deepOrangeAccent),
                                    ),
                                  ),
                                );
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
                                              newCountries[index].countryCode ==
                                                      null
                                                  ? ''
                                                  : newCountries[index]
                                                      .countryCode,
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
                                                                ThemeData.dark()
                                                            ? colorsClass
                                                                .darkFontColor
                                                            : colorsClass
                                                                .lightFontColor,
                                                        fontFamily: fontString,
                                                        fontSize: fontSize + 3),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4.0, left: 4.0),
                                                  child: Text(
                                                    "date : " +
                                                        newCountries[index]
                                                            .dateCountry
                                                            .substring(0, 10),
                                                    style: TextStyle(
                                                        color: themeData ==
                                                                ThemeData.dark()
                                                            ? colorsClass
                                                                .darkFontColor
                                                            : colorsClass
                                                                .lightFontColor,
                                                        fontFamily: fontString,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, left: 4.0),
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
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: themeData ==
                                                                ThemeData.dark()
                                                            ? colorsClass
                                                                .darkFontColor
                                                            : colorsClass
                                                                .lightFontColor,
                                                        fontFamily: fontString,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, left: 4.0),
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
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: themeData ==
                                                                ThemeData.dark()
                                                            ? colorsClass
                                                                .darkFontColor
                                                            : colorsClass
                                                                .lightFontColor,
                                                        fontFamily: fontString,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0, left: 4.0),
                                                  child: Text(
                                                    "TR : " +
                                                        newCountries[index]
                                                            .totalRecovered
                                                            .toString() +
                                                        " , " +
                                                        "A : " +
                                                        newCountries[index]
                                                            .activeCases
                                                            .toString(),
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: themeData ==
                                                                ThemeData.dark()
                                                            ? colorsClass
                                                                .darkFontColor
                                                            : colorsClass
                                                                .lightFontColor,
                                                        fontFamily: fontString,
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
    );
  }
}

class Country {
  String countriesName;
  String countryCode;
  String countrySlug;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int activeCases;
  int totalRecovered;
  String dateCountry;

  Country(
      {this.countriesName,
      this.countryCode,
      this.countrySlug,
      this.newConfirmed,
      this.totalConfirmed,
      this.newDeaths,
      this.totalDeaths,
      this.activeCases,
      this.totalRecovered,
      this.dateCountry});
}
