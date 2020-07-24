import 'package:eyedatai/Classes/FilterModel.dart';
import 'package:eyedatai/Classes/VisualizerModel.dart';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../DataI.dart';
import '../FontClass.dart';

class FilterOpened extends StatefulWidget {
  FilterModel filterModel;
  List<VisualizerModel> visualizers = new List();

  FilterOpened(this.filterModel, this.visualizers);

  @override
  _FilterOpenedState createState() =>
      _FilterOpenedState(filterModel, visualizers);
}

class _FilterOpenedState extends State<FilterOpened> {
  TextEditingController nameController = new TextEditingController();
  FilterModel filterModel;
  List<VisualizerModel> visualizers = new List();

  //
  String dataSourceValue;

  //
  String currColumnType;
  List<String> columnType = ["Dimensions", "Measures"];

  //
  String currColumn;
  List<String> columns = new List();

  //
  String currType;
  List<String> types = ["MultipleEquality", "<", ">"];

  _FilterOpenedState(this.filterModel, this.visualizers);

  @override
  void initState() {
    super.initState();
    dataSourceValue = filterModel.dataSource.name;
    currColumnType = filterModel
        .dataSource.columnsList[filterModel.filteredColumn].columnType;
    currType = filterModel.type;
    currColumn =
        filterModel.dataSource.columnsList[filterModel.filteredColumn].name;
    nameController.text = filterModel.name;

    columns = [];
    for (int i = 0; i < filterModel.dataSource.columnsList.length; i++) {
      if (currColumnType == "Measures") {
        print(i);
        if (filterModel.dataSource.columnsList[i].columnType == "Measures") {
          columns.add(filterModel.dataSource.columnsList[i].name);
        }
      } else if (currColumnType == "Dimensions") {
        if (filterModel.dataSource.columnsList[i].columnType == "Dimensions") {
          columns.add(filterModel.dataSource.columnsList[i].name);
        }
      }
    }
    print(currColumn);
    print(columns);
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
              "${filterModel.name}",
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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
              title: Text(
                "name",
                style: TextStyle(
                    color: ColorClass.fontColor,
                    fontFamily: FontClass.appFont,
                    fontSize: 15),
              ),
              trailing: Container(
                height: 40.00,
                width: 150.00,
                color: ColorClass.filterContainerColor,
                child: Center(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 4.0),
                      child: new TextField(
                        onChanged: (value) {
                          for (int i = 0; i < visualizers.length; i++) {
                            for (int j = 0;
                            j < visualizers[i].filtersModel.length;
                            j++) {
                              if (visualizers[i].filtersModel[j].id ==
                                  filterModel.id) {
                                setState(() {
                                  visualizers[i].filtersModel[j].name =
                                      nameController.text.trim();
                                  filterModel.name = nameController.text.trim();
                                });
                              }
                            }
                          }
                          DataI.setNewVisualizers(visualizers, true);
                        },
                        style: TextStyle(
                            color: ColorClass.fontColor,
                            fontFamily: FontClass.appFont,
                            fontSize: 12),
                        textAlign: TextAlign.left,
                        controller: nameController,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: FontClass.appFont,
                              fontSize: 12),
                          hintText: 'Filter Name',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
              title: Text(
                "data source",
                style: TextStyle(
                    color: ColorClass.fontColor,
                    fontFamily: FontClass.appFont,
                    fontSize: 15),
              ),
              trailing: Container(
                height: 40.00,
                width: 150.00,
                color: ColorClass.filterContainerColor,
                child: Center(
                    child: Text(
                      filterModel.dataSource.name,
                      style: TextStyle(
                          color: ColorClass.fontColor,
                          fontFamily: FontClass.appFont,
                          fontSize: 15),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
              title: Text(
                "column type",
                style: TextStyle(
                    color: ColorClass.fontColor,
                    fontFamily: FontClass.appFont,
                    fontSize: 15),
              ),
              trailing: Container(
                height: 40.00,
                width: 150.00,
                color: ColorClass.filterContainerColor,
                child: Center(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          canvasColor: ColorClass.scaffoldBackgroundColor),
                      child: DropdownButton(
                          hint: Text(
                            currColumnType,
                            style: TextStyle(
                                color: ColorClass.fontColor,
                                fontFamily: FontClass.appFont),
                          ),
                          value: currColumnType,
                          underline: Container(
                            color: ColorClass.filterContainerColor,
                          ),
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: ColorClass.fontColor, size: 20),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (val) {
                            bool yesEqual = false;
                            currColumnType == val
                                ? yesEqual = true
                                : yesEqual = false;
                            setState(() {
                              currColumnType = val;

                            });

                            List<String> tempColumns = new List();
                            for (int i = 0; i < columns.length; i++) {
                              tempColumns.add(columns[i]);
                            }
                            for (int i = 0;
                            i < filterModel.dataSource.columnsList.length;
                            i++) {
                              if (currColumnType == "Measures") {
                                if (filterModel
                                    .dataSource.columnsList[i].columnType ==
                                    "Measures" &&
                                    !columns.contains(filterModel
                                        .dataSource.columnsList[i].name)) {
                                  columns.add(
                                      filterModel.dataSource.columnsList[i].name);
                                }
                              } else if (currColumnType == "Dimensions") {
                                if (filterModel
                                    .dataSource.columnsList[i].columnType ==
                                    "Dimensions" &&
                                    !columns.contains(filterModel
                                        .dataSource.columnsList[i].name)) {
                                  columns.add(
                                      filterModel.dataSource.columnsList[i].name);
                                }
                              }
                            }
                            print(columns);
                            if (!yesEqual) {
                              for (int i = 0; i < tempColumns.length; i++) {
                                if (columns.contains(tempColumns[i])) {
                                  columns.remove(tempColumns[i]);
                                }
                              }
                            }
                            print(columns);
                            currColumn = columns[0];
                            int filteredColumn;
                            for (int i = 0;
                            i < filterModel.dataSource.columnsList.length;
                            i++) {
                              if (filterModel.dataSource.columnsList[i].name ==
                                  columns[0]) {
                                filteredColumn =
                                    filterModel.dataSource.columnsList[i].id;
                              }
                            }
                            for (int i = 0; i < visualizers.length; i++) {
                              for (int j = 0;
                              j < visualizers[i].filtersModel.length;
                              j++) {
                                if (visualizers[i].filtersModel[j].id ==
                                    filterModel.id) {
                                  setState(() {
                                    visualizers[i].filtersModel[j].type =
                                        currColumnType;
                                    visualizers[i].filtersModel[j].filteredColumn =
                                        filteredColumn;
                                  });
                                }
                              }
                            }
                            //filterModel.dataSource.columnsList[filterModel.filteredColumn].columnType = currColumnType;
                          },
                          items: List.generate(columnType.length, (index) {
                            return DropdownMenuItem(
                              child: Text(
                                columnType[index],
                                style: TextStyle(
                                    color: currColumnType == columnType[index]
                                        ? ColorClass.fontColor
                                        : Colors.grey,
                                    fontFamily: FontClass.appFont,
                                    fontSize: 15),
                              ),
                              value: columnType[index],
                            );
                          })),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
              title: Text(
                "column",
                style: TextStyle(
                    color: ColorClass.fontColor,
                    fontFamily: FontClass.appFont,
                    fontSize: 15),
              ),
              trailing: Container(
                height: 40.00,
                width: 150.00,
                color: ColorClass.filterContainerColor,
                child: Center(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          canvasColor: ColorClass.scaffoldBackgroundColor),
                      child: DropdownButton(
                        hint: Text(
                          currColumn,
                          style: TextStyle(
                              color: ColorClass.fontColor,
                              fontFamily: FontClass.appFont),
                        ),
                        value: currColumn,
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: ColorClass.fontColor, size: 20),
                        underline: Container(
                          color: ColorClass.filterContainerColor,
                        ),
                        onChanged: (val) {
                          setState(() {
                            currColumn = val;
                          });
                          print(currColumnType);
                          int filteredColumn;
                          for (int i = 0;
                          i < filterModel.dataSource.columnsList.length;
                          i++) {
                            if (filterModel.dataSource.columnsList[i].name ==
                                currColumn) {
                              filteredColumn =
                                  filterModel.dataSource.columnsList[i].id;
                            }
                          }
                          for (int i = 0; i < visualizers.length; i++) {
                            for (int j = 0;
                            j < visualizers[i].filtersModel.length;
                            j++) {
                              if (visualizers[i].filtersModel[j].id ==
                                  filterModel.id) {
                                setState(() {
                                  visualizers[i].filtersModel[j].type =
                                      currColumnType;
                                  visualizers[i].filtersModel[j].filteredColumn =
                                      filteredColumn;
                                });
                              }
                            }
                          }
                          // filterModel.dataSource.columnsList[filterModel.filteredColumn].name = currColumn;
                        },
                        items: List.generate(columns.length, (index) {
                          return DropdownMenuItem(
                            child: Text(
                              columns[index],
                              style: TextStyle(
                                  color: currColumn == columns[index]
                                      ? ColorClass.fontColor
                                      : Colors.grey,
                                  fontFamily: FontClass.appFont,
                                  fontSize: 15),
                            ),
                            value: columns[index],
                          );
                        }),
                      ),
                    )),
              ),
            ),
          ),
          filterModel.dataSource.columnsList[filterModel.filteredColumn]
              .columnType ==
              "Dimensions"
              ? Container(
            width: 0.0,
            height: 0.0,
          )
              : Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
              title: Text(
                "type",
                style: TextStyle(
                    color: ColorClass.fontColor,
                    fontFamily: FontClass.appFont,
                    fontSize: 15),
              ),
              trailing: Container(
                height: 40.00,
                width: 150.00,
                color: ColorClass.filterContainerColor,
                child: Center(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          canvasColor: ColorClass.scaffoldBackgroundColor),
                      child: DropdownButton(
                        hint: Text(
                          currType,
                          style: TextStyle(
                              color: ColorClass.fontColor,
                              fontFamily: FontClass.appFont),
                        ),
                        value: currType,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: ColorClass.fontColor,
                          size: 20,
                        ),
                        underline: Container(
                          color: ColorClass.filterContainerColor,
                        ),
                        onChanged: (val) {
                          setState(() {
                            currType = val;
                            for (int i = 0; i < visualizers.length; i++) {
                              for (int j = 0;
                              j < visualizers[i].filtersModel.length;
                              j++) {
                                if (visualizers[i].filtersModel[j].id ==
                                    filterModel.id) {
                                  if (currType == "<") {
                                    setState(() {
                                      visualizers[i].filtersModel[j].type =
                                      "<";
                                    });
                                  } else if (currType == ">") {
                                    setState(() {
                                      visualizers[i].filtersModel[j].type =
                                      ">";
                                    });
                                  } else if (currType == "MultipleEquality") {
                                    setState(() {
                                      visualizers[i].filtersModel[j].type =
                                      "MultipleEquality";
                                    });
                                  }
                                }
                              }
                            }
                            DataI.setNewVisualizers(visualizers, true);
                          });
                        },
                        items: List.generate(types.length, (index) {
                          return DropdownMenuItem(
                            child: Text(
                              types[index] == "<"
                                  ? "LessThan"
                                  : types[index] == ">"
                                  ? "GreaterThan"
                                  : types[index],
                              style: TextStyle(
                                  color: currType == types[index]
                                      ? ColorClass.fontColor
                                      : Colors.grey,
                                  fontFamily: FontClass.appFont,
                                  fontSize: 15),
                            ),
                            value: types[index],
                          );
                        }),
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
