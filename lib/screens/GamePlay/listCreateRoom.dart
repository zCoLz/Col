import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/GamePlay/questionBattle.dart';
class CreateRoom extends StatefulWidget {
  const CreateRoom({Key? key,this.id}):super(key: key);
  final String? id;
  @override
  State<CreateRoom> createState() => _CreateRoomState();
}
class _CreateRoomState extends State<CreateRoom> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) { 
    Widget player_one(){
      String images='';
      String name ='';
      return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').where('email',isEqualTo: _auth.currentUser!.email).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            images = snapshot.data!.docs[0]['userImages'];
            name = snapshot.data!.docs[0]['name'];
          }
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
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(onPressed: (){ 
          _firestore.collection('room').doc(widget.id).delete();
          Navigator.pop(context);}, icon: Icon(Icons.chevron_left,size: 40,)), 
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
            Container(
              width: MediaQuery.of(context).size.width/3,
              height: MediaQuery.of(context).size.width/8.5,
              child: TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionBattle()));
              }, 
            child: Text('Bắt đầu',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w600),),),
            decoration: BoxDecoration(color: Colors.white,border: Border.all(width: 2),boxShadow: [BoxShadow(color: Colors.black,offset: Offset(3,3))]),)
      ],),),decoration: Layout().background_image,),
      );
    }
    Widget player_two(){
      String images='';
      String name ='';
      return StreamBuilder<QuerySnapshot>(
        stream: null,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            images = snapshot.data!.docs[0]['userImages'];
            name = snapshot.data!.docs[0]['name'];
          }
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
      );    
    }
}