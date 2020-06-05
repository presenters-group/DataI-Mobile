import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';
import 'FiltersOnVisualizer.dart';

// ignore: must_be_immutable
class DashboardOpened extends StatefulWidget {
  var titleDashboard;

  DashboardOpened(this.titleDashboard);

  @override
  _DashboardOpenedState createState() => _DashboardOpenedState(titleDashboard);
}

class _DashboardOpenedState extends State<DashboardOpened> {
  var titleDashboard;
  int indexClicked = -1;
  bool isLine = false, isBar = false, isPie = false;

  _DashboardOpenedState(this.titleDashboard);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              titleDashboard,
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
                color: ColorClass.fontColor,
                size: 17,
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
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 25.0, left: 15.0, right: 16.0),
                  child: Container(
                    height: 295.0,
                    width: MediaQuery.of(context).size.width,
                    color: null,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      indexClicked = index;
                                      isBar = true;
                                      isLine = isPie = false;
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: (isBar && indexClicked == index)
                                        ? BoxDecoration(color: Colors.white)
                                        : null,
                                    child: Icon(
                                      Icons.insert_chart,
                                      size: 27,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      indexClicked = index;
                                      isLine = true;
                                      isBar = isPie = false;
                                    });
                                  },
                                  child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: (isLine &&
                                          indexClicked == index)
                                          ? BoxDecoration(color: Colors.white)
                                          : null,
                                      child: Icon(Icons.show_chart, size: 27)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      indexClicked = index;
                                      isPie = true;
                                      isLine = isBar = false;
                                    });
                                  },
                                  child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: (isPie &&
                                          indexClicked == index)
                                          ? BoxDecoration(color: Colors.white)
                                          : null,
                                      child: Icon(Icons.pie_chart, size: 25)),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                              new FiltersOnVisualizer()));
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'Images/Filter.png'))),
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, right: 8.0),
                                  child: Text(
                                    "(Visualizer 1)",
                                    style: TextStyle(
                                        color: ColorClass.fontColor,
                                        fontFamily: FontClass.appFont,
                                        fontSize: 12),
                                  )),
                            ],
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 53.0, bottom: 25.0, left: 15.0, right: 15.0),
                  child: Container(
                    height: 258.00,
                    width: MediaQuery.of(context).size.width,
                    color: ColorClass.containerColor,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
