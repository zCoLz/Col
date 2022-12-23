
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/GamePlay/listCreateRoom.dart';
import 'package:home_page/screens/GamePlay/searchBattle.dart';
import 'package:home_page/screens/home.dart';

class listRoom extends StatefulWidget{
    listRoom({super.key});

    @override
    State<listRoom> createState()=> _listRoomState();
}

class _listRoomState extends State<listRoom>{
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
   //String rank='';
  @override
  Widget build(BuildContext context) {
    TextEditingController txtSearchRoom = TextEditingController();
    Widget content(String title,int status, Function? on()){
      return  Container(
        width: MediaQuery.of(context).size.width/1.2,
        height: MediaQuery.of(context).size.width/10,
        margin: EdgeInsets.all(10),
        child: TextButton(onPressed: on, child: Align(alignment: Alignment.centerLeft, child: Row(
          children: [
           Expanded(child: Text(title,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),),),
            Text('$status/2')
          ],
        ),),),
        decoration: BoxDecoration(border: Border.all(width: 3)),
      );
    }  
      return StreamBuilder(
        stream: _firestore.collection('users').where('email',isEqualTo: _auth.currentUser!.email).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
          var user = snapshot.data!.docs;
          /* if(rank==''){
            var rankOld = user[0];
                Future.delayed(Duration.zero,()async{
                rank = await fireDb().setRank(user[0]['rankScore']);
                await fireDb().setLevel(user[0]['exp']);
                  if(rank!=rankOld['rank']){
                   return showDialog(context: context, builder: (context)=>
                    AlertDialog(
                      title: Text('Rank hiện tại của bạn là : '),
                      content: Image(image: AssetImage('acssets/Rank/$rank'),width: MediaQuery.of(context).size.width/3,),
                      actions: [
                        ElevatedButton(onPressed: (){
                          Navigator.pop(context); 
                        }, child: Text('Ok'))
                      ],
                    ));
                  }
                });
              } */
          return Container(
            decoration: Layout().background_image,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              appBar: AppBar(title: Text(''),
              leading: IconButton(onPressed: (){
                Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context)=>Home()), (route) => false);
              }, icon: Icon(Icons.chevron_left,size: 40,),),
              actions: [
                 Padding(padding: EdgeInsets.only(right:15), child:
                  IconButton(onPressed: (){}, icon: Icon(Icons.power_settings_new,size: 35,)))
              ],),
              body: Column(children: [
                 Expanded(child:  Column(
                children: [ Container(
                  margin: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width/1.1,
                  height: MediaQuery.of(context).size.height/1.8,
                  child: Column(children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Text('Danh sách phòng',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                        decoration: BoxDecoration(border: Border.all(width: 3)),
                      ),
                      StreamBuilder(
                        stream: _firestore.collection('rooms')
                              //.where('battling', isEqualTo: false)
                              .where('player_1.email',isNotEqualTo: _auth.currentUser!.email)
                              .snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                          return Container(
                            width: MediaQuery.of(context).size.width/1.2,
                            height: MediaQuery.of(context).size.height/2.3,
                            child:ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var id = snapshot.data!.docs[index]['id'];
                                var status = snapshot.data!.docs[index]['status'];
                                return  content('Phòng $id',status, ()
                                {
                                  var user_2 = {
                                  'email' : _auth.currentUser!.email,
                                  'name' : user[0]['name'],
                                  'userImages' : user[0]['userImages']
                                };
                                if(status==2){
                                  showDialog(context: context, builder: (context)=>
                                  AlertDialog(
                                    title: Text('Phòng đầy người'),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      }, child: Text('Ok'))
                                    ],
                                  ));
                                }else{
                                  fireDb().joinRoom(id,user_2);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateRoom(id: id,user_two: user_2,)));
                                }
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
              margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white,border: Border.all(width: 2),boxShadow: [BoxShadow(color: Colors.black,offset: Offset(3,3))]),
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
                  child: const Text('Tạo phòng',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w600),),),),
                   Container(
              width: MediaQuery.of(context).size.width/3.1,
              height: MediaQuery.of(context).size.width/9,
              margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white,border: Border.all(width: 2),boxShadow: [BoxShadow(color: Colors.black,offset: Offset(3,3))]),
              child: TextButton(
                      style: TextButton.styleFrom(foregroundColor: Colors.black),
                    onPressed: () {
                      showDialog(context: context, builder: (context) => AlertDialog(
                        title: const Center(child: Text('Tìm phòng')),
                         actions: [
                                    Column(
                                      children: [
                                        TextField(keyboardType: TextInputType.number,
                                          controller: txtSearchRoom,
                                          decoration: const InputDecoration(border: OutlineInputBorder(),),
                                        ),
                                        Center(child : ElevatedButton(onPressed: ()async{
                                          try{
                                          if(txtSearchRoom.text==''){
                                            showDialog(context: context, builder: (context)=>
                                            AlertDialog(
                                              content: const Text('Vui lòng không bỏ trống'),
                                              actions: [
                                                TextButton(onPressed: (){
                                                  Navigator.pop(context);
                                                }, child: const Text('Ok'))
                                              ],
                                            ));
                                          }else{
                                          var id =int.parse(txtSearchRoom.text);
                                          if(await fireDb().getRoom(id)){
                                            var user_2 = {
                                              'email' : _auth.currentUser!.email,
                                              'name' : user[0]['name'],
                                              'userImages' : user[0]['userImages']
                                              };
                                              fireDb().joinRoom(id,user_2);
                                              txtSearchRoom.clear();
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateRoom(id: id,user_two: user_2,)));
                                          }else{
                                            showDialog(context: context, builder: (context)=>
                                            AlertDialog(
                                              content: const Text('Không tìm thấy'),
                                              actions: [
                                                TextButton(onPressed: (){
                                                  Navigator.pop(context);
                                                }, child: const Text('Ok'))
                                              ],
                                            ));
                                          }
                                          }}catch(e){
                                            showDialog(context: context, builder: (context){
                                              return AlertDialog(
                                                content: const Text('Có lỗi xảy ra'),
                                                actions: [
                                                  Center(child: ElevatedButton(onPressed: () {
                                                    Navigator.pop(context);
                                                  },child: const Text('Ok'),))
                                                ],
                                              );
                                            });
                                          }
                                        }, child: const Text('Tìm'))),
                                      ],
                                    )
                                  ],
                      ));
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchBattle()));
                    }, 
                  child: const Text('Tìm phòng',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w600),),),),
                  ],
                ),])),Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Row(
                      children: [
                      Expanded(child: Row(children: const [
                        Icon(Icons.monetization_on_rounded,color: Colors.yellow,size: 30,),
                        Text('100',style: TextStyle(fontSize: 18),),
                        Padding(padding: EdgeInsets.only(left: 15)),
                        Icon(Icons.diamond_rounded,size: 30,color: Colors.red,),
                        Text('100',style: TextStyle(fontSize: 18),)
                      ],)),
                      const Icon(Icons.info_sharp,size: 40,)
                    ],))]),
            ));
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
        }
      );
  }
}