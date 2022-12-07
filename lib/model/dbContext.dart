
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/levelDesign.dart';
import 'package:home_page/model/level.dart';
import 'package:home_page/screens/GamePlay/listCreateRoom.dart';
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
class fireDb{
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  createUser(String name,String email,String uid)async{
      final User? user = _auth.currentUser;
      if(!await getuser()){
         final endIndex = email.indexOf("@", 0);
      var newUser = {
        'email' : email,
        'name' : email.substring(0,endIndex),
        'userImages': '',
        'highScore' : 0,
        'exp' : 0,
        'coins':0,
        'money':0,
        'rankScore' : 0,
        'rank' : '',
        'level' : fireDb().setLevel(0)
      };
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set(newUser);}
  }
  createRoom(var user)async{
     Random objectname = Random();
     int number = objectname.nextInt(1000);
     var newRoom = {
        'id' : number,
        'player 1' : {
           'email' : user['email'],
           'name' : user['name'],
           'score' : 0
            },
         'player 2' : {
           'email' : '',
           'name' : '',
           'score' : 0
         },
        'created' : user['created']
     };
    await FirebaseFirestore.instance.collection('room').doc(number.toString()).set(newRoom);
    return number;
  }
  Future<bool> getuser()async{
    final User? user_current = _auth.currentUser;
    String user = ''; 
    await FirebaseFirestore.instance.collection('users').doc(user_current!.uid).get().then((value) => {
        user = value.data().toString()
    });
    if(user=='null')
        return false;
    return true;
  }
     setRank(int x)async{ 
      String rank ='';
      if(x<=0)
        rank='';
      else if(x<=200)
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
     setUserImage(String image)async{
        var newUser = {
        'userImages' : image
      };
        await FirebaseFirestore.instance.collection('users')
      .doc(_auth.currentUser!.uid).update(newUser);
     }
     setLevel(int XP)async{
      double  level = (sqrt(100 * 2*(XP + 25)) + 50) / 100;
        var setLevel = {
          'level' : level.toInt()
        };
        await _firestore.collection('users').doc(_auth.currentUser!.uid)
        .update(setLevel);
    }
   /*  int setExp(int level){
      level= level + 1;
      double exp = (((level ^ 2) + level) / 2 * (100 - (level * 100)).abs()); 
      return exp.toInt();
    } */
//level = (sqrt (100 (2experience + 25)) + 50) / 100 và kinh nghiệm = (level ^ 2 + level) / 2 * 100- (level * 100)
}