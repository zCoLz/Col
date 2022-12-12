import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/GamePlay/questionBattle.dart';
import 'package:home_page/screens/GamePlay/questionBattle_2.dart';
class CreateRoom extends StatefulWidget {
  CreateRoom({Key? key,required this.id,this.user_two}):super(key: key);
  final int id;
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
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text('Chủ phòng',style: TextStyle(fontSize: 15),),
                          ),
                          if(images=='')
                             CircleAvatar(radius: 28,child: Text(name.substring(0,1).toUpperCase(),
                            style:const TextStyle(fontSize: 30),),)
                          else
                          CircleAvatar(backgroundImage: AssetImage('acssets/avatar/$images'),radius: 30,),
                          Padding(padding: const EdgeInsets.only(top: 15),
                          child: Text(name,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),))],);
                }catch(e){
                  return const Center(child: CircularProgressIndicator(),);
                }
            }
            else{
              return const Center(child: CircularProgressIndicator(),);
            }
            }
          );
    }
    Widget avatarBattle(){
      return Container(
              margin: const EdgeInsets.fromLTRB(0, 80, 0, 10),
              width: MediaQuery.of(context).size.width/1.2, 
              child: Row(
              crossAxisAlignment:  CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                player_one(),
                Image(image: const AssetImage("acssets/vs.png"),width: MediaQuery.of(context).size.width/4,),
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
            title: const Text(''),
            leading: IconButton(onPressed: ()async{ 
              if(snapshot.data!.docs[0]['player_1.email']==_auth.currentUser!.email){
                 Navigator.pop(context);
                _firestore.collection('rooms').doc(widget.id.toString()).delete();
                }
              if(snapshot.data!.docs[0]['player_2.email']==_auth.currentUser!.email){
                if(snapshot.data!.docs[0]['player_2.ready']) {
                  return showDialog(context: context, builder: (context){
                          return AlertDialog(
                                //title: Text("Save and Exit ?"),
                                content: const Text("Bạn đang sẵn sàng không thể thoát"),
                                actions: [
                                  Center(child : ElevatedButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: const Text('OK')))
                                ],
                              );
                        });
                }
                Navigator.pop(context);
                await fireDb().leaveRoom(widget.id);
              }},
              icon: const Icon(Icons.chevron_left,size: 40,)), 
             actions: [
                Padding(padding: const EdgeInsets.only(right:15), child:
                IconButton(onPressed: (){}, icon: const Icon(Icons.power_settings_new,size: 35,)))
              ]),
          body:  Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,decoration: Layout().background_image,
            child: SingleChildScrollView(child: Column(
              children: <Widget>[
                avatarBattle(),
                //Text('00:00s',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Image(image:const AssetImage('acssets/randomQuestion.jpg'),width:MediaQuery.of(context).size.width/2.5,),
                const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 100),child: Text('Ngẫu nhiên',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),),
                roomReady(snapshot.data!.docs[0]['player_1.email'], snapshot.data!.docs[0]['player_2.email'])
          ],),),),
          );
          }catch(e){
            return Container(
              width: MediaQuery.of(context).size.width,decoration: Layout().background_image,
              child: Center(child: 
                    ElevatedButton(onPressed: () => Navigator.pop(context),child: 
                    const Text('Chủ phòng đã thoát, Nhấn để thoát'),),
                    ),
            );
          }
          }
          else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
    }
    Widget player_two(){
          var images = '';
          var name ='';
          var ready ='Chưa sẵn sàng';
          return StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('rooms').where('id',isEqualTo: widget.id).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                try{
                if(snapshot.data!.docs[0]['player_2.email']!=''){
                  images = snapshot.data!.docs[0]['player_2.userImages'];
                  name = snapshot.data!.docs[0]['player_2.name'];
                  if(snapshot.data!.docs[0]['player_2.ready']){
                    ready = 'Sẵn sàng';
                  }
                   return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(ready,style: const TextStyle(fontSize: 15),textAlign: TextAlign.center,),
                          ),
                          if(images=='')
                              CircleAvatar(child: Text(name.substring(0,1).toUpperCase(),
                            style: const TextStyle(fontSize: 25)),)
                          else
                          CircleAvatar(backgroundImage: AssetImage('acssets/avatar/$images'),radius: 30,),
                          Padding(padding: const EdgeInsets.only(top: 15),
                          child: Text(name,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),)),
                          ],);
              }
            else{
              return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text('Trống',style: TextStyle(fontSize: 15),),
                          ),
                          if(images=='')
                            const CircleAvatar(backgroundImage: AssetImage('acssets/avatar/wait.png'),radius: 30,)
                          else
                          CircleAvatar(backgroundImage: AssetImage('acssets/avatar/$images'),radius: 30,),
                          if(name=='')
                          const Padding(padding: EdgeInsets.only(top: 15),
                          child: Text('?',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),))
                          else
                          Padding(padding: const EdgeInsets.only(top: 15),
                          child: Text(name,style:const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),))
                          ],);
            }
            }catch(e){
              return const Center(child: CircularProgressIndicator(),);
            }
            }
            else{
              return const Center(child: CircularProgressIndicator(),);
            }
            }
          );          
}
  Widget roomReady(String email_1,String email_2){
    String button = '';
    bool page=false;
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('rooms').where('id',isEqualTo: widget.id).snapshots(),
      builder: (context, snapshot) {
        try{
        bool check =  snapshot.data!.docs[0]['player_2.ready'];
        bool play = snapshot.data!.docs[0]['player_1.ready'];
        try{
        if(play && check && email_2==_auth.currentUser!.email){
        Future.delayed(Duration.zero, () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionBattle_2(id: widget.id,)));
        });}
        }catch(e){
          print(e);
        }
        if(email_1==_auth.currentUser!.email){
          button ='Bắt đầu';
    }
    else {
      if(snapshot.data!.docs[0]['player_2.ready']==false){
          button = 'Sẵn sàng';
      }else{
        button = 'Đã sẳn sàng';
      }
    }
        return Container(
                      width: MediaQuery.of(context).size.width/3,
                      height: MediaQuery.of(context).size.width/8.5,
                    decoration: BoxDecoration(color: Colors.white,border: Border.all(width: 2),boxShadow: [BoxShadow(color: Colors.black,offset: Offset(3,3))]),
                      child: TextButton(
                        style: TextButton.styleFrom(foregroundColor: Colors.black),
                      onPressed: ()async{
                       if(email_1==_auth.currentUser!.email && check){
                           await fireDb().getPlay(widget.id,true);
                       }
                       else if(email_2==_auth.currentUser!.email){
                        await fireDb().getReady(widget.id,check);
                       }else if(email_1==_auth.currentUser!.email && snapshot.data!.docs[0]['player_2.email']==''){
                        return showDialog(context: context, builder: (context){
                          return AlertDialog(
                                //title: Text("Save and Exit ?"),
                                content: const Text("Chưa có Đối thủ"),
                                actions: [
                                  Center(child: ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ))
                                ],
                              );
                        });
                       }
                       else{
                        return showDialog(context: context, builder: (context){
                          return AlertDialog(
                                //title: Text("Save and Exit ?"),
                                content: const Text("Đối thủ chưa sẵn sàng"),
                                actions: [
                                  FloatingActionButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: const Center(child: Text('OK')),
                                  ),
                                ],
                              );
                        });
                       }
                      }, 
                    child: Text(button,style: const TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w600),),),);
      }catch(e){
        return const Center(child: CircularProgressIndicator(),);
      }
      }
    );
  }
}