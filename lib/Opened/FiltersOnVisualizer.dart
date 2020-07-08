import 'package:eyedatai/Classes/DataSources/ColumnModel.dart';
import 'package:eyedatai/Classes/DataSources/TableModel.dart';
import 'package:eyedatai/Classes/FilterModel.dart';
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

  //List<TextEditingController> txtControllers = new List();
  List<FilterModel> measures = new List();
  List<FilterModel> dimensions = new List();
  bool isChangedAnyThing = false;

  _FiltersOnVisualizerState(this.visualizerModel);

  @override
  void initState() {
    /*for (int i = 0; i < visualizerModel.filtersModel.length; i++) {
      if (visualizerModel
              .filtersModel[i]
              .dataSource
              .columnsList[visualizerModel.filtersModel[i].filteredColumn]
              .columnType ==
          "Measures") {
        txtControllers.add(new TextEditingController());
      }
    }*/
    measures = [];
    dimensions = [];
    for (int i = 0; i < visualizerModel.filtersModel.length; i++) {
      if (visualizerModel
              .filtersModel[i]
              .dataSource
              .columnsList[visualizerModel.filtersModel[i].filteredColumn]
              .columnType ==
          "Measures") {
        measures.add(visualizerModel.filtersModel[i]);
      } else {
        dimensions.add(visualizerModel.filtersModel[i]);
      }
    }

    /*  List<ColumnModel> measuresColumns = new List();
    for (int i = 0; i < visualizerModel.filtersModel.length; i++) {
      if (visualizerModel
              .filtersModel[i]
              .dataSource
              .columnsList[visualizerModel.filtersModel[i].filteredColumn]
              .columnType ==
          "Measures") {
        measuresColumns.add(visualizerModel.filtersModel[i].dataSource
            .columnsList[visualizerModel.filtersModel[i].filteredColumn]);
      }
    }
    for (int i = 0; i < visualizerModel.filtersModel.length; i++) {
      if (visualizerModel
              .filtersModel[i]
              .dataSource
              .columnsList[visualizerModel.filtersModel[i].filteredColumn]
              .columnType ==
          "Measures") {
        visualizerModel.filtersModel[i].dataSource.columnsList.remove(
            visualizerModel.filtersModel[i].dataSource
                .columnsList[visualizerModel.filtersModel[i].filteredColumn]);
      }
    }
    for (int i = 0; i < measuresColumns.length; i++) {
      visualizerModel.filtersModel[i].dataSource.columnsList.insert(i, measuresColumns[i]);
    }

*/

    super.initState();
  }

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
              isChangedAnyThing
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 20),
                      child: IconButton(
                        onPressed: () {
                          for (int i = 0;
                              i < visualizerModel.filtersModel.length;
                              i++) {
                            print(
                                " ${visualizerModel.filtersModel[i].name}  --->  ${visualizerModel.filtersModel[i].textEditingController.text}");
                          }
                        },
                        icon: Icon(
                          Icons.done,
                          color: ColorClass.fontColor,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 15.0, top: 20),
                      child: InkWell(
                        onTap: () {
                          for (int i = 0;
                              i < visualizerModel.filtersModel.length;
                              i++) {
                            print(
                                " ${visualizerModel.filtersModel[i].name}  --->  ${visualizerModel.filtersModel[i].textEditingController.text}");
                          }
                        },
                        child: Container(
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                children: List.generate(measures.length, (indexGrid) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                                    measures[indexGrid].name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: FontClass.appFont,
                                        fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      measures[indexGrid]
                                          .dataSource
                                          .columnsList[measures[indexGrid]
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
                                onChanged: (val) {
                                  setState(() {
                                    isChangedAnyThing = true;
                                    measures[indexGrid].isActive = val;
                                  });
                                },
                                value: measures[indexGrid].isActive,
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
                                  measures[indexGrid].type == "LessThan"
                                      ? Text(
                                          "<",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: FontClass.appFont,
                                              fontSize: 17),
                                        )
                                      : measures[indexGrid].type ==
                                              "GreaterThan"
                                          ? Text(
                                              ">",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: FontClass.appFont,
                                                  fontSize: 17),
                                            )
                                          : Text(
                                              "=",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: FontClass.appFont,
                                                  fontSize: 17),
                                            ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Container(
                                        height: 35.00,
                                        width: 110.00,
                                        color: ColorClass.filterContainerColor,
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, top: 8.0),
                                              child: new TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isChangedAnyThing = true;
                                                  });
                                                  if (measures[indexGrid]
                                                          .textEditingController
                                                          .text
                                                          .length >=
                                                      9) {
                                                    measures[indexGrid]
                                                        .textEditingController
                                                        .clear();
                                                  }
                                                },
                                                onSubmitted: (val) {},
                                                style: TextStyle(
                                                    color: ColorClass.fontColor,
                                                    fontFamily:
                                                        FontClass.appFont,
                                                    fontSize: 15),
                                                textAlign: TextAlign.left,
                                                controller: measures[indexGrid]
                                                    .textEditingController,
                                                decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily:
                                                          FontClass.appFont,
                                                      fontSize: 12),
                                                  hintText: 'Value',
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
              Column(
                children: List.generate(dimensions.length, (indexGrid) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
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
                                      "${dimensions[indexGrid].name} ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: FontClass.appFont,
                                          fontSize: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        dimensions[indexGrid]
                                            .dataSource
                                            .columnsList[dimensions[indexGrid]
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
                                  onChanged: (val) {
                                    setState(() {
                                      isChangedAnyThing = true;
                                      dimensions[indexGrid].isActive = val;
                                    });
                                  },
                                  value: dimensions[indexGrid].isActive,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    dimensions[indexGrid]
                                        .dataSource
                                        .columnsList[dimensions[indexGrid]
                                            .filteredColumn]
                                        .cells
                                        .length, (index) {
                                  return index == 0
                                      ? Container(
                                          width: 0.0,
                                          height: 0.0,
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: <Widget>[
                                                Checkbox(
                                                  onChanged: (val) {
                                                    setState(() {
                                                      isChangedAnyThing = true;
                                                    });
                                                  },
                                                  value: true,
                                                ),
                                                Text(
                                                  dimensions[indexGrid]
                                                      .dataSource
                                                      .columnsList[
                                                          dimensions[indexGrid]
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
                    ),
                  );
                }),
              ),
            ],
          ),
        )
        /*ListView.builder(
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
                        height: 250,
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
                                        "${visualizerModel.filtersModel[indexGrid].name} ",
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
                                    onChanged: (val) {
                                      setState(() {
                                        visualizerModel.filtersModel[indexGrid]
                                            .isActive = val;
                                      });
                                    },
                                    value: visualizerModel
                                        .filtersModel[indexGrid].isActive,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            padding: const EdgeInsets.all(0.0),
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
                                  onChanged: (val) {
                                    setState(() {
                                      visualizerModel.filtersModel[indexGrid]
                                          .isActive = val;
                                    });
                                  },
                                  value: visualizerModel
                                      .filtersModel[indexGrid].isActive,
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
                                        : visualizerModel
                                                    .filtersModel[indexGrid]
                                                    .type ==
                                                "GreaterThan"
                                            ? Text(
                                                ">",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                        FontClass.appFont,
                                                    fontSize: 17),
                                              )
                                            : Text(
                                                "=",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                        FontClass.appFont,
                                                    fontSize: 17),
                                              ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Container(
                                          height: 40.00,
                                          width: 100.00,
                                          color:
                                              ColorClass.filterContainerColor,
                                          child: Center(
                                            child: Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, top: 8.0),
                                                child: new TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) {
                                                    if (txtControllers[
                                                                indexGrid]
                                                            .text
                                                            .length >=
                                                        9) {
                                                      txtControllers[indexGrid]
                                                          .clear();
                                                    }
                                                  },
                                                  onSubmitted: (val) {},
                                                  style: TextStyle(
                                                      color:
                                                          ColorClass.fontColor,
                                                      fontFamily:
                                                          FontClass.appFont,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.left,
                                                  controller:
                                                      txtControllers[0],
                                                  decoration:
                                                      new InputDecoration(
                                                    border: InputBorder.none,
                                                    hintStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            FontClass.appFont,
                                                        fontSize: 12),
                                                    hintText: 'Value',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              );
            })*/
        );
  }

  void doSubmitted() {
    List<FilterModel> activeFilters = new List();
    List<ColumnModel> tempColumnModels = new List();
    TableModel filteredTableModel;

    for (int i = 0; i < visualizerModel.filtersModel.length; i++) {
      if (visualizerModel.filtersModel[i].isActive) {
        activeFilters.add(visualizerModel.filtersModel[i]);
      }
    }

    for (int i = 0; i < activeFilters.length; i++) {
      if (activeFilters[i]
              .dataSource
              .columnsList[activeFilters[i].filteredColumn]
              .columnType ==
          "Measures") {
        if (activeFilters[i].type == "Equality") {
          for (int inner = 0;
              inner < activeFilters[inner].dataSource.columnsList.length;
              inner++) {
            if (double.parse(activeFilters[inner]
                    .dataSource
                    .columnsList[inner]
                    .cells[inner]
                    .value) ==
                double.parse(activeFilters[activeFilters[i].id]
                    .textEditingController
                    .text
                    .toString())) {}
          }
        } else if (activeFilters[i].type == "LessThan") {
          for (int inner = 0;
              inner < activeFilters[inner].dataSource.columnsList.length;
              inner++) {
            if (double.parse(activeFilters[inner]
                    .dataSource
                    .columnsList[inner]
                    .cells[inner]
                    .value) >
                double.parse(activeFilters[activeFilters[i].id]
                    .textEditingController
                    .text
                    .toString())) {}
          }
        } else if (activeFilters[i].type == "GreaterThan") {
          for (int inner = 0;
              inner < activeFilters[inner].dataSource.columnsList.length;
              inner++) {
            if (double.parse(activeFilters[inner]
                    .dataSource
                    .columnsList[inner]
                    .cells[inner]
                    .value) <
                double.parse(activeFilters[activeFilters[i].id]
                    .textEditingController
                    .text
                    .toString())) {}
          }
        }
      } else if (activeFilters[i]
              .dataSource
              .columnsList[activeFilters[i].filteredColumn]
              .columnType ==
          "Dimensions") {


      }
    }

    /*for (int i = 0; i < columnModel.cells.length; i++) {
      if (visualizerModel.filtersModel[indexGrid].type == "Equality") {
        if (columnModel.cells[i].value == value) {}
      } else {}
    }*/
  }
}
//visualizerModel.filtersModel[index].dataSource.listColumns[visualizerModel.filtersModel[index].filteredColumn].columnType
//ColumnModel columnModel = new ColumnModel();
//
//tempColumnModels.add(columnModel);
