import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class FilteredDataSource extends StatefulWidget {
  List<List<dynamic>> data = new List();
  List<List<dynamic>> fixedData = new List();
  int xColumn;

  FilteredDataSource(this.data, this.fixedData, this.xColumn);

  @override
  _FilteredDataSourceState createState() =>
      _FilteredDataSourceState(data, fixedData, xColumn);
}

class _FilteredDataSourceState extends State<FilteredDataSource> {
  List<List<dynamic>> data = new List();
  List<List<dynamic>> fixedData = new List();
  int xColumn;

  _FilteredDataSourceState(this.data, this.fixedData, this.xColumn);

  List<dynamic> allTempDataCol = new List();

  @override
  void initState() {
    List<dynamic> tempDataCol = new List();

    for (int i = 0; i < data[0].length; i++) {
      for (int j = 0; j < data.length; j++) {
        tempDataCol.add(data[j][i]);
      }
      allTempDataCol.add(tempDataCol);
      tempDataCol = [];
    }
    print("Filtered Data");
    print(allTempDataCol);
    List<dynamic> tempColumn = new List();

    for (int i = 0; i < allTempDataCol.length; i++) {
      if (i == xColumn) {
        tempColumn = allTempDataCol[i];
        allTempDataCol.remove(allTempDataCol[i]);
      }
    }
    allTempDataCol.insert(0, tempColumn);

    data = [];
    List<dynamic> tempData = new List();
    for (int i = 0; i < allTempDataCol[0].length; i++) {
      for (int j = 0; j < allTempDataCol.length; j++) {
        tempData.add(allTempDataCol[j][i]);
      }
      data.add(tempData);
      tempData = [];
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
              "Filterd DataSource",
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
              padding: const EdgeInsets.only(right: 20.0, top: 25),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 8.0, left: 8.0, right: 8.0),
              child: Table(
                columnWidths: {
                  2: FixedColumnWidth(100.0),
                },
                border: TableBorder.all(width: 0.5),
                children: data.map((item) {
                  print(item.indexOf(item[0]));
                  return TableRow(
                      decoration: BoxDecoration(color: Colors.white),
                      children: item.map((row) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              row.toString(),
                              style: TextStyle(
                                  color: ColorClass.fontColor,
                                  fontFamily: FontClass.appFont,
                                  fontSize: 12),
                            ),
                          ),
                        );
                      }).toList());
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                "--------- Fixed Data ---------",
                style: TextStyle(
                    color: ColorClass.fontColor,
                    fontFamily: FontClass.appFont,
                    fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 8.0, left: 8.0, right: 8.0),
              child: Table(
                columnWidths: {
                  2: FixedColumnWidth(100.0),
                },
                border: TableBorder.all(width: 0.5),
                children: fixedData.map((item) {
                  print(item.indexOf(item[0]));
                  return TableRow(
                      decoration: BoxDecoration(color: Colors.white),
                      children: item.map((row) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              row.toString(),
                              style: TextStyle(
                                  color: ColorClass.fontColor,
                                  fontFamily: FontClass.appFont,
                                  fontSize: 12),
                            ),
                          ),
                        );
                      }).toList());
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
