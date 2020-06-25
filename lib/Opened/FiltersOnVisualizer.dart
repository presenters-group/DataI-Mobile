import 'package:eyedatai/Classes/VisualizerModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class FiltersOnVisualizer extends StatefulWidget {
  VisualizerModel visualizerModel;

  FiltersOnVisualizer(this.visualizerModel);

  @override
  _FiltersOnVisualizerState createState() =>
      _FiltersOnVisualizerState(visualizerModel);
}

class _FiltersOnVisualizerState extends State<FiltersOnVisualizer> {
  VisualizerModel visualizerModel;

  _FiltersOnVisualizerState(this.visualizerModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                "Filter (${visualizerModel.visualizerName})",
                style: TextStyle(
                    color: ColorClass.fontColor,
                    fontFamily: FontClass.appFont,
                    fontSize: 15),
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
                      image: DecorationImage(
                          image: AssetImage('Images/Logo.png'))),
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
            itemCount: visualizerModel.filtersModel.length,
            itemBuilder: (BuildContext context, int indexGrid) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: visualizerModel
                    .filtersModel[indexGrid]
                    .dataSource
                    .columnsList[visualizerModel
                    .filtersModel[indexGrid].filteredColumn]
                    .columnType !=
                    "Measures"
                    ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            leading: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${visualizerModel
                                      .filtersModel[indexGrid].name} ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: FontClass.appFont,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    visualizerModel
                                        .filtersModel[indexGrid]
                                        .dataSource
                                        .columnsList[visualizerModel
                                        .filtersModel[indexGrid]
                                        .filteredColumn]
                                        .name,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: FontClass.appFont,
                                        fontSize: 17),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Checkbox(
                              onChanged: (val) {},
                              value: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 8),
                          child: Divider(
                            color: Colors.grey,
                            height: 5,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: List.generate(
                                visualizerModel
                                    .filtersModel[indexGrid]
                                    .dataSource
                                    .columnsList[visualizerModel
                                    .filtersModel[indexGrid]
                                    .filteredColumn]
                                    .cells
                                    .length, (index) {
                              return index == 0
                                  ? Container(
                                width: 0.0,
                                height: 0.0,
                              )
                                  : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                        onChanged: (val) {},
                                        value: true,
                                      ),
                                      Text(
                                        visualizerModel
                                            .filtersModel[indexGrid]
                                            .dataSource
                                            .columnsList[
                                        visualizerModel
                                            .filtersModel[
                                        indexGrid]
                                            .filteredColumn]
                                            .cells[index]
                                            .value
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily:
                                            FontClass.appFont,
                                            fontSize: 17),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                )
                    : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          leading: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                visualizerModel
                                    .filtersModel[indexGrid].name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: FontClass.appFont,
                                    fontSize: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  visualizerModel
                                      .filtersModel[indexGrid]
                                      .dataSource
                                      .columnsList[visualizerModel
                                      .filtersModel[indexGrid]
                                      .filteredColumn]
                                      .name,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: FontClass.appFont,
                                      fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                          trailing: Checkbox(
                            onChanged: (val) {},
                            value: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 8),
                        child: Divider(
                          color: Colors.grey,
                          height: 5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              visualizerModel
                                  .filtersModel[indexGrid].type ==
                                  "LessThan"
                                  ? Text(
                                "<",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: FontClass.appFont,
                                    fontSize: 17),
                              )
                                  : Text(
                                ">",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: FontClass.appFont,
                                    fontSize: 17),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 12.0),
                                child: Container(
                                    height: 25.00,
                                    width: 100.00,
                                    color:
                                    ColorClass.filterContainerColor,
                                    child: Center(
                                        child: Text(
                                          "100",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: FontClass.appFont,
                                              fontSize: 17),
                                        ))),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            })
      /*GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          children:
              List.generate(visualizerModel.filtersModel.length, (indexGrid) {
            return visualizerModel
                        .filtersModel[indexGrid]
                        .dataSource
                        .listColumns[visualizerModel
                            .filtersModel[indexGrid].filteredColumn]
                        .columnType ==
                    "Measures"
                ? Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ListTile(
                              leading: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    visualizerModel
                                        .filtersModel[indexGrid].name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: FontClass.appFont,
                                        fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      visualizerModel
                                          .filtersModel[indexGrid]
                                          .dataSource
                                          .listColumns[visualizerModel
                                              .filtersModel[indexGrid]
                                              .filteredColumn]
                                          .name,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: FontClass.appFont,
                                          fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Checkbox(
                                onChanged: (val) {},
                                value: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 8),
                            child: Divider(
                              color: Colors.grey,
                              height: 5,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: List.generate(
                                  visualizerModel
                                      .filtersModel[indexGrid]
                                      .dataSource
                                      .listColumns[visualizerModel
                                          .filtersModel[indexGrid]
                                          .filteredColumn]
                                      .cells
                                      .length, (index) {
                                return index == 0
                                    ? Container(
                                        width: 0.0,
                                        height: 0.0,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: <Widget>[
                                              Checkbox(
                                                onChanged: (val) {},
                                                value: true,
                                              ),
                                              Text(
                                                visualizerModel
                                                    .filtersModel[indexGrid]
                                                    .dataSource
                                                    .listColumns[visualizerModel
                                                        .filtersModel[indexGrid]
                                                        .filteredColumn]
                                                    .cells[index]
                                                    .value
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily:
                                                        FontClass.appFont,
                                                    fontSize: 17),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              }),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            leading: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  visualizerModel.filtersModel[indexGrid].name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: FontClass.appFont,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    visualizerModel
                                        .filtersModel[indexGrid]
                                        .dataSource
                                        .listColumns[visualizerModel
                                            .filtersModel[indexGrid]
                                            .filteredColumn]
                                        .name,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: FontClass.appFont,
                                        fontSize: 17),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Checkbox(
                              onChanged: (val) {},
                              value: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 8),
                          child: Divider(
                            color: Colors.grey,
                            height: 5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                visualizerModel.filtersModel[indexGrid].type ==
                                        "LessThan"
                                    ? Text(
                                        ">",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: FontClass.appFont,
                                            fontSize: 17),
                                      )
                                    : Text(
                                        "<",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: FontClass.appFont,
                                            fontSize: 17),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Container(
                                      height: 25.00,
                                      width: 100.00,
                                      color: ColorClass.filterContainerColor,
                                      child: Center(
                                          child: Text(
                                        "100",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: FontClass.appFont,
                                            fontSize: 17),
                                      ))),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
          })),*/
    );
  }
}
//visualizerModel.filtersModel[index].dataSource.listColumns[visualizerModel.filtersModel[index].filteredColumn].columnType
