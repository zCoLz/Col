
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Layout {
    var background_image = BoxDecoration(
      image: DecorationImage(
                    image: AssetImage("acssets/background2.jpg"),
                    fit: BoxFit.cover)
    );
}
class Level{
   int setLevel(int XP){
    double  level = (sqrt (100 * (XP+ 25)) + 50) / 100;
        return  level.toInt();
    }
}
class Rank{
  final _auth = FirebaseAuth.instance;
     setRank(int x)async{ 
      String rank ='';
      if(x<=200)
        rank = 'RankDong.png';
      else if(x<=500)
        rank = 'RankBac.png';
      else if(x<=900)
        rank = 'RankVang.png';
      else if(x<=1400)
        rank = 'RankBK.png';
      else if(x<=2000)
        rank = 'RankKC.png';
      else
        rank = 'RankMaster.png';
      var newUser = {
        'rank' : rank
      };
      await FirebaseFirestore.instance.collection('users')
      .doc(_auth.currentUser!.uid).update(newUser);
     }
}
//level = (sqrt (100 (2experience + 25)) + 50) / 100 và kinh nghiệm = (level ^ 2 + level) / 2 * 100- (level * 100)