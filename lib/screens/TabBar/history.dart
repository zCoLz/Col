import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';
import 'package:home_page/screens/GamePlay/battleResult_2.dart';
import 'package:home_page/screens/TabBar/battleHistory.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final _auth = FirebaseAuth.instance;
  final _fireStore =FirebaseFirestore.instance;
  int len =0;
  String battle='';
  Color colors = Colors.red;
  @override
  Widget build(BuildContext context) {
    var data =_fireStore.collection('battleHistoreis')
          .where('player_1.email',isEqualTo: _auth.currentUser!.email)
          .orderBy('created',descending: true)
          .firestore.collection('battleHistoreis')
          .where('player_2.email',isEqualTo: _auth.currentUser!.email)
          .orderBy('created',descending: true)
          .snapshots();
    return StreamBuilder(
      stream: data,
      builder: (context, snapshot) {
        try{
          if(snapshot.data!.docs.isEmpty){
            return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Lịch sử đấu"),
            /* actions: [
              IconButton(onPressed: (() {}), icon: Icon(Icons.power_settings_new)),
            ], */
          ),body: Container(
            decoration: Layout().background_image,
            child: const Center(child: Text('Chưa có lịch sử đấu',
              style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red,fontSize: 20),),)));
          }
        else{
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(""),
           /*  actions: [
              IconButton(onPressed: (() {}), icon: Icon(Icons.power_settings_new)),
            ], */
          ),
          drawer: PageDrawer(),
    
          body: Container(
            padding: EdgeInsets.only(top: 20),
            decoration: Layout().background_image,
            child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    int result=0;
                    if(snapshot.data!.docs[index]['player_1.email']==_auth.currentUser!.email){
                        result = snapshot.data!.docs[index]['player_1.result'];
                     }else{
                        result = snapshot.data!.docs[index]['player_2.result'];
                     }
                     if (result == 1) {
                          colors = Colors.blue;
                          battle = 'Thắng';
                        } else if(result==2) {
                          colors = Colors.amber;
                          battle='Hòa';
                        }else{
                          colors = Colors.red;
                          battle = 'Thua';
                       }
                return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  color: Colors.white.withOpacity(0.8),
                  child: ListTile(
                      title: Text(battle,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: colors)),
                      leading: const Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Icon(Icons.account_circle_rounded,size: 50,color: Colors.black, ),
                      ),
                      subtitle: Text(snapshot.data!.docs[index]['created'].toString().substring(0,19)),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => BattleHistory())));
                          }, icon: const Icon(Icons.arrow_forward,color: Colors.black))),
                ),
              );
            ;
      }
    )
    ));
    }
    }catch(e){
      return Text(e.toString());
    }
    }
    );
  }
}
