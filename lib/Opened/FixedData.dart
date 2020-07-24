import 'package:eyedatai/Classes/VisualizerModel.dart';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class FixedData extends StatefulWidget {
  VisualizerModel visualizerModel;

  FixedData(this.visualizerModel);

  @override
  _FixedDataState createState() => _FixedDataState(visualizerModel);
}

class _FixedDataState extends State<FixedData> {
  VisualizerModel visualizerModel;
  List<List<dynamic>> data = [];

  _FixedDataState(this.visualizerModel);

  @override
  void initState() {
    super.initState();
    List<dynamic> row = new List();
    for (int j = 0;
    j < visualizerModel.dataSource.columnsList[0].cells.length;
    j++) {
      for (int i = 0; i < visualizerModel.dataSource.columnsList.length; i++) {
        row.add(visualizerModel.dataSource.columnsList[i].cells[j].value);
      }
      data.add(row);
      row = [];
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
              visualizerModel.visualizerName,
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
                  print(item[0]);
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
                children: visualizerModel.chartData.fixedData.map((item) {
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
