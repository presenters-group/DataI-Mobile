import 'package:eyedatai/Classes/FilterModel.dart';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class FilterOpened extends StatefulWidget {
  FilterModel filterModel;

  FilterOpened(this.filterModel);

  @override
  _FilterOpenedState createState() => _FilterOpenedState(filterModel);
}

class _FilterOpenedState extends State<FilterOpened> {
  TextEditingController nameController = new TextEditingController();
  FilterModel filterModel;

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
  List<String> types = ["Equality", "LessThan", "GreaterThan", "Categorized"];

  _FilterOpenedState(this.filterModel);

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

    for (int i = 0; i < filterModel.dataSource.columnsList.length; i++) {
      columns.add(filterModel.dataSource.columnsList[i].name);
    }
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
                        onChanged: (value) {},
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
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          canvasColor: ColorClass.scaffoldBackgroundColor),
                      child: DropdownButton(
                          hint: Text(
                            filterModel.dataSource.name,
                            style: TextStyle(
                                color: ColorClass.fontColor,
                                fontFamily: FontClass.appFont),
                          ),
                          onChanged: (val) {
                            setState(() {
                              dataSourceValue = val;
                            });
                          },
                          //value: dataSourceValue,
                          underline: Container(
                            color: ColorClass.filterContainerColor,
                          ),
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: ColorClass.fontColor, size: 20),
                          items: []
                        /*List.generate(
                              filterModel.dataSource.listColumns.length, (index) {
                            return DropdownMenuItem(
                              child: Text(
                                filterModel.dataSource.listColumns[index].name
                                    .toString(),
                                style: TextStyle(
                                    fontFamily: FontClass.appFont,
                                    color: ColorClass.fontColor),
                              ),
                              value:
                                  filterModel.dataSource.listColumns[index].name,
                            );
                          })*/
                      ),
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
                            setState(() {
                              currColumnType = val;
                            });
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
          Padding(
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
                          });
                        },
                        items: List.generate(types.length, (index) {
                          return DropdownMenuItem(
                            child: Text(
                              types[index],
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
