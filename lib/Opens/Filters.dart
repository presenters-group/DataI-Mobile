import 'package:eyedatai/Classes/FilterModel.dart';
import 'package:eyedatai/Opened/FilterOpened.dart';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class Filters extends StatefulWidget {
  List<FilterModel> filters = new List();

  Filters({@required this.filters});

  @override
  _FiltersState createState() => _FiltersState(filters);
}

class _FiltersState extends State<Filters> {
  List<FilterModel> filters = new List();

  _FiltersState(this.filters);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              "Filters",
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
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: ColorClass.scaffoldBackgroundColor,
          elevation: 0.0,
        ),
      ),
      backgroundColor: ColorClass.scaffoldBackgroundColor,
      body: ListView.builder(
          itemCount: filters.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 8.0, left: 25.0, right: 25.0),
              child: new Container(
                height: 160.00, //175
                width: MediaQuery.of(context).size.width,
                color: ColorClass.containerColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  new FilterOpened(filters[index])));
                    },
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Text("Name : ${filters[index].name}",
                                  style: TextStyle(
                                      color: ColorClass.fontColor,
                                      fontFamily: FontClass.appFont,
                                      fontSize: 17)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  "Data sources : ${filters[index].dataSourceID}",
                                  style: TextStyle(
                                      color: ColorClass.subTitleColor,
                                      fontFamily: FontClass.appFont,
                                      fontSize: 15)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  "Filtering Type : ${filters[index].type}",
                                  style: TextStyle(
                                      color: ColorClass.subTitleColor,
                                      fontFamily: FontClass.appFont,
                                      fontSize: 15)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  "Column : ${filters[index].filteredColumn}",
                                  style: TextStyle(
                                      color: ColorClass.subTitleColor,
                                      fontFamily: FontClass.appFont,
                                      fontSize: 15)),
                            ),
                            /*Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Type : categorized ",
                              style: TextStyle(
                                  color: ColorClass.subTitleColor,
                                  fontFamily: FontClass.appFont,
                                  fontSize: 15)),
                        ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
