
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/levelDesign.dart';
import 'package:home_page/model/level.dart';
import 'package:home_page/screens/GamePlay/listCreateRoom.dart';
import 'package:http/http.dart';
class DbContext{
    static List<Level> lstLevel = new List<Level>.filled(1, Level(level: LevelInfo(unClock: null,images: '',title: '',id: 0)),growable: true);
    void createLevel(){
     lstLevel =[
        Level(level: LevelInfo(unClock: null,images: 'level/title1.jpg', title: 'Ải 1',id: 2)),
        Level(level: LevelInfo(unClock: null,images: 'level/randomQuestion.jpg', title: 'Ải 2',id: 3)),
        Level(level: LevelInfo(unClock: null,images: 'level/randomQuestion.jpg', title: 'Ải 3',id: 4)),
        Level(level: LevelInfo(unClock: null,images: 'level/randomQuestion.jpg', title: 'Ải 4',id: 5)),
        Level(level: LevelInfo(unClock: Icons.lock_rounded,images: 'level/randomQuestion.jpg', title: 'Ải 5',id: 6)),
        Level(level: LevelInfo(unClock: Icons.lock_rounded,images: 'level/randomQuestion.jpg', title: 'Ải 6',id: 7)),
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
     while(await getRoom(number)){
        number = objectname.nextInt(1000);
     }
     var newRoom = {
        'id' : number,
        'player_1' : {
           'email' : user['email'],
           'name' : user['name'],
           'userImages' : user['userImages'],
           'score' : 0,
           'ready' : false
            },
            'player_2' : {
           'email' : '',
           'name' : '',
           'userImages' : '',
           'score' : 0,
           'ready' : false
         },
        'created' : DateTime.now(),
        'status' : 1
     };
    await FirebaseFirestore.instance.collection('rooms').doc(number.toString()).set(newRoom);
    return number;
  }
  joinRoom(int id,var user)async{
    var user_2 ={
    'status': 2,
    'player_2' : {
           'email' : user['email'],
           'name' : user['name'],
           'userImages' : user['userImages'],
           'score' : 0,
           'ready':false
         },
    };
    await FirebaseFirestore.instance.collection('rooms').doc(id.toString()).update(user_2);
  }
  getReady(int id,bool check)async{
    if(check==false) check = true;
    else check = false;
     var ready = {
        'player_2.ready' : check
     };
    await FirebaseFirestore.instance.collection('rooms').doc(id.toString()).update(ready);
  }
  getPlay(int id,bool check)async{
    var ready = {
        'player_1.ready' : check
     };
     await FirebaseFirestore.instance.collection('rooms').doc(id.toString()).update(ready);
  }
  leaveRoom(int? id)async{
    var user={
      'status' : 1,
      'player_2' : {
           'email' : '',
           'name' : '',
           'userImages' : '',
           'score' : 0,
           'ready' : false
         },
    };
    await FirebaseFirestore.instance.collection('rooms').doc(id.toString()).update(user);
  }
  Future<bool> check(int? id)async{
      String user = ''; 
    await FirebaseFirestore.instance.collection('rooms').where('id',isEqualTo: id).get().then((value) => {
        user = value.docs[0]['player_2'].toString()
  });
    if(user==null)
      return false;
    return true;
    }
  Future<bool> getRoom(int id)async{
    String romId = '';
    await FirebaseFirestore.instance.collection('rooms').doc(id.toString()).get().then((value) => {
      romId = value.data().toString()
    });
    if(romId=='null') return false;
    return true;
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