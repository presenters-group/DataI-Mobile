import 'package:eyedatai/Classes/Visualizer.dart';
import 'package:eyedatai/Opened/VisualizerOpened.dart';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class Visualizers extends StatefulWidget {
  List<Visualizer> visualizers = new List();

  Visualizers({@required this.visualizers});

  @override
  _VisualizersState createState() => _VisualizersState(visualizers);
}

class _VisualizersState extends State<Visualizers> {
  List<Visualizer> visualizers = new List();

  _VisualizersState(this.visualizers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              "Visualizers",
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
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(
              top: 12.0, bottom: 8.0, left: 25.0, right: 25.0),
          child: new Container(
            height: 165.00,
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
                              new VisualizerOpened("Visualizer 1")));
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
                          child: Text("Name : Visualizer 1",
                              style: TextStyle(
                                  color: ColorClass.fontColor,
                                  fontFamily: FontClass.appFont,
                                  fontSize: 17)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Used Columns : Col1 , Col2 , Col3",
                              style: TextStyle(
                                  color: ColorClass.subTitleColor,
                                  fontFamily: FontClass.appFont,
                                  fontSize: 15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Used Rows : Row1 , Row2 ",
                              style: TextStyle(
                                  color: ColorClass.subTitleColor,
                                  fontFamily: FontClass.appFont,
                                  fontSize: 15)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Used Filters : Filter1 , Filter2 ",
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
