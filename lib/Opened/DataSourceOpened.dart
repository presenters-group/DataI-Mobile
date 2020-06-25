import 'package:eyedatai/Classes/DataSources/TableModel.dart';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class DataSourceOpened extends StatefulWidget {
  TableModel tableModel;

  DataSourceOpened(this.tableModel);

  @override
  _DataSourceOpenedState createState() => _DataSourceOpenedState(tableModel);
}

class _DataSourceOpenedState extends State<DataSourceOpened> {
  TableModel tableModel;
  List<List<dynamic>> data = [];

  _DataSourceOpenedState(this.tableModel);

  @override
  void initState() {
    super.initState();
    List<dynamic> row = new List();
    for (int j = 0; j < tableModel.columnsList[0].cells.length; j++) {
      for (int i = 0; i < tableModel.columnsList.length; i++) {
        row.add(tableModel.columnsList[i].cells[j].value);
      }
      data.add(row);
      row = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              tableModel.name,
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
      body: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 8.0, left: 8.0, right: 8.0),
        child: Table(
          columnWidths: {
            2: FixedColumnWidth(100.0),
          },
          border: TableBorder.all(width: 0.5),
          children: data.map((item) {
            print(item.indexOf(item[0]));
            //print('i : ${item.indexOf(item[(tableModel.listColumns.length - 1) - item.indexOf(item)])}');
            return TableRow(

//                decoration: BoxDecoration(
//                    color: int.parse(item.indexOf(item[i]).toString()) == 0
//                        ? tableModel.listColumns[0].columnStyleMode.color
//                        : tableModel.listColumns[1].columnStyleMode.color),

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
    );
  }

  Color gerColor(data) {}
}
