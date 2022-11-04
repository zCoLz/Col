
import 'package:flutter/material.dart';
import 'package:home_page/components/levelDesign.dart';
import 'package:home_page/model/level.dart';
class DbContext{
    static List<Level> lstLevel = new List<Level>.filled(1, Level(level: LevelInfo(unClock: null,images: '',title: '')),growable: true);
    void createLevel(){
     lstLevel =[
        Level(level: LevelInfo(unClock: null,images: 'level/title1.jpg', title: 'Ải 1')),
        Level(level: LevelInfo(unClock: Icons.lock_rounded,images: 'level/randomQuestion.jpg', title: 'Ải 2')),
        Level(level: LevelInfo(unClock: Icons.lock_rounded,images: 'level/randomQuestion.jpg', title: 'Ải 3')),
        Level(level: LevelInfo(unClock: Icons.lock_rounded,images: 'level/randomQuestion.jpg', title: 'Ải 4')),
        Level(level: LevelInfo(unClock: Icons.lock_rounded,images: 'level/randomQuestion.jpg', title: 'Ải 5')),
        Level(level: LevelInfo(unClock: Icons.lock_rounded,images: 'level/randomQuestion.jpg', title: 'Ải 6')),
       ];
      }
}