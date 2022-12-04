import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Layout {
    var background_image = BoxDecoration(
      image: DecorationImage(
                    image: AssetImage("acssets/background2.jpg"),
                    fit: BoxFit.cover)
    );
}
class level{
    setLevel(int XP){
    double  level = (sqrt (100 * (XP+ 25)) + 50) / 100;
        return  level.toInt();
    }
}
//level = (sqrt (100 (2experience + 25)) + 50) / 100 và kinh nghiệm = (level ^ 2 + level) / 2 * 100- (level * 100)