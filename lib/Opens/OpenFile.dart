import 'dart:convert';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class OpenFile extends StatefulWidget {
  @override
  _OpenFileState createState() => _OpenFileState();
}

class _OpenFileState extends State<OpenFile> {
  bool isClickedOnFile = false;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              "Files",
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
                var snackBar = new SnackBar(
                  content: Text("Please Select File"),
                  duration: Duration(seconds: 1),
                );
                isClickedOnFile
                    ? Navigator.pop(context)
                    : _scaffoldKey.currentState.showSnackBar(snackBar);
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
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(
              top: 12.0, bottom: 8.0, left: 25.0, right: 25.0),
          child: new Container(
            height: 125.00,
            width: MediaQuery.of(context).size.width,
            color: ColorClass.containerColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    isClickedOnFile = true;
                  });
                  String data = await DefaultAssetBundle.of(context).loadString("files/test.json");
                  final jsonResult = json.decode(data);
                  print(jsonResult["dataSources"]);
                  Navigator.pop(context);
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text("Tiles",
                              style: TextStyle(
                                  color: ColorClass.fontColor,
                                  fontFamily: FontClass.appFont,
                                  fontSize: 17)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("path : files / Tiles",
                              style: TextStyle(
                                  color: ColorClass.subTitleColor,
                                  fontFamily: FontClass.appFont,
                                  fontSize: 15)),
                        ),
                        Text("size : 0.01 mb",
                            style: TextStyle(
                                color: ColorClass.subTitleColor,
                                fontFamily: FontClass.appFont,
                                fontSize: 15))
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
