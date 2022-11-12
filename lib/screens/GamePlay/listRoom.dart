import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/GamePlay/searchBattle.dart';

class listRoom extends StatefulWidget{
    listRoom({super.key});

    @override
    State<listRoom> createState()=> _listRoomState();
}

class _listRoomState extends State<listRoom>{
  @override
  Widget build(BuildContext context) {
    Widget content(String title){
      return  Container(
        width: MediaQuery.of(context).size.width/1.2,
        height: MediaQuery.of(context).size.width/10,
        margin: EdgeInsets.all(10),
        child: TextButton(onPressed: (){}, child: Align(alignment: Alignment.centerLeft, child: Text(title,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),),),),
        decoration: BoxDecoration(border: Border.all(width: 3)),
      );
    }           
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
                Container(
                  width: MediaQuery.of(context).size.width/1.2,
                  height: MediaQuery.of(context).size.height/2.3,
                  child: SingleChildScrollView(
                  child: Column(
                    children: [
                      content('Phòng 1'),
                      content('Phòng 2'),
                      content('Phòng 3'),
                      content('Phòng 4'),
                      content('Phòng 5'),
                      content('Phòng 6'),
                      content('Phòng 7'),
                      content('Phòng 8'),
                      content('Phòng 9'),
                    ],
                  ),
                )
                ,decoration: BoxDecoration(border: Border.all(width: 3)),)
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
              onPressed: (){}, 
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
  }
}