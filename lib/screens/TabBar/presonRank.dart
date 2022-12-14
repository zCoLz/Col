import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PresonalRank extends StatefulWidget {
  const PresonalRank({super.key});

  @override
  State<PresonalRank> createState() => _PersonalRankState();
}

class _PersonalRankState extends State<PresonalRank> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final user_current = FirebaseFirestore.instance.collection('users')
    .where('email',isEqualTo: _auth.currentUser!.email).snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: user_current,
      builder: (context, snapshot) {
        try{
        final user = snapshot.data!.docs;
        return Container(
          decoration: Layout().background_image,
          child: Scaffold(
            backgroundColor: Colors.transparent,appBar: AppBar(
            title: Text('Rank cá nhân'),),
             drawer: PageDrawer(),
             body: Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/9),
                child: Column(
                  children: [
                   if(user[0]['rankScore']==0)
                        Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(59)
                      )
                      ,child: Text('Chưa có Rank',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),)
                        )else

                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(59)
                      )
                      ,child: 
                        Image(image: AssetImage('acssets/Rank/${user[0]['rank'].toString()}'))),
                    Text(user[0]['name'].toString(),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    Padding(padding: EdgeInsets.all(20) ,
                      child: Text('Điểm : ${user[0]['rankScore'].toString()}',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),))
                  ],
                ),
             ),
             ),
        );
      }catch(e){
        return Center(child: CircularProgressIndicator(),);
      }
      }
    );
  }
}