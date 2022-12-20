import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/screens/changePassWord.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _account = TextEditingController();
  TextEditingController _pasword = TextEditingController();
  TextEditingController _name = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _auth.currentUser!.email)
        .snapshots();
    return Container(
      decoration: Layout().background_image,
      child: StreamBuilder<QuerySnapshot>(
          stream: user, //user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _name.text = snapshot.data!.docs[0]['name'];
              _account.text = snapshot.data!.docs[0]['email'];
              var imgae = snapshot.data!.docs[0]['userImages'];
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
                                        onPressed: () =>
                                            Navigator.pop(context, false),
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
                          icon: Icon(Icons.power_settings_new)),
                    ],
                  ),
                  drawer: PageDrawer(),
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        child: Column(children: [
                          if (imgae == '')
                            CircleAvatar(
                              child: Text(
                                  snapshot.data!.docs[0]['name']
                                      .toString()
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(fontSize: 25)),
                            )
                          else
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('acssets/avatar/$imgae'),
                              maxRadius: 30,
                            ),
                          Text(
                            _name.text,
                            style: TextStyle(fontSize: 30),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _name,
                              keyboardType: TextInputType.text,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Tên hiển thị",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              readOnly: true,
                              controller: _account,
                              keyboardType: TextInputType.text,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "Tài khoản",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                            ),
                          ),
                          /* Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _pasword,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          decoration: InputDecoration(
                              labelText: "Mật khẩu",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ) */
                          Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15)),
                                    onPressed: () {
                                      if (_name.text ==
                                          snapshot.data!.docs[0]['name']) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                      'Bạn chưa có thay đổi gì'),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Center(
                                                            child:
                                                                Text('Trở về')))
                                                  ],
                                                ));
                                      }else{
                                        if(snapshot.data!.docs[0]['rename']==0){
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                      'Bạn đã hết số lần đổi tên'),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Center(
                                                            child:
                                                                Text('Trở về')))
                                                  ],
                                                ));
                                        }else{
                                          bool check=false;
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                      'Bạn còn ${snapshot.data!.docs[0]['rename'].toString()} lần đổi tên'),
                                                      content: Text('Bạn có muốn đổi tên'),
                                                  actions: [
                                                     Row(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                       children: [
                                                         ElevatedButton(
                                                            onPressed: ()async{
                                                            check=  await fireDb().updateName(_name.text);
                                                            if(check){
                                                                  showDialog(context: context, builder: (context)
                                                                  =>AlertDialog(
                                                                    title: Text('Đổi tên thành công'),
                                                                    actions: [
                                                                      ElevatedButton(onPressed: (){
                                                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>PageProfile()), (route) => false);
                                                                      }, child: Text('Ok'))
                                                                    ],
                                                                  ));
                                                                }
                                                            },
                                                            child: Center(
                                                                child:
                                                                    Text('Đổi tên'))),
                                                                     ElevatedButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Center(
                                                            child:
                                                                Text('Trở về')))
                                                       ],
                                                     ),
                                                  ],
                                                ));
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Đổi tên',
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 15)),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassWord()));
                                    },
                                    child: Text('Đổi mật khẩu'),
                                  ),
                                ],
                              ))
                        ]),
                      ),
                    ),
                  )
                  //Column(children: [
                  //     Icon(Icons.account_circle),
                  //     Text("Quang Thiếu U"),
                  //     Container(
                  //         child: Padding(
                  //       padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  //       child: TextField(
                  //         obscureText: false,
                  //         textAlign: TextAlign.left,
                  //         decoration: InputDecoration(
                  //             border: OutlineInputBorder(),
                  //             hintText: 'Số điện thoại',
                  //             hintStyle: TextStyle(
                  //                 color: Colors.grey,
                  //                 fontSize: 16,
                  //                 fontStyle: FontStyle.italic,
                  //                 fontWeight: FontWeight.bold)),

                  //       ),

                  //     )),
                  //     Container(
                  //         child: Padding(
                  //       padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  //       child: TextField(
                  //         obscureText: false,
                  //         textAlign: TextAlign.left,
                  //         decoration: InputDecoration(
                  //             border: OutlineInputBorder(),
                  //             hintText: '0351511xxx',
                  //             hintStyle: TextStyle(
                  //                 color: Colors.grey,
                  //                 fontSize: 16,
                  //                 fontStyle: FontStyle.italic,
                  //                 fontWeight: FontWeight.bold)),
                  //       ),
                  //     )),
                  //     Container(
                  //         child: Padding(
                  //       padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  //       child: TextField(
                  //         obscureText: false,
                  //         textAlign: TextAlign.left,
                  //         decoration: InputDecoration(
                  //             border: OutlineInputBorder(),
                  //             hintText: 'Số điện thoại',
                  //             hintStyle: TextStyle(
                  //                 color: Colors.grey,
                  //                 fontSize: 16,
                  //                 fontStyle: FontStyle.italic,
                  //                 fontWeight: FontWeight.bold)),
                  //       ),
                  //     )),
                  //     Container(
                  //         child: Padding(
                  //       padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  //       child: TextField(
                  //         obscureText: false,
                  //         textAlign: TextAlign.left,
                  //         decoration: InputDecoration(
                  //             border: OutlineInputBorder(),
                  //             hintText: 'quangthieu@gmail',
                  //             hintStyle: TextStyle(
                  //                 color: Colors.grey,
                  //                 fontSize: 16,
                  //                 fontStyle: FontStyle.italic,
                  //                 fontWeight: FontWeight.bold)),
                  //       ),
                  //     )),
                  //   ]),
                  );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
