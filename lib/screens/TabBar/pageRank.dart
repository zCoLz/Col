import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PageRank extends StatefulWidget {
  const PageRank({super.key});

  @override
  State<PageRank> createState() => _PageRankState();
}

class _PageRankState extends State<PageRank> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Layout().background_image,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          
          title: Text("Bảng xếp hạng"),
        ),
        drawer: PageDrawer(),
        body: Column(children: [
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading: Image.asset(
                    "acssets/hang1.png",
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  title: const Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Text(
                      "Minh Sad Boy",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: const Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Text(
                      "Điểm: 1595",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ListTile(
              leading: Image.asset(
                "acssets/hang2.png",
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              title: const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  "Lộc không vui",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  "Điểm: 1592",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            ListTile(
              leading: Image.asset(
                "acssets/hang3.png",
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              title: const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  "Quang thiếu u",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  "Điểm: 1590",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: ListTile(
                leading: Text(
                  "#4",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Phi hay quạo",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Điểm: 1588",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: ListTile(
                leading: Text(
                  "#5",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Quyền không ngu",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Điểm: 1586",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: ListTile(
                leading: Text(
                  "#6",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                title: Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Bình Bóng bảy",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Điểm: 1584",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _fireStore.collection('users').where('email',isEqualTo: _auth.currentUser!.email).snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
              return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    leading: const Text(
                      "#7",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        snapshot.data!.docs[0]['name'],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text('Điểm : ${snapshot.data!.docs[0]['highScore'].toString()}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                );
            }
          ),
        ]),
      ),
    );
  }
}
