import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';
import 'package:home_page/screens/GamePlay/listLevel.dart';
import 'package:home_page/screens/GamePlay/listRoom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final _login =  _auth.currentUser;
    final user = FirebaseFirestore.instance.collection('users')
    .where('email',isEqualTo: _login!.email)
    .snapshots();
    return Container(
      decoration: Layout().background_image,
      child:  StreamBuilder<QuerySnapshot>(
        stream: user,
        builder: (context, snapshot) {
          if(snapshot.hasData){
          return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                centerTitle: true,
                title: Text(""),
                actions: [
                  IconButton(
                      onPressed: (() {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Save and Exit ?"),
                                content: Text("Bạn có muốn thoát khỏi A"),
                                actions: [
                                  FloatingActionButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: Text('No'),
                                  ),
                                  FloatingActionButton(
                                    onPressed: () => exit(0),
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            });
                      }),
                      tooltip: 'Close App',
                      icon: Icon(Icons.power_settings_new)),
                ],
              ),
              drawer: PageDrawer(),
              body: Container(
                alignment: Alignment.center,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.energy_savings_leaf,
                          size: 35,
                          color: Colors.green,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 200),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.diamond,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                    Text(
                                     // _login.email.toString(),
                                      snapshot.data!.docs[0]['coins'].toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.monetization_on_rounded,
                                      size: 30,
                                      color: Colors.yellow,
                                    ),
                                    Text(
                                      snapshot.data!.docs[0]['money'].toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              "20/20",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 170),
                        child: SizedBox(
                          height: 70,
                          width: 200,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LevelList()));
                              },
                              child:
                                  Text("Chơi Đơn", style: TextStyle(fontSize: 18))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: SizedBox(
                          height: 70,
                          width: 200,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => listRoom()));
                              },
                              child: Text(
                                "Chơi Đối Kháng",
                                style: TextStyle(fontSize: 18),
                              )),
                        ),
                      ),
                    ],
                  ),
                ]),
              ));
        }
        else{
          return Center(
            child: Text('Có lỗi xảy ra'),
          );
        }
    } ),
    );
  }
}
