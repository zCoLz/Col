
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/Question_Model.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/GamePlay/listRoom.dart';
import 'package:home_page/screens/GamePlay/questionBattle.dart';
import 'package:home_page/screens/GamePlay/questionBattle_2.dart';

class CreateRoom extends StatefulWidget {
  CreateRoom({Key? key, required this.id, this.user_two}) : super(key: key);
  final int id;
  var user_one;
  var user_two;
  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  List<Question> lst = [];
  @override
  Widget build(BuildContext context) {
    Widget player_one() {
      var images = '';
      var name = '';
      return StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('rooms')
              .where('id', isEqualTo: widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              try {
                images = snapshot.data!.docs[0]['player_1.userImages'];
                name = snapshot.data!.docs[0]['player_1.name'];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              'Ch??? ph??ng',
                              style: TextStyle(fontSize: 18),
                            ),
                            Icon(
                              Icons.military_tech,
                              color: Colors.yellow[500],
                            )
                          ],
                        ),
                      ),
                    ),
                    if (images == '')
                      CircleAvatar(
                        radius: 28,
                        child: Text(
                          name.substring(0, 1).toUpperCase(),
                          style: const TextStyle(fontSize: 30),
                        ),
                      )
                    else
                      CircleAvatar(
                        backgroundImage: AssetImage('acssets/avatar/$images'),
                        radius: 30,
                      ),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ))
                  ],
                );
              } catch (e) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }

    Widget avatarBattle() {
      return Container(
          margin: const EdgeInsets.fromLTRB(0, 40, 0, 10),
          width: MediaQuery.of(context).size.width / 1.05,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              player_one(),
              Image(
                image: const AssetImage("acssets/vs.png"),
                width: MediaQuery.of(context).size.width / 4,
              ),
              player_two()
            ],
          ));
    }
   
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('rooms')
            .where('id', isEqualTo: widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Future<bool> _willPopScopeCall()async{
      if (snapshot.data!.docs[0]['player_1.email'] ==
                              _auth.currentUser!.email) {
                            Navigator.pop(context,true);
                            fireDb().deleteRoom(widget.id,true);
                          }
                          if (snapshot.data!.docs[0]['player_2.email'] ==
                              _auth.currentUser!.email) {
                            if (snapshot.data!.docs[0]['player_2.ready']) {
                             return await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      //title: Text("Save and Exit ?"),
                                      content: const Text(
                                          "B???n ??ang s???n s??ng kh??ng th??? tho??t"),
                                      actions: [
                                        Center(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context,false);
                                                },
                                                child: const Text('OK')))
                                      ],
                                    );
                                  })?? false;
                            }
                            Navigator.pop(context,true);
                            await fireDb().leaveRoom(widget.id);
                          }
                   return false;       
  }
            try {
              return WillPopScope(
                onWillPop: _willPopScopeCall,
                child: Scaffold(
                  appBar: AppBar(
                      title: const Text(''),
                      leading: IconButton(
                          onPressed: () async {
                            if (snapshot.data!.docs[0]['player_1.email'] ==
                                _auth.currentUser!.email) {
                              Navigator.pop(context);
                              fireDb().deleteRoom(widget.id,true);
                            }
                            if (snapshot.data!.docs[0]['player_2.email'] ==
                                _auth.currentUser!.email) {
                              if (snapshot.data!.docs[0]['player_2.ready']) {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        //title: Text("Save and Exit ?"),
                                        content: const Text(
                                            "B???n ??ang s???n s??ng kh??ng th??? tho??t"),
                                        actions: [
                                          Center(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('OK')))
                                        ],
                                      );
                                    });
                              }
                              Navigator.pop(context);
                              await fireDb().leaveRoom(widget.id);
                            }
                          },
                          icon: const Icon(
                            Icons.chevron_left,
                            size: 40,
                          )),
                      actions: [
                        Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.power_settings_new,
                                  size: 35,
                                )))
                      ]),
                  body: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: Layout().background_image,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text(
                                'ID ph??ng : ${widget.id}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              )),
                          avatarBattle(),
                          //Text('00:00s',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          Image(
                            image: const AssetImage('acssets/randomQuestion.jpg'),
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 100),
                            child: Text(
                              'Ng???u nhi??n',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          roomReady(snapshot.data!.docs[0]['player_1.email'],
                              snapshot.data!.docs[0]['player_2.email'])
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } catch (e) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: Layout().background_image,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(context, 
                    MaterialPageRoute(builder: (context)=>listRoom()), (route) => false),
                    child: const Text('Ch??? ph??ng ???? tho??t, Nh???n ????? tho??t'),
                  ),
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget player_two() {
    var images = '';
    var name = '';
    var ready = 'Ch??a s???n s??ng';
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('rooms')
            .where('id', isEqualTo: widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            try {
              if (snapshot.data!.docs[0]['player_2.email'] != '') {
                images = snapshot.data!.docs[0]['player_2.userImages'];
                name = snapshot.data!.docs[0]['player_2.name'];
                if (snapshot.data!.docs[0]['player_2.ready']) {
                  ready = 'S???n s??ng';
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          ready,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    if (images == '')
                      CircleAvatar(
                        radius: 28,
                        child: Text(name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(fontSize: 30)),
                      )
                    else
                      CircleAvatar(
                        backgroundImage: AssetImage('acssets/avatar/$images'),
                        radius: 30,
                      ),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          '??ang ch???',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    if (images == '')
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('acssets/avatar/waiting.gif'),
                        radius: 30,
                      )
                    else
                      CircleAvatar(
                        backgroundImage: AssetImage('acssets/avatar/$images'),
                        radius: 30,
                      ),
                    if (name == '')
                      const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            '?',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ))
                    else
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            name,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ))
                  ],
                );
              }
            } catch (e) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
  List<Question> lstRandom=[];
  Widget roomReady(String email_1, String email_2) {
    String button = '';
    var ListQuestions = _firestore
        .collection('questions')
        //.where('level', isEqualTo: 1)
        //.where('subject.id', isEqualTo: widget.subject)
        .snapshots();
        int count =0;
    return StreamBuilder(
        stream: ListQuestions,
        builder: (context, snapshot) {
          try {
            var list = snapshot.data!.docs
                .map((e) => Question.fromQueryDoucumentSnapshot(e))
                .toList();
            return StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('rooms')
                    .where('id', isEqualTo: widget.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  try {
                    bool check = snapshot.data!.docs[0]['player_2.ready'];
                    bool play = snapshot.data!.docs[0]['player_1.ready'];
                     if(play && lst.isEmpty){
                        Random r = Random();
                        //lay cau hoi
                        while(lst.length<10) {
                            int random = r.nextInt(list.length);
                            if(list[random].level==1 && lst.length<4){
                              lst.add(list.elementAt(random));
                              list.removeAt(random);
                          }else if(lst.length>=4 && lst.length<7 && list[random].level==2){
                              lst.add(list.elementAt(random));
                              list.removeAt(random);
                          }else if(lst.length>=7 && list[random].level==3){
                              lst.add(list.elementAt(random));
                              list.removeAt(random);
                          }
                        }
                        //dao thu tu cau hoi
                        for(int i=0;i<10;i++){
                          int random = r.nextInt(lst.length);
                          lstRandom.add(lst.elementAt(random));
                          lst.removeAt(random);
                        }
                        }
                      if (play && check && email_2 == _auth.currentUser!.email){
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionBattle_2(
                                        id: widget.id,
                                        listQuestions: lstRandom,
                                      )), (route) => false);
                        });
                      }
                    if (email_1 == _auth.currentUser!.email) {
                      button = 'B???t ?????u';
                    } else {
                      if (snapshot.data!.docs[0]['player_2.ready'] == false) {
                        button = 'S???n s??ng';
                      } else {
                        button = '???? s???n s??ng';
                      }
                    }
                    return Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.width / 8.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 2),
                          boxShadow: const [
                            BoxShadow(color: Colors.black, offset: Offset(3, 3))
                          ]),
                      child: TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.black),
                        onPressed: () async {
                          if (email_1 == _auth.currentUser!.email && check) {
                            await fireDb().getPlay(widget.id, true);
                            await fireDb().createResult(widget.id);
                            Future.delayed(const Duration(milliseconds: 500),(){
                              Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context)=>QuestionBattle_1(id: widget.id,listQuestions: lstRandom,)), (route) => false);
                            });
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionBattle(id: widget.id,)));
                          } else if (email_2 == _auth.currentUser!.email) {
                            await fireDb().getReady(widget.id, check);
                          } else if (email_1 == _auth.currentUser!.email &&
                              snapshot.data!.docs[0]['player_2.email'] == '') {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    //title: Text("Save and Exit ?"),
                                    content: const Text("Ch??a c?? ?????i th???"),
                                    actions: [
                                      Center(
                                          child: ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('OK'),
                                      ))
                                    ],
                                  );
                                });
                          } else {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    //title: Text("Save and Exit ?"),
                                    content:
                                        const Text("?????i th??? ch??a s???n s??ng"),
                                    actions: [
                                      FloatingActionButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Center(child: Text('OK')),
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                        child: Text(
                          button,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  } catch (e) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          } catch (e) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
