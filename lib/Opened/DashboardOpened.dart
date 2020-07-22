import 'package:eyedatai/Classes/DashboardModel.dart';
import 'package:eyedatai/Classes/VisualizerModel.dart';
import 'package:eyedatai/Opened/Charts/LineChart.dart';
import 'package:eyedatai/Opened/Charts/PieChart.dart';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';
import 'Charts/BarChart.dart';
import 'FiltersOnVisualizer.dart';

// ignore: must_be_immutable
class DashboardOpened extends StatefulWidget {
  DashboardModel dashboard;

  DashboardOpened(this.dashboard);

  /* setNewVisualizer(int index , VisualizerModel visualizerModel){
    dashboard.visualizersList[index] = visualizerModel;
  }*/

  @override
  _DashboardOpenedState createState() => _DashboardOpenedState(dashboard);
}

class _DashboardOpenedState extends State<DashboardOpened> {
  DashboardModel dashboard;

  _DashboardOpenedState(this.dashboard);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              dashboard.name,
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
      body: ListView.builder(
          itemCount: dashboard.visualizersList.length,
          itemBuilder: (BuildContext context, int indexList) {
            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 25.0, left: 15.0, right: 16.0),
                  child: Container(
                    height: 402.0,
                    width: MediaQuery.of(context).size.width,
                    color: null,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      dashboard.visualizersList[indexList]
                                          .isBar = true;
                                      dashboard.visualizersList[indexList]
                                              .isLine =
                                          dashboard.visualizersList[indexList]
                                              .isPie = false;
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: dashboard
                                            .visualizersList[indexList].isBar
                                        ? BoxDecoration(color: Colors.white)
                                        : null,
                                    child: Icon(
                                      Icons.insert_chart,
                                      size: 27,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      dashboard.visualizersList[indexList]
                                          .isPie = true;
                                      dashboard.visualizersList[indexList]
                                              .isLine =
                                          dashboard.visualizersList[indexList]
                                              .isBar = false;
                                    });
                                  },
                                  child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: dashboard
                                              .visualizersList[indexList].isPie
                                          ? BoxDecoration(color: Colors.white)
                                          : null,
                                      child: Icon(Icons.pie_chart, size: 25)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      dashboard.visualizersList[indexList]
                                          .isLine = true;
                                      dashboard.visualizersList[indexList]
                                              .isBar =
                                          dashboard.visualizersList[indexList]
                                              .isPie = false;
                                    });
                                  },
                                  child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: dashboard
                                              .visualizersList[indexList].isLine
                                          ? BoxDecoration(color: Colors.white)
                                          : null,
                                      child: Icon(Icons.show_chart, size: 27)),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  new FiltersOnVisualizer(
                                                      dashboard.visualizersList[
                                                          indexList])));
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'Images/Filter.png'))),
                                    ),
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, right: 8.0),
                                  child: Text(
                                    "(${dashboard.visualizersList[indexList].visualizerName})",
                                    style: TextStyle(
                                        color: ColorClass.fontColor,
                                        fontFamily: FontClass.appFont,
                                        fontSize: 12),
                                  )),
                            ],
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 53.0, bottom: 25.0, left: 15.0, right: 15.0),
                  child: Container(
                    height: 365.00,
                    width: MediaQuery.of(context).size.width,
                    color: ColorClass.containerColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: dashboard.visualizersList[indexList].isBar
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        dashboard.visualizersList[indexList]
                                            .columnsModel.length, (index) {
                                      return dashboard
                                                  .visualizersList[indexList]
                                                  .columnsModel[index]
                                                  .id ==
                                              dashboard
                                                  .visualizersList[indexList]
                                                  .xColumn
                                          ? Container(
                                              width: 0.0,
                                              height: 0.0,
                                            )
                                          : Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Container(
                                                    width: 20,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.rectangle,
                                                        color: dashboard
                                                                .visualizersList[
                                                                    indexList]
                                                                .dataSource
                                                                .columnsColors[
                                                            index]),
//                                              .columnsModel[index]
//                                          .columnStyleMode
//                                          .color
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    dashboard
                                                        .visualizersList[
                                                            indexList]
                                                        .columnsModel[index]
                                                        .name
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: ColorClass
                                                            .fontColor,
                                                        fontFamily:
                                                            FontClass.appFont),
                                                  ),
                                                )
                                              ],
                                            );
                                    }),
                                  ),
                                ),
                                Expanded(
                                  child: BarChart(dashboard
                                      .visualizersList[indexList]
                                      .chartData
                                      .seriesDataBar),
                                )
                              ],
                            )
                          : dashboard.visualizersList[indexList].isPie
                              ? PieChart(dashboard.visualizersList[indexList]
                                  .chartData.seriesDataPie)
                              : dashboard.visualizersList[indexList].chartData
                                      .seriesDataLine.isEmpty
                                  ? Container(
                                      width: 100,
                                      height: 50,
                                      child: Center(
                                        child: Text("We Have A String Here !",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: FontClass.appFont)),
                                      ),
                                      color: ColorClass.fontColor,
                                    )
                                  : LineChart(dashboard
                                      .visualizersList[indexList]
                                      .chartData
                                      .seriesDataLine),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
