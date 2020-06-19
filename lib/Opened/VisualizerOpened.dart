import 'package:eyedatai/Classes/AggregateData.dart';
import 'package:eyedatai/Classes/DataSources/TableModel.dart';
import 'package:eyedatai/Classes/SeriesData.dart';
import 'package:eyedatai/Classes/VisualizerModel.dart';
import 'package:eyedatai/Opened/Charts/BarChart.dart';
import 'package:eyedatai/Opened/Charts/LineChart.dart';
import 'package:eyedatai/Opened/Charts/PieChart.dart';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class VisualizerOpened extends StatefulWidget {
  VisualizerModel visualizer;

  VisualizerOpened(this.visualizer);

  @override
  _VisualizerOpenedState createState() => _VisualizerOpenedState(visualizer);
}

class _VisualizerOpenedState extends State<VisualizerOpened>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  VisualizerModel visualizer;
  AggregateData aggregateData;

  _VisualizerOpenedState(this.visualizer);

  @override
  void initState() {
    tabController = new TabController(length: 3, vsync: this);
    aggregateData = AggregateData.fromVisualizer(
        visualizer.columnsModel, visualizer.xColumn);

    /*aggregateDataLine = AggregateData.fromVisualizer(
        visualizer.columnsModel, "LineChart", visualizer.xColumn);
    aggregateDataPie = AggregateData.fromVisualizer(
        visualizer.columnsModel, "PieChart", visualizer.xColumn);
*/
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
              visualizer.visualizerName,
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
              padding: const EdgeInsets.only(right: 15.0, top: 27),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('Images/Filter.png'))),
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
                  Icons.show_chart,
                  size: 27,
                ),
                Icon(
                  Icons.pie_chart,
                  size: 27,
                ),
              ]),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                  List.generate(visualizer.columnsModel.length, (index) {
                    return visualizer.columnsModel[index].id ==
                        visualizer.xColumn
                        ? Container(
                      width: 0.0,
                      height: 0.0,
                    )
                        : Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            width: 20,
                            height: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: visualizer.columnsModel[index]
                                    .columnStyleMode.color),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            visualizer.columnsModel[index].name
                                .toString(),
                            style: TextStyle(
                                fontSize: 12,
                                color: ColorClass.fontColor,
                                fontFamily: FontClass.appFont),
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BarChart(visualizer.aggregateData.seriesDataBar),
                  )),
            ],
          ),
          PieChart(visualizer.aggregateData.seriesDataPie),
          Container(),

//          LineChart(aggregateDataLine.seriesData),
        ],
      ),
    );
  }
}
