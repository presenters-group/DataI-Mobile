import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class FilteredDataSource extends StatefulWidget {
  List<List<dynamic>> data = new List();

  FilteredDataSource(this.data);

  @override
  _FilteredDataSourceState createState() => _FilteredDataSourceState(data);
}

class _FilteredDataSourceState extends State<FilteredDataSource> {
  List<List<dynamic>> data = new List();

  _FilteredDataSourceState(this.data);

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
              child:Container(
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
}
