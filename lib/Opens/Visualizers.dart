import 'package:eyedatai/Classes/VisualizerModel.dart';
import 'package:eyedatai/Opened/VisualizerOpened.dart';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class Visualizers extends StatefulWidget {
  List<VisualizerModel> visualizers = new List();

  Visualizers({@required this.visualizers});

  @override
  _VisualizersState createState() => _VisualizersState(visualizers);
}

class _VisualizersState extends State<Visualizers> {
  List<VisualizerModel> visualizers = new List();

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
      body: ListView.builder(
          itemCount: visualizers.length,
          itemBuilder: (BuildContext context, int indexList) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 8.0, left: 25.0, right: 25.0),
              child: new Container(
                height: 140.00, //165
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: ColorClass.containerColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                              new VisualizerOpened(
                                  visualizers[indexList])));
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
                              child: Text(
                                  "Name : ${visualizers[indexList]
                                      .visualizerName}",
                                  style: TextStyle(
                                      color: ColorClass.fontColor,
                                      fontFamily: FontClass.appFont,
                                      fontSize: 17)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    Text("Used Columns : ",
                                        style: TextStyle(
                                            color: ColorClass.subTitleColor,
                                            fontFamily: FontClass.appFont,
                                            fontSize: 12)),
                                    Row(
                                        children: List.generate(
                                            visualizers[indexList]
                                                .usedColumns
                                                .length, (index) {
                                          return Row(
                                            children: <Widget>[
                                              Text(
                                                  "${visualizers[indexList]
                                                      .columnsModel[index]
                                                      .name}",
                                                  style: TextStyle(
                                                      color:
                                                      ColorClass.subTitleColor,
                                                      fontFamily: FontClass
                                                          .appFont,
                                                      fontSize: 12)),
                                              index ==
                                                  visualizers[indexList]
                                                      .usedColumns
                                                      .length -
                                                      1
                                                  ? Container(
                                                width: 0.0,
                                                height: 0.0,
                                              )
                                                  : Text(" , ",
                                                  style: TextStyle(
                                                      color: ColorClass
                                                          .subTitleColor,
                                                      fontFamily:
                                                      FontClass.appFont,
                                                      fontSize: 12))
                                            ],
                                          );
                                        })),
                                  ],
                                ),
                              ),
                            ),
                            /*Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Used Rows : Row1 , Row2 ",
                              style: TextStyle(
                                  color: ColorClass.subTitleColor,
                                  fontFamily: FontClass.appFont,
                                  fontSize: 15)),
                        ),*/
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    Text("Used Filters : ",
                                        style: TextStyle(
                                            color: ColorClass.subTitleColor,
                                            fontFamily: FontClass.appFont,
                                            fontSize: 12)),
                                    Row(
                                        children: List.generate(
                                            visualizers[indexList].filtersModel
                                                .length, (index) {
                                          return Row(children: <Widget>[
                                            Text("${visualizers[indexList]
                                                .filtersModel[index]
                                                .name}",
                                                style: TextStyle(
                                                    color: ColorClass
                                                        .subTitleColor,
                                                    fontFamily: FontClass
                                                        .appFont,
                                                    fontSize: 12)),
                                            index ==
                                                visualizers[indexList]
                                                    .filtersModel
                                                    .length -
                                                    1
                                                ? Container(
                                              width: 0.0,
                                              height: 0.0,
                                            )
                                                : Text(" , ",
                                                style: TextStyle(
                                                    color: ColorClass
                                                        .subTitleColor,
                                                    fontFamily: FontClass
                                                        .appFont,
                                                    fontSize: 12))
                                          ],);
                                        })
                                    ),
                                  ],
                                ),
                              ),
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
