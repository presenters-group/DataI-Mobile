import 'package:eyedatai/Classes/Dashboard.dart';
import 'package:eyedatai/Opened/DashboardOpened.dart';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class Dashboards extends StatefulWidget {
  List<Dashboard> dashboards = new List();

  Dashboards({@required this.dashboards});

  @override
  _DashboardsState createState() => _DashboardsState(dashboards);
}

class _DashboardsState extends State<Dashboards> {
  List<Dashboard> dashboards = new List();

  _DashboardsState(this.dashboards);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              "Dashboards",
              style: TextStyle(
                  color: ColorClass.fontColor,
                  fontFamily: FontClass.appFont,
                  fontSize: 17),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 25),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: ColorClass.scaffoldBackgroundColor,
          elevation: 0.0,
        ),
      ),
      backgroundColor: ColorClass.scaffoldBackgroundColor,
      body: ListView.builder(
          itemCount: dashboards.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 8.0, left: 25.0, right: 25.0),
              child: new Container(
                height: 110.00,
                width: MediaQuery.of(context).size.width,
                color: ColorClass.containerColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  new DashboardOpened(dashboards[index].name)));
                    },
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Text("Name : ${dashboards[index].name}",
                                  style: TextStyle(
                                      color: ColorClass.fontColor,
                                      fontFamily: FontClass.appFont,
                                      fontSize: 17)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  "Number of visualizers : ${dashboards[index].visualizersList.length}",
                                  style: TextStyle(
                                      color: ColorClass.subTitleColor,
                                      fontFamily: FontClass.appFont,
                                      fontSize: 15)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
