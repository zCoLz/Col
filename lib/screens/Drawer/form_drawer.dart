import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/TabBar/history.dart';
import 'package:home_page/screens/TabBar/pageRank.dart';
import 'package:home_page/screens/TabBar/presonRank.dart';
import 'package:home_page/screens/TabBar/putMoney.dart';
import 'package:home_page/screens/TabBar/ranking.dart';
import 'package:home_page/screens/TabBar/setting.dart';
import 'package:home_page/screens/home.dart';

class PageDrawer extends StatefulWidget {
  const PageDrawer({super.key});

  @override
  State<PageDrawer> createState() => _PageDrawerState();
}

class _PageDrawerState extends State<PageDrawer> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
     final _login =  _auth.currentUser;
    final userDB = FirebaseFirestore.instance.collection('users')
    .where('email',isEqualTo: _auth.currentUser!.email)
    .snapshots();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 5),
            decoration: BoxDecoration(color: Colors.blue),
            child: StreamBuilder<QuerySnapshot>(
              stream: userDB,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                var user = snapshot.data!.docs;
                fireDb().setRank(user[0]['rankScore']);
                fireDb().setLevel(user[0]['exp']);
                return Column(children: [
                  Row(
                    children: [
                      if(user[0]['userImages'].toString()=='')
                        CircleAvatar(child: Text(user[0]['name'].toString().substring(0,1).toUpperCase(),
                        style: TextStyle(fontSize: 25)),)
                      else  CircleAvatar(backgroundImage: AssetImage('acssets/avatar/${user[0]['userImages']}'),), 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text(user[0]['name'].toString(),textAlign: TextAlign.left,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                           Padding(
                             padding: const EdgeInsets.only(right: 75,left: 10),
                             child: Row(
                              children: [
                                Text("Cấp: ${user[0]['level'].toString()}",style: TextStyle(fontSize: 15),),
                              ],
                          ),
                           ),
                           Container(
                            margin: EdgeInsets.only(top: 10,left: 10),
                            width: MediaQuery.of(context).size.width/3,
                            height: 14,
                            child: Center(child: Text(user[0]['exp'].toString()/* +'/'+ fireDb().setExp(user[0]['level']).toString() */,style: TextStyle(fontSize: 12),)),
                            decoration: BoxDecoration(border: Border.all(width: 1),borderRadius: BorderRadius.circular(10)),
                           )
                        ],
                      ),
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row( 
                          children:[
                       Padding(padding: EdgeInsets.only(left: 10),
                       child: Text('Rank : ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)),
                      if(user[0]['rankScore']==0)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                          child: Text('Chưa có Rank',style: TextStyle(fontSize: 16),),
                        )
                      else
                        Image(image:  AssetImage('acssets/Rank/${user[0]['rank'].toString()}'),
                      width: MediaQuery.of(context).size.width/5.5,),
                      ])),
                      Text('Điểm : ' + user[0]['rankScore'].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),)
                      ])
                ]);
              }else{
                return Center(
                    child: CircularProgressIndicator(),
                  );
              }
              }
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text("Trang chủ"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Home())));
            },
          ),
          ListTile(
             leading: const Icon(Icons.present_to_all_rounded),
            title: Text("Rank cá nhân"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => PresonalRank())));
                  }
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart_rounded ),
            title: Text("Bảng điểm"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => PageRank())));
            },
          ),
          ListTile(
            leading: Icon(Icons.stacked_bar_chart_sharp),
            title: Text('Bảng xếp hạng'),
             onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Ranking())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.history_edu),
            title: Text("Lịch sử đấu đối kháng"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => History())));
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_rounded),
            title: Text('Nạp tiền'),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PutMoney()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Cài đặt'),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text("Đăng xuất"),
            onTap: () {
              try{
              FirebaseAuth.instance.signOut().then((value){
                final snackbar = SnackBar(content: Text('Đăng xuất thành công'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
              });
              /* Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => HomePage_Login_SignUp()))); */
                  Navigator.pushNamedAndRemoveUntil(context, 'welcome', (route) => false);
              }catch(e){
                Center(child: CircularProgressIndicator(),);
              }
            },
          ),
        ],
      ),
    );
  }
}
