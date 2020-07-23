import 'dart:convert';

import 'package:eyedatai/Opens/Dashboards.dart';
import 'package:eyedatai/Opens/DataSources.dart';
import 'package:eyedatai/Opens/Filters.dart';
import 'package:eyedatai/Opens/OpenFile.dart';
import 'package:eyedatai/Opens/Visualizers.dart';
import 'package:flutter/material.dart';
import 'ColorClass.dart';
import 'FontClass.dart';
import 'package:eyedatai/Classes/DataModel.dart';

import 'Online/CoronaVirus.dart';
import 'Online/Currency.dart';

String filePath;
DataModel table;

class DataI extends StatefulWidget {
  static void setFilePath(String filePathP) {
    filePath = filePathP;
  }

  @override
  _DataIState createState() => _DataIState();
}

class _DataIState extends State<DataI> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isSelectedFile = false;
  var jsonResult;
  String data = "";
  bool isActiveBottomSheet = false;

  Widget oldThingsDrawer() {
    return SizedBox(
      width: 225,
      child: Drawer(
        child: Container(
          color: ColorClass.containerColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: ListView(
              //shrinkWrap: true, // For Center Widget
              children: <Widget>[
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Currency()));
                  },
                  title: Text(
                    "Currencies",
                    style: TextStyle(
                        fontFamily: FontClass.appFont,
                        fontSize: 15.0,
                        color: ColorClass.fontColor),
                  ),
                  trailing: Icon(
                    Icons.monetization_on,
                    color: ColorClass.fontColor
                  ),
                ),
                ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new CoronaVirus()));
                    },
                    title: Text(
                      "Corona Virus",
                      style: TextStyle(
                          fontFamily: FontClass.appFont,
                          fontSize: 15.0,
                          color:ColorClass.fontColor),
                    ),
                    trailing: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('Images/Virus.png'))),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBottomSheet({data}) {
    setState(() {
      isActiveBottomSheet = true;
    });
    _scaffoldKey.currentState
        .showBottomSheet(
          (context) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    isActiveBottomSheet = false;
                  });
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: ColorClass.fontColor,
                ),
              ),
              backgroundColor: ColorClass.scaffoldBackgroundColor,
              elevation: 0.0,
            ),
            backgroundColor: ColorClass.scaffoldBackgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Press On  ' ",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: FontClass.appFont,
                                fontSize: 15),
                          ),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('Images/Logo.png'))),
                          ),
                          Text(
                            " '  To Show Data Again :)",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: FontClass.appFont,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    data,
                    style: TextStyle(
                        color: ColorClass.fontColor,
                        fontFamily: FontClass.appFont,
                        fontSize: 17),
                  )
                ],
              ),
            ),
          ),
          backgroundColor: ColorClass.scaffoldBackgroundColor,
        )
        .closed
        .then((val) {
      setState(() {
        isActiveBottomSheet = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              "DataI",
              style: TextStyle(
                  color: ColorClass.fontColor,
                  fontFamily: FontClass.appFont,
                  fontSize: 17),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 20),
            child: IconButton(
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
              icon: Icon(
                Icons.list,
                color: ColorClass.fontColor,
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 20),
              child: IconButton(
                onPressed: () {
                  if (data.isEmpty) {
                    var snackBar = new SnackBar(
                      content: Text("Please Open File"),
                      duration: Duration(seconds: 1),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                    if (isActiveBottomSheet) {
                      setState(() {
                        isActiveBottomSheet = false;
                      });
                      Navigator.pop(context);
                    } else {
                      showBottomSheet(data: data);
                    }
                  }
                },
                icon: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('Images/Logo.png'))),
                ),
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: ColorClass.scaffoldBackgroundColor,
          elevation: 0.0,
        ),
      ),
      backgroundColor: ColorClass.scaffoldBackgroundColor,
      drawer: oldThingsDrawer(),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 25.0, bottom: 8.0, top: 8.0),
                        child: InkWell(
                          onTap: () {
                            var snackBar = new SnackBar(
                              content: Text("Please Open File"),
                              duration: Duration(seconds: 1),
                            );
                            if (isSelectedFile) {
                              print(table.dashboards.length);
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new Dashboards(
                                          dashboards: table.dashboards)));
                            } else {
                              _scaffoldKey.currentState.showSnackBar(snackBar);
                            }
                          },
                          child: new Container(
                            height: 128.00,
                            width: 131.00,
                            color: ColorClass.containerColor,
                            child: Center(
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'Images/Dashboards.png'))),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(new MaterialPageRoute(builder: (_) {
                              return new OpenFile();
                            })).then((val) async {
                              setState(() {
                                isSelectedFile = true;
                              });
                              data = await DefaultAssetBundle.of(context)
                                  .loadString("files/test.json");
                              jsonResult = json.decode(data);
                              setState(() {
                                table = DataModel.fromJSON(jsonResult);
                              });
                              print(table.dataSources[0].columnsList[0].cells[1]
                                  .value);
                              print(table.dashboards.length);
                              print("**************");
                              print(jsonResult);
                              showBottomSheet(data: data);
                            });
                          },
                          child: new Container(
                            height: 128.00,
                            width: 131.00,
                            color: ColorClass.containerColor,
                            child: Center(
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('Images/Files.png'))),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 25.0, bottom: 8.0, top: 8.0),
                        child: InkWell(
                          onTap: () {
                            var snackBar = new SnackBar(
                              content: Text("Please Open File"),
                              duration: Duration(seconds: 1),
                            );
                            if (isSelectedFile) {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new DataSources(
                                            dataSources: table.dataSources,
                                          )));
                            } else {
                              _scaffoldKey.currentState.showSnackBar(snackBar);
                            }
                          },
                          child: new Container(
                            height: 128.00,
                            width: 131.00,
                            color: ColorClass.containerColor,
                            child: Center(
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('Images/DataBase.png'))),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            var snackBar = new SnackBar(
                              content: Text("Please Open File"),
                              duration: Duration(seconds: 1),
                            );
                            if (isSelectedFile) {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new Visualizers(
                                            visualizers: table.visualizers,
                                          )));
                            } else {
                              _scaffoldKey.currentState.showSnackBar(snackBar);
                            }
                          },
                          child: new Container(
                            height: 128.00,
                            width: 131.00,
                            color: ColorClass.containerColor,
                            child: Center(
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'Images/Visualizers.png'))),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            var snackBar = new SnackBar(
                              content: Text("Please Open File"),
                              duration: Duration(seconds: 1),
                            );
                            if (isSelectedFile) {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new Filters(
                                            filters: table.filters,
                                          )));
                            } else {
                              _scaffoldKey.currentState.showSnackBar(snackBar);
                            }
                          },
                          child: new Container(
                            height: 128.00,
                            width: 131.00,
                            color: ColorClass.containerColor,
                            child: Center(
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('Images/Filter.png'))),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
