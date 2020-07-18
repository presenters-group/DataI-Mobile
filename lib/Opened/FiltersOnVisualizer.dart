import 'package:eyedatai/Classes/DataSources/CellModel.dart';
import 'package:eyedatai/Classes/DataSources/ColumnModel.dart';
import 'package:eyedatai/Classes/DataSources/TableModel.dart';
import 'package:eyedatai/Classes/FilterModel.dart';
import 'package:eyedatai/Classes/VisualizerModel.dart';
import 'package:eyedatai/Opened/DashboardOpened.dart';
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
  List<List<bool>> bools = new List();
  List<bool> bool1 = new List();

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
    /*   measures = [];
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
*/
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

    for (int i = 0; i < visualizerModel.filtersModel.length; i++) {
      for (int j = 0;
          j <
              visualizerModel
                  .filtersModel[i]
                  .dataSource
                  .columnsList[visualizerModel.filtersModel[i].filteredColumn]
                  .cells
                  .length;
          j++) {
        bool1.add(false);
      }
      bools.add(bool1);
      bool1 = [];
    }

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
                          doSubmitted();
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
        body:
            /*SingleChildScrollView(
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
        )*/
            ListView.builder(
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
                                            isChangedAnyThing = true;
                                          });
                                          setState(() {
                                            visualizerModel
                                                .filtersModel[indexGrid]
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Checkbox(
                                                          onChanged: (val) {
                                                            setState(() {
                                                              visualizerModel
                                                                  .filtersModel[
                                                                      indexGrid]
                                                                  .isActive = true;
                                                              isChangedAnyThing =
                                                                  true;
                                                              visualizerModel
                                                                      .filtersModel[
                                                                          indexGrid]
                                                                      .isActivatedCells[
                                                                  index] = val;
                                                            });
                                                          },
                                                          value: visualizerModel
                                                                  .filtersModel[
                                                                      indexGrid]
                                                                  .isActivatedCells[
                                                              index]),
                                                      Text(
                                                        visualizerModel
                                                            .filtersModel[
                                                                indexGrid]
                                                            .dataSource
                                                            .columnsList[visualizerModel
                                                                .filtersModel[
                                                                    indexGrid]
                                                                .filteredColumn]
                                                            .cells[index]
                                                            .value
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontFamily:
                                                                FontClass
                                                                    .appFont,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          isChangedAnyThing = true;
                                          visualizerModel
                                              .filtersModel[indexGrid]
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
                                        visualizerModel.filtersModel[indexGrid]
                                                    .type ==
                                                "<"
                                            ? Text(
                                                "<",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                        FontClass.appFont,
                                                    fontSize: 17),
                                              )
                                            : visualizerModel
                                                        .filtersModel[indexGrid]
                                                        .type ==
                                                    ">"
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
                                              height: 35.00,
                                              width: 110.00,
                                              color: ColorClass
                                                  .filterContainerColor,
                                              child: Center(
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0,
                                                            top: 8.0),
                                                    child: new TextField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isChangedAnyThing =
                                                              true;
                                                          visualizerModel
                                                              .filtersModel[
                                                                  indexGrid]
                                                              .isActive = true;
                                                        });
                                                        if (visualizerModel
                                                                .filtersModel[
                                                                    indexGrid]
                                                                .textEditingController
                                                                .text
                                                                .length >=
                                                            9) {
                                                          visualizerModel
                                                              .filtersModel[
                                                                  indexGrid]
                                                              .textEditingController
                                                              .clear();
                                                        }
                                                      },
                                                      onSubmitted: (val) {},
                                                      style: TextStyle(
                                                          color: ColorClass
                                                              .fontColor,
                                                          fontFamily:
                                                              FontClass.appFont,
                                                          fontSize: 15),
                                                      textAlign: TextAlign.left,
                                                      controller: visualizerModel
                                                          .filtersModel[
                                                              indexGrid]
                                                          .textEditingController,
                                                      decoration:
                                                          new InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                FontClass
                                                                    .appFont,
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
                }));
  }

  void doSubmitted() {
    List<FilterModel> activeFilters = new List();
    List<FilterModel> tempActiveFilters = new List();
    List<ColumnModel> tempColumnModels = new List();
    TableModel filteredTableModel;
    List<CellModel> tempNumbers = new List();
    List<List<CellModel>> allTempsNumbers = new List();
    List<CellModel> trueData = new List();
    Map<String, dynamic> columnsWithIDs = new Map();
    Map<String, dynamic> filtersWithIDs = new Map();

    for (int i = 0; i < visualizerModel.filtersModel.length; i++) {
      if (visualizerModel.filtersModel[i].isActive) {
        activeFilters.add(visualizerModel.filtersModel[i]);
      }
    }
    for (int a = 0; a < activeFilters.length; a++) {
      tempActiveFilters.add(activeFilters[a]);
    }
    print("*****");
    print(activeFilters.length);
    print(tempActiveFilters.length);

    for (int i = 0; i < activeFilters.length; i++) {
      if (activeFilters[i]
              .dataSource
              .columnsList[activeFilters[i].filteredColumn]
              .columnType ==
          "Measures") {
        if (activeFilters[i].type == "MultipleEquality") {
          allTempsNumbers = [];
          trueData = [];
          tempColumnModels = [];
          tempNumbers = [];
          for (int inner = 1;
              inner <
                  activeFilters[i]
                      .dataSource
                      .columnsList[activeFilters[i].filteredColumn]
                      .cells
                      .length;
              inner++) {
            if (double.parse(activeFilters[i] //activeFilters[i].id //inner
                    .dataSource
                    .columnsList[activeFilters[i].filteredColumn]
                    .cells[inner]
                    .value
                    .toString()) ==
                double.parse(activeFilters[i] //activeFilters[i].id
                    .textEditingController
                    .text
                    .toString())) {
              trueData.add(new CellModel(
                  value: activeFilters[i]
                      .dataSource
                      .columnsList[activeFilters[i].filteredColumn]
                      .cells[inner]
                      .value,
                  type: activeFilters[i]
                      .dataSource
                      .columnsList[activeFilters[i].filteredColumn]
                      .cells[inner]
                      .type));
            }
          }
          print("Equality");
          print(trueData);
          if (trueData.isNotEmpty) {
            //trueData[0] because same data in all list ..
            for (int j = 0;
                j <
                    activeFilters[i]
                        .dataSource
                        .columnsList[activeFilters[i].filteredColumn]
                        .cells
                        .length;
                j++) {
              if (activeFilters[i]
                      .dataSource
                      .columnsList[activeFilters[i].filteredColumn]
                      .cells[j]
                      .value ==
                  trueData[0].value) {
                for (int u = 0;
                    u < activeFilters[i].dataSource.columnsList.length;
                    u++) {
                  tempNumbers
                      .add(activeFilters[i].dataSource.columnsList[u].cells[j]);
                }
                allTempsNumbers.add(tempNumbers);
                tempNumbers = [];
              }
            }

            print(allTempsNumbers);
            print(allTempsNumbers.length);
            List<CellModel> tempCells = new List();
            List<List<CellModel>> allTempsCells = new List();
            for (int t = 0; t < allTempsNumbers[0].length; t++) {
              for (int a = 0; a < allTempsNumbers.length; a++) {
                tempCells.add(CellModel(
                    value: allTempsNumbers[a][t].value,
                    type: allTempsNumbers[a][t].type));
              }
              allTempsCells.add(tempCells);
              tempCells = [];
            }
            for (int y = 0; y < allTempsCells.length; y++) {
              tempColumnModels.add(ColumnModel(
                  id: activeFilters[i].dataSource.columnsList[y].id,
                  name: activeFilters[i].dataSource.columnsList[y].name,
                  isDeleted:
                      activeFilters[i].dataSource.columnsList[y].isDeleted,
                  columnType:
                      activeFilters[i].dataSource.columnsList[y].columnType,
                  valueCategories: activeFilters[i]
                      .dataSource
                      .columnsList[y]
                      .valueCategories,
                  cells: allTempsCells[y]));
            }
            /*new FilterModel(
                id: activeFilters[i].id,
                name: activeFilters[i].name,
                type: activeFilters[i].type,
                isActivatedCells: activeFilters[i].isActivatedCells,
                textEditingController: activeFilters[i].textEditingController,
                dataSource: activeFilters[i].dataSource,
                initValue: activeFilters[i].initValue,
                isActive: activeFilters[i].isActive,
                filteredColumn: activeFilters[i].filteredColumn,
                dataSourceID: activeFilters[i].dataSourceID,
                isDeleted: activeFilters[i].isDeleted);*/

            //tempActiveFilters[i].dataSource.columnsList = tempColumnModels;
            filtersWithIDs.addAll({
              i.toString(): activeFilters[i],
            });
            columnsWithIDs.addAll({i.toString(): tempColumnModels});
            for (int q = 0;
                q < tempActiveFilters[i].dataSource.columnsList[0].cells.length;
                q++) {
              print(tempActiveFilters[i].dataSource.columnsList[0].cells[q]);
            }

            allTempsNumbers = [];
            trueData = [];
            tempColumnModels = [];
          }
        } else if (activeFilters[i].type == "<") {
          allTempsNumbers = [];
          trueData = [];
          tempColumnModels = [];
          tempNumbers = [];
          for (int inner = 1;
              inner <
                  activeFilters[i]
                      .dataSource
                      .columnsList[activeFilters[i].filteredColumn]
                      .cells
                      .length;
              inner++) {
            if (double.parse(activeFilters[i] //activeFilters[i].id
                    .dataSource
                    .columnsList[activeFilters[i].filteredColumn]
                    .cells[inner]
                    .value
                    .toString()) <
                double.parse(activeFilters[i] //activeFilters[i].id
                    .textEditingController
                    .text
                    .toString())) {
              trueData.add(new CellModel(
                  value: activeFilters[i]
                      .dataSource
                      .columnsList[activeFilters[i].filteredColumn]
                      .cells[inner]
                      .value,
                  type: activeFilters[i]
                      .dataSource
                      .columnsList[activeFilters[i].filteredColumn]
                      .cells[inner]
                      .type));
            }
          }
          print("LessThan  '<' ");
          print(trueData);
          List<dynamic> trueDataList = new List();
          for (int g = 0; g < trueData.length; g++) {
            trueDataList.add(trueData[g].value);
          }
          if (trueData.isNotEmpty) {
            for (int j = 0;
                j <
                    activeFilters[i]
                        .dataSource
                        .columnsList[activeFilters[i].filteredColumn]
                        .cells
                        .length;
                j++) {
              if (trueDataList.contains(activeFilters[i]
                  .dataSource
                  .columnsList[activeFilters[i].filteredColumn]
                  .cells[j]
                  .value)) {
                for (int u = 0;
                    u < activeFilters[i].dataSource.columnsList.length;
                    u++) {
                  tempNumbers
                      .add(activeFilters[i].dataSource.columnsList[u].cells[j]);
                }
                allTempsNumbers.add(tempNumbers);
                tempNumbers = [];
              }
            }

            print(allTempsNumbers);
            print(allTempsNumbers.length);
            List<CellModel> tempCells = new List();
            List<List<CellModel>> allTempsCells = new List();
            for (int t = 0; t < allTempsNumbers[0].length; t++) {
              for (int a = 0; a < allTempsNumbers.length; a++) {
                tempCells.add(CellModel(
                    value: allTempsNumbers[a][t].value,
                    type: allTempsNumbers[a][t].type));
              }
              allTempsCells.add(tempCells);
              tempCells = [];
            }
            for (int y = 0; y < allTempsCells.length; y++) {
              tempColumnModels.add(ColumnModel(
                  id: activeFilters[i].dataSource.columnsList[y].id,
                  name: activeFilters[i].dataSource.columnsList[y].name,
                  isDeleted:
                      activeFilters[i].dataSource.columnsList[y].isDeleted,
                  columnType:
                      activeFilters[i].dataSource.columnsList[y].columnType,
                  valueCategories: activeFilters[i]
                      .dataSource
                      .columnsList[y]
                      .valueCategories,
                  cells: allTempsCells[y]));
            }
            //tempActiveFilters[i].dataSource.columnsList = tempColumnModels;
            filtersWithIDs.addAll({
              i.toString(): activeFilters[i],
            });
            columnsWithIDs.addAll({i.toString(): tempColumnModels});
            for (int q = 0;
                q < tempActiveFilters[i].dataSource.columnsList[0].cells.length;
                q++) {
              print(tempActiveFilters[i].dataSource.columnsList[0].cells[q]);
            }

            allTempsNumbers = [];
            trueData = [];
            tempColumnModels = [];
          }
        } else if (activeFilters[i].type == ">") {
          allTempsNumbers = [];
          trueData = [];
          tempColumnModels = [];
          tempNumbers = [];
          for (int inner = 1;
              inner <
                  activeFilters[i]
                      .dataSource
                      .columnsList[activeFilters[i].filteredColumn]
                      .cells
                      .length;
              inner++) {
            if (double.parse(activeFilters[i] //activeFilters[i].id
                    .dataSource
                    .columnsList[activeFilters[i].filteredColumn]
                    .cells[inner]
                    .value
                    .toString()) >
                double.parse(activeFilters[i] //activeFilters[i].id
                    .textEditingController
                    .text
                    .toString())) {
              trueData.add(new CellModel(
                  value: activeFilters[i]
                      .dataSource
                      .columnsList[activeFilters[i].filteredColumn]
                      .cells[inner]
                      .value,
                  type: activeFilters[i]
                      .dataSource
                      .columnsList[activeFilters[i].filteredColumn]
                      .cells[inner]
                      .type));
            }
          }
          print("GreaterThan  '>' ");
          print(trueData);
          List<dynamic> trueDataList = new List();
          for (int g = 0; g < trueData.length; g++) {
            trueDataList.add(trueData[g].value);
          }
          if (trueData.isNotEmpty) {
            for (int j = 0;
                j <
                    activeFilters[i]
                        .dataSource
                        .columnsList[activeFilters[i].filteredColumn]
                        .cells
                        .length;
                j++) {
              if (trueDataList.contains(activeFilters[i]
                  .dataSource
                  .columnsList[activeFilters[i].filteredColumn]
                  .cells[j]
                  .value)) {
                for (int u = 0;
                    u < activeFilters[i].dataSource.columnsList.length;
                    u++) {
                  tempNumbers
                      .add(activeFilters[i].dataSource.columnsList[u].cells[j]);
                }
                allTempsNumbers.add(tempNumbers);
                tempNumbers = [];
              }
            }

            print("======+++++++++++============");
            print(allTempsNumbers);
            print(allTempsNumbers.length);
            List<CellModel> tempCells = new List();
            List<List<CellModel>> allTempsCells = new List();
            for (int t = 0; t < allTempsNumbers[0].length; t++) {
              for (int a = 0; a < allTempsNumbers.length; a++) {
                tempCells.add(CellModel(
                    value: allTempsNumbers[a][t].value,
                    type: allTempsNumbers[a][t].type));
              }
              allTempsCells.add(tempCells);
              tempCells = [];
            }
            for (int y = 0; y < allTempsCells.length; y++) {
              tempColumnModels.add(ColumnModel(
                  id: activeFilters[i].dataSource.columnsList[y].id,
                  name: activeFilters[i].dataSource.columnsList[y].name,
                  isDeleted:
                      activeFilters[i].dataSource.columnsList[y].isDeleted,
                  columnType:
                      activeFilters[i].dataSource.columnsList[y].columnType,
                  valueCategories: activeFilters[i]
                      .dataSource
                      .columnsList[y]
                      .valueCategories,
                  cells: allTempsCells[y]));
            }
            //tempActiveFilters[i].dataSource.columnsList = tempColumnModels;
            filtersWithIDs.addAll({
              i.toString(): activeFilters[i],
            });
            columnsWithIDs.addAll({i.toString(): tempColumnModels});
            for (int q = 0;
                q < tempActiveFilters[i].dataSource.columnsList[0].cells.length;
                q++) {
              print(tempActiveFilters[i].dataSource.columnsList[0].cells[q]);
            }

            allTempsNumbers = [];
            trueData = [];
            tempColumnModels = [];
          }
        }
      } else if (activeFilters[i]
              .dataSource
              .columnsList[activeFilters[i].filteredColumn]
              .columnType ==
          "Dimensions") {
        for (int inner = 1;
            inner <
                activeFilters[i]
                    .dataSource
                    .columnsList[activeFilters[i].filteredColumn]
                    .cells
                    .length;
            inner++) {
          if (activeFilters[i].isActivatedCells[inner]) {
            trueData.add(new CellModel(
                value: activeFilters[i]
                    .dataSource
                    .columnsList[activeFilters[i].filteredColumn]
                    .cells[inner]
                    .value,
                type: activeFilters[i]
                    .dataSource
                    .columnsList[activeFilters[i].filteredColumn]
                    .cells[inner]
                    .type));
          }
        }
        print("Dimensions");
        print(trueData);
        List<dynamic> trueDataList = new List();
        for (int g = 0; g < trueData.length; g++) {
          trueDataList.add(trueData[g].value);
        }
        if (trueData.isNotEmpty) {
          for (int j = 0;
              j <
                  activeFilters[i]
                      .dataSource
                      .columnsList[activeFilters[i].filteredColumn]
                      .cells
                      .length;
              j++) {
            if (trueDataList.contains(activeFilters[i]
                .dataSource
                .columnsList[activeFilters[i].filteredColumn]
                .cells[j]
                .value)) {
              for (int u = 0;
                  u < activeFilters[i].dataSource.columnsList.length;
                  u++) {
                tempNumbers
                    .add(activeFilters[i].dataSource.columnsList[u].cells[j]);
              }
              allTempsNumbers.add(tempNumbers);
              tempNumbers = [];
            }
          }

          print(allTempsNumbers);
          print(allTempsNumbers.length);
          List<CellModel> tempCells = new List();
          List<List<CellModel>> allTempsCells = new List();
          for (int t = 0; t < allTempsNumbers[0].length; t++) {
            for (int a = 0; a < allTempsNumbers.length; a++) {
              tempCells.add(CellModel(
                  value: allTempsNumbers[a][t].value,
                  type: allTempsNumbers[a][t].type));
            }
            allTempsCells.add(tempCells);
            tempCells = [];
          }
          for (int y = 0; y < allTempsCells.length; y++) {
            tempColumnModels.add(ColumnModel(
                id: activeFilters[i].dataSource.columnsList[y].id,
                name: activeFilters[i].dataSource.columnsList[y].name,
                isDeleted: activeFilters[i].dataSource.columnsList[y].isDeleted,
                columnType:
                    activeFilters[i].dataSource.columnsList[y].columnType,
                valueCategories:
                    activeFilters[i].dataSource.columnsList[y].valueCategories,
                cells: allTempsCells[y]));
          }
          print(tempColumnModels);
          //tempActiveFilters[i].dataSource.columnsList = tempColumnModels;
          filtersWithIDs.addAll({
            i.toString(): new FilterModel(
                id: activeFilters[i].id,
                name: activeFilters[i].name,
                type: activeFilters[i].type,
                isActivatedCells: activeFilters[i].isActivatedCells,
                textEditingController: activeFilters[i].textEditingController,
                dataSource: activeFilters[i].dataSource,
                initValue: activeFilters[i].initValue,
                isActive: activeFilters[i].isActive,
                filteredColumn: activeFilters[i].filteredColumn,
                dataSourceID: activeFilters[i].dataSourceID,
                isDeleted: activeFilters[i].isDeleted),
          });
          columnsWithIDs.addAll({i.toString(): tempColumnModels});
          for (int q = 0;
              q < tempActiveFilters[i].dataSource.columnsList[0].cells.length;
              q++) {
            print(tempActiveFilters[i].dataSource.columnsList[0].cells[q]);
          }
          allTempsNumbers = [];
          trueData = [];
          tempColumnModels = [];
          setState(() {});
        }
      }
    }
    List<FilterModel> doneFilters = new List();
    List<List<ColumnModel>> doneColumns = new List();
    List<int> filtersIDs = new List();
    List<int> columnsIDs = new List();

    filtersWithIDs.forEach((data, value) {
      doneFilters.insert(int.parse(data), value);
//      doneFilters.add(value);
      filtersIDs.add(int.parse(data));
    });
    columnsWithIDs.forEach((data, value) {
      doneColumns.insert(int.parse(data), value);
//      doneColumns.add(value);
      columnsIDs.add(int.parse(data));
    });

    for(int i = 0 ; i < visualizerModel.filtersModel.length; i++){
      if(!filtersIDs.contains(doneFilters.indexOf(visualizerModel.filtersModel[i]))){
        print(i);
        doneFilters.insert(i, visualizerModel.filtersModel[i]);
        doneColumns.insert(i, visualizerModel.filtersModel[i].dataSource.columnsList);
      }
    }
    for(int i = 0 ; i < doneFilters.length ; i++){
      doneFilters[i].dataSource.columnsList = doneColumns[i];
    }
    filteredTableModel = goAndMakeNewTableModel(tempActiveFilters);
  }

  TableModel goAndMakeNewTableModel(List<FilterModel> activeFilters) {
    TableModel tableModel;

    return tableModel;
  }
}
//visualizerModel.filtersModel[index].dataSource.listColumns[visualizerModel.filtersModel[index].filteredColumn].columnType
