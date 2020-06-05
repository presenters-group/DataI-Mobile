import 'package:eyedatai/Opens/OpenFile.dart';
import 'package:flutter/material.dart';
import 'DataI.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key,
      routes: {
        '/DataI': (context) => DataI(),
        '/OpenFile': (context) => OpenFile()
      },
      initialRoute: '/',
      home: DataI(),
    );
  }
}


