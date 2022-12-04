import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  TextEditingController _controller  = TextEditingController();
  TextEditingController _account = TextEditingController();
  TextEditingController _pasword = TextEditingController();
  TextEditingController _name = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
   final user = FirebaseFirestore.instance.collection('users')
    .where('email',isEqualTo: _auth.currentUser!.email)
    .snapshots();
    return Container(
      decoration: Layout().background_image,
      child: StreamBuilder<QuerySnapshot>(
        stream: user,
        builder: (context, snapshot) {
            _name.text = snapshot.data!.docs[0]['name'].toString();
            _account.text = snapshot.data!.docs[0]['email'].toString();
          return Scaffold(
            backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                centerTitle: true,
                title: Text(""),
                actions: [
                  IconButton(
                      onPressed: (() {}), icon: Icon(Icons.power_settings_new)),
                ],
              ),
              drawer: PageDrawer(),
              body: Center(
                child: Container(
                  child: Column(children: [
                    Icon(
                      Icons.account_circle,
                      size: 60,
                    ),
                    Text(
                      "Quang Thiếu U",
                      style: TextStyle(fontSize: 30),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _name,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20, color: Colors.black),
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
                        controller: _account,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "Tài khoản",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                    Padding(
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
                    )
                  ]),
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
        }
      ),
    );
  }
}
