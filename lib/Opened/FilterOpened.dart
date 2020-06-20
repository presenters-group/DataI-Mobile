import 'package:eyedatai/Classes/FilterModel.dart';
import 'package:flutter/material.dart';

import '../ColorClass.dart';
import '../FontClass.dart';

class FilterOpened extends StatefulWidget {
  FilterModel filterModel;

  FilterOpened(this.filterModel);

  @override
  _FilterOpenedState createState() => _FilterOpenedState(filterModel);
}

class _FilterOpenedState extends State<FilterOpened> {
  TextEditingController nameController = new TextEditingController();
  FilterModel filterModel;

  _FilterOpenedState(this.filterModel);

  @override
  void initState() {
    super.initState();
    nameController.text = filterModel.name;
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
              "${filterModel.name}",
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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
              title: Text(
                "name",
                style: TextStyle(
                    color: ColorClass.fontColor,
                    fontFamily: FontClass.appFont,
                    fontSize: 15),
              ),
              trailing: Container(
                height: 40.00,
                width: 150.00,
                color: ColorClass.filterContainerColor,
                child: Center(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 4.0),
                      child: new TextField(
                        onChanged: (value) {},
                        style: TextStyle(
                            color: ColorClass.fontColor,
                            fontFamily: FontClass.appFont,
                            fontSize: 12),
                        textAlign: TextAlign.left,
                        controller: nameController,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: FontClass.appFont,
                              fontSize: 12),
                          hintText: 'Filter Name',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
              title: Text(
                "data source",
                style: TextStyle(
                    color: ColorClass.fontColor,
                    fontFamily: FontClass.appFont,
                    fontSize: 15),
              ),
              trailing: Container(
                height: 40.00,
                width: 150.00,
                color: ColorClass.filterContainerColor,
                child: Center(
                    child: DropdownButton(
                  onChanged: (val) {},
                  items: [],
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
              title: Text(
                "column type",
                style: TextStyle(
                    color: ColorClass.fontColor,
                    fontFamily: FontClass.appFont,
                    fontSize: 15),
              ),
              trailing: Container(
                height: 40.00,
                width: 150.00,
                color: ColorClass.filterContainerColor,
                child: Center(
                    child: DropdownButton(
                  onChanged: (val) {},
                  items: [],
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
              title: Text(
                "column",
                style: TextStyle(
                    color: ColorClass.fontColor,
                    fontFamily: FontClass.appFont,
                    fontSize: 15),
              ),
              trailing: Container(
                height: 40.00,
                width: 150.00,
                color: ColorClass.filterContainerColor,
                child: Center(
                    child: DropdownButton(
                  onChanged: (val) {},
                  items: [],
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
              title: Text(
                "type",
                style: TextStyle(
                    color: ColorClass.fontColor,
                    fontFamily: FontClass.appFont,
                    fontSize: 15),
              ),
              trailing: Container(
                height: 40.00,
                width: 150.00,
                color: ColorClass.filterContainerColor,
                child: Center(
                    child: DropdownButton(
                  onChanged: (val) {},
                  items: [],
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
