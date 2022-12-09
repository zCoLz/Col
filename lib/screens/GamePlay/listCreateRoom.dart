import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/GamePlay/questionBattle.dart';
class CreateRoom extends StatefulWidget {
  CreateRoom({Key? key,this.id,this.user_two}):super(key: key);
  final int? id;
  var user_one;
  var user_two;
  @override
  State<CreateRoom> createState() => _CreateRoomState();
}
class _CreateRoomState extends State<CreateRoom> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) { 
    Widget player_one(){
      var images = '';
      var name='';
          return StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('rooms').where('id',isEqualTo: widget.id).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                try{
                images = snapshot.data!.docs[0]['player_1.userImages'];
                name = snapshot.data!.docs[0]['player_1.name'];
                 return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if(images=='')
                             CircleAvatar(child: Text(name.substring(0,1).toUpperCase(),
                            style: TextStyle(fontSize: 25)),)
                          else
                          CircleAvatar(backgroundImage: AssetImage('acssets/avatar/$images'),radius: 30,),
                          Padding(padding: EdgeInsets.only(top: 15),
                          child: Text(name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),))],);
                }catch(e){
                  return Center(child: CircularProgressIndicator(),);
                }
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
            }
          );
    }
    Widget avatarBattle(){
      return Container(
              margin: EdgeInsets.fromLTRB(0, 80, 0, 10),
              width: MediaQuery.of(context).size.width/1.2, 
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                player_one(),
                Image(image: AssetImage("acssets/vs.png"),width: MediaQuery.of(context).size.width/4,),
                player_two()
               ],));
    }
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('rooms').where('id',isEqualTo: widget.id).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
        try{
        return Scaffold(
          appBar: AppBar(
            title: Text(''),
            leading: IconButton(onPressed: ()async{ 
              if(snapshot.data!.docs[0]['player_1.email']==_auth.currentUser!.email){
                 Navigator.pop(context);
                _firestore.collection('rooms').doc(widget.id.toString()).delete();
                }
              if(snapshot.data!.docs[0]['player_2.email']==_auth.currentUser!.email){
                Navigator.pop(context);
                await fireDb().leaveRoom(widget.id);
              }
                },
              icon: Icon(Icons.chevron_left,size: 40,)), 
             actions: [
                Padding(padding: EdgeInsets.only(right:15), child:
                IconButton(onPressed: (){}, icon: Icon(Icons.power_settings_new,size: 35,)))
              ]),
          body:  Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(child: Column(
              children: <Widget>[
                avatarBattle(),
                Text('00:00s',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Image(image: AssetImage('acssets/randomQuestion.jpg'),width:MediaQuery.of(context).size.width/3,),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 100),child: Text('Ngẫu nhiên',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),
                roomReady(snapshot.data!.docs[0]['player_1.email'], snapshot.data!.docs[0]['player_2.email'])
          ],),),decoration: Layout().background_image,),
          );
          }catch(e){
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Center(child: 
                    ElevatedButton(onPressed: () => Navigator.pop(context),child: 
                    Text('Chủ phòng đã thoát, Nhấn để thoát'),),
                    ),decoration: Layout().background_image,
            );
          }
          }
          else return Center(child: CircularProgressIndicator());
      }
    );
    }
    Widget player_two(){
           var images = '';
            var name ='';
          return StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('rooms').where('id',isEqualTo: widget.id).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                try{
                if(snapshot.data!.docs[0]['player_2.email']!=''){
                  images = snapshot.data!.docs[0]['player_2.userImages'];
                  name = snapshot.data!.docs[0]['player_2.name'];
                   return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if(images=='')
                              CircleAvatar(child: Text(name.substring(0,1).toUpperCase(),
                            style: TextStyle(fontSize: 25)),)
                          else
                          CircleAvatar(backgroundImage: AssetImage('acssets/avatar/$images'),radius: 30,),
                          Padding(padding: EdgeInsets.only(top: 15),
                          child: Text(name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),))
                          ],);
              }
            else{
              return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          if(images=='')
                             CircleAvatar(backgroundImage: AssetImage('acssets/avatar/wait.png'),radius: 30,)
                          else
                          CircleAvatar(backgroundImage: AssetImage('acssets/avatar/$images'),radius: 30,),
                          if(name=='')
                          Padding(padding: EdgeInsets.only(top: 15),
                          child: Text('?',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),))
                          else
                          Padding(padding: EdgeInsets.only(top: 15),
                          child: Text(name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),))
                          ],);
            }
            }catch(e){
              return Center(child: CircularProgressIndicator(),);
            }
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
            }
          );          
}
  Widget roomReady(String email_1,String email_2){
    String button='';
    bool flag = false;
    Function() click=(){};
    if(email_1==_auth.currentUser!.email){
        button ='Bắt đầu';
    }
    else {
      button = 'Sẵn sàng';
    }
    return Container(
                  width: MediaQuery.of(context).size.width/3,
                  height: MediaQuery.of(context).size.width/8.5,
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> QuestionBattle()));
                  }, 
                child: Text(button,style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w600),),),
                decoration: BoxDecoration(color: Colors.white,border: Border.all(width: 2),boxShadow: [BoxShadow(color: Colors.black,offset: Offset(3,3))]),);
  }
}