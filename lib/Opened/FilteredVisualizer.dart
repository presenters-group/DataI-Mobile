import 'package:eyedatai/Classes/SeriesData.dart';
import 'package:eyedatai/Classes/VisualizerModel.dart';
import 'package:eyedatai/Opened/Charts/BarChart.dart';
import 'package:eyedatai/Opened/Charts/PieChart.dart';
import 'package:eyedatai/Opened/FilteredDataSource.dart';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

// ignore: must_be_immutable
class FilteredVisualizer extends StatefulWidget {
  List<List<dynamic>> data = new List();
  VisualizerModel visualizerModel;

  FilteredVisualizer(this.data, this.visualizerModel);

  @override
  _FilteredVisualizerState createState() =>
      _FilteredVisualizerState(data, visualizerModel);
}

class _FilteredVisualizerState extends State<FilteredVisualizer>
    with SingleTickerProviderStateMixin {
  List<List<dynamic>> data = new List();
  VisualizerModel visualizerModel;

  _FilteredVisualizerState(this.data, this.visualizerModel);

  TabController tabController;
  int width;
  List<List<SeriesData>> dataBarChart = new List();
  List<SeriesData> dataBarChartSingle = new List();
  List<SeriesData> dataPieChart = new List();
  List<List<SeriesData>> dataLineChart = new List();
  List<SeriesData> dataLineChartSingle = new List();
  List<dynamic> titlesBarChart = new List();
  List<dynamic> colorsBarChart = new List();
  List<List<dynamic>> fixedData = new List();

  int getWidth(data) {
    int width = 0;
    List<dynamic> listOfWidths = new List();
    for (List<dynamic> list in data) {
      listOfWidths.add(list.length);
    }
    width = listOfWidths.reduce((curr, next) => curr > next ? curr : next);
    return width;
  }

  void getDataChart() {
    dataBarChart = [];
    dataBarChartSingle = [];
    dataPieChart = [];
    dataLineChart = [];
    dataLineChartSingle = [];
    titlesBarChart = [];
    colorsBarChart = [];
    fixedData = [];

    List<dynamic> tempDataCol = new List();
    List<dynamic> allTempDataCol = new List();

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
      if (i == visualizerModel.xColumn) {
        tempColumn = allTempDataCol[i];
        allTempDataCol.remove(allTempDataCol[i]);
      }
    }
    allTempDataCol.insert(0, tempColumn);

    print("After editing");
    print(allTempDataCol);
    width = getWidth(allTempDataCol);
    for (int j = 1; j <= allTempDataCol.length - 1; j++) {
      titlesBarChart.add(allTempDataCol[j][0]);
    }

    print(titlesBarChart);
    List<dynamic> tempData = new List();
    for (int i = 0; i < allTempDataCol[0].length; i++) {
      for (int j = 0; j < allTempDataCol.length; j++) {
        tempData.add(allTempDataCol[j][i]);
      }
      fixedData.add(tempData);
      tempData = [];
    }
    print(fixedData);
    print("width : $width");
    for (int j = 1; j <= allTempDataCol.length - 1; j++) {
      for (int i = 1; i < fixedData.length; i++) {
        if (width == 2) {
          dataBarChartSingle.add(
            new SeriesData(
                task: fixedData[i][0],
                taskValue: int.parse(fixedData[i][j].toString().trim()),
                taskColor: visualizerModel.dataSource.columnsColors[i]),
          );
        } else {
          dataBarChartSingle.add(
            new SeriesData(
                task: fixedData[i][0],
                taskValue: int.parse(fixedData[i][j].toString().trim()),
                taskColor: visualizerModel.dataSource.columnsColors[j]),
          );
        }
      }
      colorsBarChart.add(visualizerModel.dataSource.columnsColors[j]);
      dataBarChart.add(dataBarChartSingle);
      dataBarChartSingle = [];
    }

    List<dynamic> sumRows = new List();
    List<List<dynamic>> listRows = new List();
    List<dynamic> sumRow = new List();

    List<dynamic> titles = new List();
    titles = fixedData[0];
    print("titiles :   $titles");
    List<List<dynamic>> middleDataPie = new List();
    List<List<List<dynamic>>> hardDataPie = new List();

    for (int j = 1; j < fixedData.length; j++) {
      for (int k = 1; k < fixedData.length; k++) {
        if (fixedData[j][0] == fixedData[k][0]) {
          middleDataPie.add(fixedData[k]);
        }
      }
      hardDataPie.add(middleDataPie);
      middleDataPie = [];
      fixedData.removeAt(j);
    }
    print(hardDataPie);

    int sum = 0;
    List<dynamic> lowerData = new List();
    List<List<dynamic>> fixedDataPie = new List();
    for (int i = 0; i < hardDataPie.length; i++) {
      for (int j = 1; j < hardDataPie[i][0].length; j++) {
        for (int k = 0; k < hardDataPie[i].length; k++) {
          if (lowerData.isEmpty) {
            lowerData.add(hardDataPie[i][k][0]);
          }
          sum += hardDataPie[i][k][j];
        }
        lowerData.add(sum);
        sum = 0;
      }
      if (fixedDataPie.isEmpty) {
        fixedDataPie.add(titles);
        fixedDataPie.add(lowerData);
        lowerData = [];
      } else {
        fixedDataPie.add(lowerData);
        lowerData = [];
      }
    }
    print("fixedDataPie");
    print(fixedDataPie);

    for (int i = 1; i < fixedDataPie.length; i++) {
      for (int j = 1; j <= allTempDataCol.length - 1; j++) {
        sumRow.add(fixedDataPie[i][j]);
      }
      listRows.add(sumRow);
      print(sumRow);
      sumRow = new List();
    }
    print(listRows);
    for (int i = 0; i < listRows.length; i++) {
      sumRows.add(listRows[i].reduce((a, b) => a + b));
    }
    print(sumRows);
    ColorClass colorClass = new ColorClass();
    List<Color> colors = colorClass.generateColors();
    for (int i = 0; i < visualizerModel.dataSource.columnsColors.length; i++) {
      colors.insert(
          i,
          visualizerModel
              .dataSource.columnsColors[i]); //colM[i].columnStyleMode.color
    }
    for (int i = 1; i < fixedDataPie.length; i++) {
      dataPieChart.add(new SeriesData(
          task: fixedDataPie[i][0],
          taskValue: sumRows[i - 1],
          taskColor: colors[i]));
    }
  }

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    getDataChart();
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
              "Filterd Visualizer",
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
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              new FilteredDataSource(fixedData)));
                },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('Images/table.png'))),
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
      bottomNavigationBar: Material(
        child: Container(
          color: ColorClass.scaffoldBackgroundColor,
          child: TabBar(
              unselectedLabelColor: Colors.black,
              controller: tabController,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              indicatorWeight: 4,
              tabs: [
                Icon(
                  Icons.insert_chart,
                  size: 27,
                ),
                Icon(
                  Icons.pie_chart,
                  size: 27,
                ),
              ]),
        ),
      ),
      body: TabBarView(controller: tabController, children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(titlesBarChart.length, (index) {
                  return Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 20,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: colorsBarChart[index]),

                          //columnsModel[index]
                          //                                    .columnStyleMode.color
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          titlesBarChart[index].toString(),
                          style: TextStyle(
                              fontSize: 12,
                              color: ColorClass.fontColor,
                              fontFamily: FontClass.appFont),
                        ),
                      )
                    ],
                  );
                }))),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BarChart(dataBarChart),
            )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PieChart(dataPieChart),
        ),
      ]),
    );
  }
}
