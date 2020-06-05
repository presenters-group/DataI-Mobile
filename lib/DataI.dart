import 'package:eyedatai/Opens/Dashboards.dart';
import 'package:eyedatai/Opens/DataSources.dart';
import 'package:eyedatai/Opens/Filters.dart';
import 'package:eyedatai/Opens/OpenFile.dart';
import 'package:eyedatai/Opens/Visualizers.dart';
import 'package:flutter/material.dart';
import 'ColorClass.dart';
import 'FontClass.dart';

class DataI extends StatefulWidget {
  @override
  _DataIState createState() => _DataIState();
}

class _DataIState extends State<DataI> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget oldThingsDrawer() {
    return Container(
      color: ColorClass.scaffoldBackgroundColor,
      child: SizedBox(
        width: 220,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration:
                    BoxDecoration(color: ColorClass.scaffoldBackgroundColor),
                child: Center(
                  child: Text(
                    "Project 1",
                    style: TextStyle(
                        color: ColorClass.fontColor,
                        fontFamily: FontClass.appFont,
                        fontSize: 17),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {},
                      leading: Text(
                        "Chat App",
                        style: TextStyle(
                            color: ColorClass.fontColor,
                            fontFamily: FontClass.appFont,
                            fontSize: 17),
                      ),
                      trailing: Icon(
                        Icons.chat,
                        color: ColorClass.drawerIcons,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Divider(
                        color: ColorClass.dividerColor,
                        height: 5,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {},
                      leading: Text(
                        "PM App",
                        style: TextStyle(
                            color: ColorClass.fontColor,
                            fontFamily: FontClass.appFont,
                            fontSize: 17),
                      ),
                      trailing: Icon(
                        Icons.view_array,
                        color: ColorClass.drawerIcons,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Divider(
                        color: ColorClass.dividerColor,
                        height: 5,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {},
                      leading: Text(
                        "DV App (Older)",
                        style: TextStyle(
                            color: ColorClass.fontColor,
                            fontFamily: FontClass.appFont,
                            fontSize: 17),
                      ),
                      trailing: Icon(
                        Icons.pie_chart,
                        color: ColorClass.drawerIcons,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Divider(
                        color: ColorClass.dividerColor,
                        height: 5,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {},
                      leading: Text(
                        "DV App (Old)",
                        style: TextStyle(
                            color: ColorClass.fontColor,
                            fontFamily: FontClass.appFont,
                            fontSize: 17),
                      ),
                      trailing: Icon(
                        Icons.pie_chart,
                        color: ColorClass.drawerIcons,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Divider(
                        color: ColorClass.dividerColor,
                        height: 5,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
              padding: const EdgeInsets.only(right: 15.0, top: 20),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('Images/Logo.png'))),
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
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new Dashboards()));
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
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new OpenFile()));
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
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new DataSources()));
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
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new Visualizers()));
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
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new Filters()));
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
