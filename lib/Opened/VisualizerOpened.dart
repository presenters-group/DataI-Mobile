import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class VisualizerOpened extends StatefulWidget {
  var titleVisualizer;

  VisualizerOpened(this.titleVisualizer);

  @override
  _VisualizerOpenedState createState() =>
      _VisualizerOpenedState(titleVisualizer);
}

class _VisualizerOpenedState extends State<VisualizerOpened>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  var titleVisualizer;

  _VisualizerOpenedState(this.titleVisualizer);

  @override
  void initState() {
    tabController = new TabController(length: 3, vsync: this);
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
              titleVisualizer,
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
        children: <Widget>[Container(), Container(), Container()],
      ),
    );
  }
}
