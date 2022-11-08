import 'package:flutter/material.dart';
import 'package:home_page/screens/GamePlay/question.dart';

import '../model/dbContext.dart';
import '../model/level.dart';

class Level extends StatefulWidget {
  Level({super.key, required this.level});
  LevelInfo level;
  @override
  State<Level> createState() => _LevelStateState();
}

class _LevelStateState extends State<Level> {
  @override
  Widget build(BuildContext context) {
    var levelInfo = widget.level;
    return TextButton(
        onPressed: (() {
          if (levelInfo.unClock == null) {
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => Question())));
          }
        }),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image(
                image: AssetImage('acssets/' + levelInfo.images),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          levelInfo.unClock,
                          color: Colors.black,
                        ),
                        Text(
                          levelInfo.title,
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                      ]))
            ],
          ),
        ));
  }
}
