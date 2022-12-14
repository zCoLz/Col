import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/home.dart';

class LevelList extends StatefulWidget {
  LevelList({super.key});
  @override
  State<LevelList> createState() => _LevelListStateState();
}

class _LevelListStateState extends State<LevelList> {
  @override
  Widget build(BuildContext context) {
    DbContext().createLevel();
    return Scaffold(
        appBar: AppBar(
            title: Text(''),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => Home())));
                },
                icon: Icon(
                  Icons.chevron_left,
                  size: 40,
                )),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.power_settings_new,
                        size: 35,
                      )))
            ]),
        body: Container(decoration: Layout().background_image,
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: DbContext.lstLevel.length,
              itemBuilder: (context, index) {
                return DbContext.lstLevel[index];
              },
            )));
  }
}
