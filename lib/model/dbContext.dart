
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/levelDesign.dart';
import 'package:home_page/model/level.dart';
class DbContext{
}
class fireDb{
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  createUser(String email)async{
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
        'level' :  1,
        'chapter' : 1,
        'rename' : 2
      };
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set(newUser);
      }
  }
  createRoom(var user)async{
     Random objectname = Random();
     int number = objectname.nextInt(10000);
     while(await getRoom(number)){
        number = objectname.nextInt(10000);
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
        'created' : DateTime.now().toString().trim(),
        'status' : 1,
        'battling' : true
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
  createResult(int id)async{
    var result = {
      'player_1.result' : null,
      'player_2.result' : null
    };
    await FirebaseFirestore.instance.collection('rooms').doc(id.toString()).update(result);
  }
  updateResult(int id,int score_1, int score_2)async{
    var user;
    int result_1=0;
    int result_2=0;
    if(score_1>score_2){
      result_1=1;
    }
    else if(score_1<score_2)
      result_2=1;
    else{
      result_1=2;
      result_2=2;
    }
     user ={
        'player_1.result' : result_1,
        'player_2.result' : result_2
      };
      await FirebaseFirestore.instance.collection('rooms').doc(id.toString()).update(user);
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
    Future<String> setRank(int x)async{ 
     /*  String rankOld='';
      await _firestore
      .collection('users')
      .where('email',isEqualTo: _auth.currentUser!.email)
      .get().then((value){
        if(value!=null){
          rankOld = value.docs[0]['rank'];
        }
      }); */
      String rank ='';
      if(x<=0) {
        rank='';
      } else if(x<=200) {
        rank = 'RankDong.png';
      } else if(x<=500) {
        rank = 'RankBac.png';
      } else if(x<=900) {
        rank = 'RankVang.png';
      } else if(x<=1400) {
        rank = 'RankBK.png';
      } else if(x<=2000) {
        rank = 'RankKC.png';
      } else {
        rank = 'RankMaster.png';
      }
      var newUser = {
        'rank' : rank
      };
      await FirebaseFirestore.instance.collection('users')
      .doc(_auth.currentUser!.uid).update(newUser);
      return rank;
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
   setHighScore(int score)async{
      var user ={
          'highScore' : score
      };
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update(user);
   }
   unClockChapter(int chapter)async{
    var user = {
      'chapter' : chapter
    };
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update(user);
   }
   Future<int> countChapter()async{
    int chapter=0;
    await _firestore.collection('subjects').get().then((value){
      chapter = value.docs.length;
    });
    return chapter;
   }
   updateScore(int id,int p,int score)async{
    var player;
    if(p==1){
      player = {
        'player_1.score' : score
      };
      }
    else{
      player = {
        'player_2.score' : score
      };  
    }
     await FirebaseFirestore.instance.collection('rooms').doc(id.toString()).update(player);
   }
   createBattleHistories(var battle)async{
      int id=0;
      await _firestore.collection('battleHistoreis').get().then((value){
        if(value!=null){
          id = value.docs.length;
        }
      });
      battle['id']=id+1;
      await FirebaseFirestore.instance.collection('battleHistoreis').add(battle);
   }
   deleteRoom(int id, bool check)async{
    if(check){
      await _firestore .collection('rooms').doc(id.toString()).delete();
      }else{
        var status ={
          'battling' : false
        };
      await _firestore.collection('rooms').doc(id.toString()).update(status);
      }
   }
   updateRankBattle( int rankScore, int money, int coin, int exp)async{
    int expUser=0;
    int rankScoreUser=0;
    int coinUser=0;
    int moneyUser=0;
      await _firestore.collection('users').where('email',isEqualTo: _auth.currentUser!.email).get().then((value){
      if(value!=null){
        expUser= value.docs[0]['exp'];
        coinUser = value.docs[0]['coins'];
        moneyUser = value.docs[0]['money'];
        rankScoreUser = value.docs[0]['rankScore'];
      }});
      if(rankScoreUser + rankScore <0){
        rankScoreUser=0;
      }else{
        rankScoreUser+=rankScore;
      }
    var updateUser = {
      'exp' : (expUser+ exp),
      'coins' : (coinUser+coin),
      'money' : (moneyUser + money),
      'rankScore' : rankScoreUser
    };
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update(updateUser);
    setRank(updateUser['rankScore']!);
    setLevel(updateUser['exp']!);
    }
    getImage(String email)async{
      String image ='';
    await _firestore.collection('users').where('email',isEqualTo: email)
      .get().then((value){
        if(value!=null){
          image = value.docs[0]['userImages'];
        }
      });
      return image;
    }
   Future<bool> updateName(String name)async{
    bool check = false;
    await _firestore.collection('users').where('email',isEqualTo: _auth.currentUser!.email).get().then((value)async{
        if(value!=null){
          await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
            'name' : name,
            'rename' : (value.docs[0]['rename']-1)
      }).then((value) => check=true);
        }
    });
      return check;
    }
    storymode(int money, int coin)async{
      int moneyUser=0;
      int coinUser=0;
      await _firestore.collection('users').where('email',isEqualTo: _auth.currentUser!.email).get()
      .then((value)async{
         if(value!=null){
          moneyUser = value.docs[0]['money'];
          coinUser = value.docs[0]['coins'];
         }
      });
      var update ={
         'money' : (money+moneyUser),
        'coins' : (coin+coinUser)
      };
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update(update);
    }
   /*  int setExp(int level){
      level= level + 1;
      double exp = (((level ^ 2) + level) / 2 * (100 - (level * 100)).abs()); 
      return exp.toInt();
    } */
//level = (sqrt (100 (2experience + 25)) + 50) / 100 và kinh nghiệm = (level ^ 2 + level) / 2 * 100- (level * 100)
}