import 'package:eyedatai/Classes/DataSources/CellModel.dart';
import 'package:eyedatai/Classes/DataSources/ColumnModel.dart';
import 'package:eyedatai/Classes/DataSources/TableModel.dart';
import 'package:eyedatai/Classes/FilterModel.dart';
import 'package:eyedatai/Classes/VisualizerModel.dart';
import 'package:eyedatai/Opened/DashboardOpened.dart';
import 'package:eyedatai/Opened/FilteredVisualizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

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

  void applyFilterIcon() {
    int counter = 0;
    for (int i = 0; i < visualizerModel.filtersModel.length; i++) {
      if (visualizerModel.filtersModel[i].isActive = false) {
        counter++;
      }
    }
    if (counter == visualizerModel.filtersModel.length) {
      setState(() {
        isChangedAnyThing = false;
      });
    } else {
      setState(() {
        isChangedAnyThing = true;
      });
    }
  }

  @override
  void initState() {
    int counter = 0;
    for (int i = 0; i < visualizerModel.filtersModel.length; i++) {
      if (!visualizerModel.filtersModel[i].isActive) {
        counter++;
      }
    }
    if (counter == visualizerModel.filtersModel.length) {
      for (int j = 0; j < visualizerModel.filtersModel.length; j++) {
        visualizerModel.filtersModel[j].textEditingController.clear();
      }
      isChangedAnyThing = false;
    } else {
      isChangedAnyThing = true;
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
                                                          if (!visualizerModel
                                                              .filtersModel[
                                                                  indexGrid]
                                                              .isActivatedCells
                                                              .contains(true)) {
                                                            setState(() {
                                                              visualizerModel
                                                                  .filtersModel[
                                                                      indexGrid]
                                                                  .isActive = false;
                                                            });
                                                          }
                                                        });
                                                      },
                                                      value: visualizerModel
                                                              .filtersModel[
                                                                  indexGrid]
                                                              .isActivatedCells[
                                                          index]),
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
                                      isChangedAnyThing = true;
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
                                            "<"
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

                                                    setState(() {
                                                      isChangedAnyThing = true;
                                                      visualizerModel
                                                          .filtersModel[
                                                              indexGrid]
                                                          .isActive = true;
                                                      if (visualizerModel
                                                          .filtersModel[
                                                              indexGrid]
                                                          .textEditingController
                                                          .text
                                                          .isEmpty) {
                                                        setState(() {
                                                          visualizerModel
                                                              .filtersModel[
                                                                  indexGrid]
                                                              .isActive = false;
                                                        });
                                                      }
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
                                                      color:
                                                          ColorClass.fontColor,
                                                      fontFamily:
                                                          FontClass.appFont,
                                                      fontSize: 15),
                                                  textAlign: TextAlign.left,
                                                  controller: visualizerModel
                                                      .filtersModel[indexGrid]
                                                      .textEditingController,
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
            }));
  }

  void doSubmitted() {
    List<FilterModel> activeFilters = new List();
    List<FilterModel> tempActiveFilters = new List();
    List<ColumnModel> tempColumnModels = new List();
    List<CellModel> tempNumbers = new List();
    List<List<CellModel>> allTempsNumbers = new List();
    List<CellModel> trueData = new List();
    List<List<ColumnModel>> tempAllColumns = new List();
    List<int> filtersIDs = new List();

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
          List<CellModel> titles = new List();
          for (int v = 0;
              v < activeFilters[i].dataSource.columnsList.length;
              v++) {
            titles.add(activeFilters[i].dataSource.columnsList[v].cells[0]);
          }

          print("Equality");
          print(titles);
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
            allTempsNumbers.insert(0, titles);
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
            tempAllColumns.add(tempColumnModels);
            filtersIDs.add(activeFilters[i].id);
            for (int q = 0; q < tempColumnModels[2].cells.length; q++) {
              print(tempColumnModels[2].cells[q]);
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
          List<CellModel> titles = new List();
          for (int v = 0;
              v < activeFilters[i].dataSource.columnsList.length;
              v++) {
            titles.add(activeFilters[i].dataSource.columnsList[v].cells[0]);
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
            allTempsNumbers.insert(0, titles);
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
            tempAllColumns.add(tempColumnModels);
            filtersIDs.add(activeFilters[i].id);
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
          List<CellModel> titles = new List();
          for (int v = 0;
              v < activeFilters[i].dataSource.columnsList.length;
              v++) {
            titles.add(activeFilters[i].dataSource.columnsList[v].cells[0]);
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
            allTempsNumbers.insert(0, titles);
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
            tempAllColumns.add(tempColumnModels);
            filtersIDs.add(activeFilters[i].id);
            for (int q = 0; q < tempColumnModels[0].cells.length; q++) {
              print(tempColumnModels[0].cells[q]);
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

        List<CellModel> titles = new List();
        for (int v = 0;
            v < activeFilters[i].dataSource.columnsList.length;
            v++) {
          titles.add(activeFilters[i].dataSource.columnsList[v].cells[0]);
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
          allTempsNumbers.insert(0, titles);
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
          tempAllColumns.add(tempColumnModels);
          print("filterId : ${activeFilters[i].id}");

          filtersIDs.add(activeFilters[i].id);

          for (int q = 0; q < tempColumnModels[0].cells.length; q++) {
            print(tempColumnModels[0].cells[q]);
          }
          allTempsNumbers = [];
          trueData = [];
          tempColumnModels = [];
          setState(() {});
        }
      }
    }

    //
    if (tempAllColumns.length > 0) {
      print(filtersIDs.toList());
      for (int i = 0; i < visualizerModel.filtersModel.length; i++) {
        if (!filtersIDs.contains(i)) {
          print(visualizerModel.filtersModel[i].name);
          tempAllColumns.insert(
              i, visualizerModel.filtersModel[i].dataSource.columnsList);
        }
      }

      for (int i = 0; i < tempAllColumns.length; i++) {
        tempAllColumns
            .sort((a, b) => a[i].cells.length.compareTo(b[i].cells.length));
      }

      List<dynamic> firstListValues = new List();
      List<List<dynamic>> allFirstValues = new List();

      List<List<List<dynamic>>> allDataValues = new List();
      List<List<dynamic>> subDataValues = new List();
      List<dynamic> subOfSubValues = new List();

      //Convert Cells Data To Normal Data
      for (int i = 0; i < tempAllColumns[0][0].cells.length; i++) {
        for (int j = 0; j < tempAllColumns[0].length; j++) {
          firstListValues.add(tempAllColumns[0][j].cells[i].value);
        }
        allFirstValues.add(firstListValues);
        firstListValues = [];
      }

      for (int i = 1; i < tempAllColumns.length; i++) {
        for (int j = 0; j < tempAllColumns[i][0].cells.length; j++) {
          for (int k = 0; k < tempAllColumns[i].length; k++) {
            subOfSubValues.add(tempAllColumns[i][k].cells[j].value);
          }
          subDataValues.add(subOfSubValues);
          subOfSubValues = [];
        }
        allDataValues.add(subDataValues);
        subDataValues = [];
      }

      print(allFirstValues);
      print(allDataValues);
      List<bool> isRepeatedItem = new List();
      List<List<bool>> isRepeatedAll = new List();
      List<int> trueIDs = new List();
      List<List<dynamic>> trueListCells = new List();

      //Check Common Data
      for (int i = 0; i < allFirstValues.length; i++) {
        for (int j = 0; j < allDataValues.length; j++) {
          for (int k = 0; k < allDataValues[j].length; k++) {
            if (areListsEqual(allFirstValues[i], allDataValues[j][k])) {
              isRepeatedItem.add(true);
            }
          }
        }
        isRepeatedAll.add(isRepeatedItem);
        isRepeatedItem = [];
      }

      print(isRepeatedAll);

      //Catch Common Data
      for (int i = 0; i < isRepeatedAll.length; i++) {
        if (isRepeatedAll[i].length == allDataValues.length) {
          trueIDs.add(i);
        }
      }

      print(trueIDs);
      //Add Common Data
      for (int i = 0; i < allFirstValues.length; i++) {
        if (trueIDs.contains(i)) {
          trueListCells.add(allFirstValues[i]);
        }
      }

      print(trueListCells);

      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) =>
                  new FilteredVisualizer(trueListCells, visualizerModel)));
    } else {
      Toast.show("No Data Matching With Those Filters", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.black,
          textColor: ColorClass.containerColor);
    }
  }

  bool areListsEqual(var firstList, var secondList) {
    if (!(firstList is List && secondList is List) ||
        firstList.length != secondList.length) {
      return false;
    }
    for (int i = 0; i < firstList.length; i++) {
      if (firstList[i] != secondList[i]) {
        return false;
      }
    }
    return true;
  }
}
