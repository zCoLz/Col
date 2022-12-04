
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
class fireDb{
  final _auth = FirebaseAuth.instance;
  createUser(String name,String email, String userImages,String uid,)async{
      final User? user = _auth.currentUser;
      if(!await getuser()){
         final endIndex = email.indexOf("@", 0);
      var newUser = {
        'email' : email,
        'name' : email.substring(0,endIndex),
        'userImages': userImages,
        'highScore' : 0,
        'exp' : 0,
        'coins':0,
        'money':0,
        'rankScore' : 0,
        'rank' : ''
      };
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set(newUser);}
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
}