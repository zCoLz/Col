import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/GamePlay/listCreateRoom.dart';
import 'package:home_page/screens/GamePlay/searchBattle.dart';

class listRoom extends StatefulWidget{
    listRoom({super.key});

    @override
    State<listRoom> createState()=> _listRoomState();
}

class _listRoomState extends State<listRoom>{
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Widget content(String title, Function? on()){
      return  Container(
        width: MediaQuery.of(context).size.width/1.2,
        height: MediaQuery.of(context).size.width/10,
        margin: EdgeInsets.all(10),
        child: TextButton(onPressed: on, child: Align(alignment: Alignment.centerLeft, child: Text(title,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),),),),
        decoration: BoxDecoration(border: Border.all(width: 3)),
      );
    }           
      return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').where('email',isEqualTo: _auth.currentUser!.email).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
          var user = snapshot.data!.docs;
          return Scaffold(
            appBar: AppBar(title: Text(''),
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.chevron_left,size: 40,),),
            actions: [
               Padding(padding: EdgeInsets.only(right:15), child:
                IconButton(onPressed: (){}, icon: Icon(Icons.power_settings_new,size: 35,)))
            ],),
            body: Container(decoration: Layout().background_image,
              child: Column(children: [
               Expanded(child:  Column(
              children: [ Container(
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width/1.1,
                height: MediaQuery.of(context).size.height/1.8,
                child: Column(children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: Text('Danh sách phòng',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                      decoration: BoxDecoration(border: Border.all(width: 3)),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('rooms').where('player_1.email',isNotEqualTo: _auth.currentUser!.email).snapshots(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                        return Container(
                          width: MediaQuery.of(context).size.width/1.2,
                          height: MediaQuery.of(context).size.height/2.3,
                          child:ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var id = snapshot.data!.docs[index]['id'];
                              return  content('Phòng ' + id.toString(), ()
                              {
                                var user_2 = {
                                'email' : _auth.currentUser!.email,
                                'name' : user[0]['name'],
                                'userImages' : user[0]['userImages']
                              };
                                fireDb().joinRoom(id,user_2);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateRoom(id: id,user_two: user_2,)));
                              }); 
                            },
                          )
                        ,decoration: BoxDecoration(border: Border.all(width: 3)),);
                      }else{
                        return Center(child: CircularProgressIndicator(),);
                      }
                      }
                    )
                ],),decoration: BoxDecoration(color: Colors.white,border: Border.all(width: 3)),
              ),Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
            width: MediaQuery.of(context).size.width/3.1,
            height: MediaQuery.of(context).size.width/9,
            margin: EdgeInsets.all(20),
            child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: ()async{
                    var user = {
                      'email' : _auth.currentUser!.email,
                      'name' : snapshot.data!.docs[0]['name'],
                      'userImages' : snapshot.data!.docs[0]['userImages']
                    };
                    var id = await fireDb().createRoom(user);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => CreateRoom(id: id)));
                  }, 
                child: Text('Tạo phòng',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w600),),),
                decoration: BoxDecoration(color: Colors.white,border: Border.all(width: 2),boxShadow: [BoxShadow(color: Colors.black,offset: Offset(3,3))]),),
                 Container(
            width: MediaQuery.of(context).size.width/3.1,
            height: MediaQuery.of(context).size.width/9,
            margin: EdgeInsets.all(20),
            child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchBattle()));
                  }, 
                child: Text('Tìm nhanh',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w600),),),
                decoration: BoxDecoration(color: Colors.white,border: Border.all(width: 2),boxShadow: [BoxShadow(color: Colors.black,offset: Offset(3,3))]),),
                ],
              ),])),Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child:
                  Row(
                    children: [
                    Expanded(child: Row(children: [
                      Icon(Icons.monetization_on_rounded,color: Colors.yellow,size: 30,),
                      Text('100',style: TextStyle(fontSize: 18),),
                      Padding(padding: EdgeInsets.only(left: 15)),
                      Icon(Icons.diamond_rounded,size: 30,color: Colors.red,),
                      Text('100',style: TextStyle(fontSize: 18),)
                    ],)),
                    Icon(Icons.info_sharp,size: 40,)
                  ],))]),
          ));
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
        }
      );
  }
}