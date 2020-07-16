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
                                                              isChangedAnyThing =
                                                                  true;
                                                              bools[indexGrid]
                                                                  [index] = val;
                                                              //visualizerModel.filtersModel[index].isActivatedCells[index] = val;
                                                            });
                                                          },
                                                          value: bools[
                                                                  indexGrid][
                                                              index] //visualizerModel.filtersModel[index].isActivatedCells[index],
                                                          ),
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
    List<ColumnModel> tempColumnModels = new List();
    TableModel filteredTableModel;
    List<CellModel> tempNumbers = new List();
    List<List<CellModel>> allTempsNumbers = new List();
    List<CellModel> trueData = new List();

    for (int i = 0; i < visualizerModel.filtersModel.length; i++) {
      if (visualizerModel.filtersModel[i].isActive) {
        activeFilters.add(visualizerModel.filtersModel[i]);
      }
    }

    print("*****");
    print(activeFilters.length);

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
                id: activeFilters[i].dataSource.columnsList[i].id,
                name: activeFilters[i].dataSource.columnsList[i].name,
                isDeleted: activeFilters[i].dataSource.columnsList[i].isDeleted,
                columnType:
                    activeFilters[i].dataSource.columnsList[i].columnType,
                valueCategories:
                    activeFilters[i].dataSource.columnsList[i].valueCategories,
                cells: allTempsCells[y]));
          }
          activeFilters[i].dataSource.columnsList = tempColumnModels;

          for (int q = 0;
              q < activeFilters[i].dataSource.columnsList[0].cells.length;
              q++) {
            print(activeFilters[i].dataSource.columnsList[0].cells[q]);
          }

          allTempsNumbers = [];
          trueData = [];
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
                id: activeFilters[i].dataSource.columnsList[i].id,
                name: activeFilters[i].dataSource.columnsList[i].name,
                isDeleted: activeFilters[i].dataSource.columnsList[i].isDeleted,
                columnType:
                    activeFilters[i].dataSource.columnsList[i].columnType,
                valueCategories:
                    activeFilters[i].dataSource.columnsList[i].valueCategories,
                cells: allTempsCells[y]));
          }
          activeFilters[i].dataSource.columnsList = tempColumnModels;

          for (int q = 0;
              q < activeFilters[i].dataSource.columnsList[0].cells.length;
              q++) {
            print(activeFilters[i].dataSource.columnsList[0].cells[q]);
          }

          allTempsNumbers = [];
          trueData = [];
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
                id: activeFilters[i].dataSource.columnsList[i].id,
                name: activeFilters[i].dataSource.columnsList[i].name,
                isDeleted: activeFilters[i].dataSource.columnsList[i].isDeleted,
                columnType:
                    activeFilters[i].dataSource.columnsList[i].columnType,
                valueCategories:
                    activeFilters[i].dataSource.columnsList[i].valueCategories,
                cells: allTempsCells[y]));
          }
          activeFilters[i].dataSource.columnsList = tempColumnModels;

          for (int q = 0;
              q < activeFilters[i].dataSource.columnsList[0].cells.length;
              q++) {
            print(activeFilters[i].dataSource.columnsList[0].cells[q]);
          }

          allTempsNumbers = [];
          trueData = [];
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
          } else {}
        }
      }
    }
    goAndMakeNewTableModel(activeFilters);
  }

  void goAndMakeNewTableModel(List<FilterModel> activeFilters) {}
}
//visualizerModel.filtersModel[index].dataSource.listColumns[visualizerModel.filtersModel[index].filteredColumn].columnType
