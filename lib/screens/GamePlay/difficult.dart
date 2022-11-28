import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/GamePlay/question.dart';

class Difficult extends StatefulWidget {
  const Difficult({super.key});

  @override
  State<Difficult> createState() => _DifficultState();
}

class _DifficultState extends State<Difficult> {
  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: Layout().background_image,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 40,
                  )),
            ),
            body: Container(
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 0, 40),
                    child: Text('Chủ đề : Công nghệ thông tin',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                    image: AssetImage('acssets/level/title1.jpg'),
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.width / 2.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:30),
                      child: Text('Ải 1',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20,top: 50),
              width: MediaQuery.of(context).size.width/2.7,
              height: MediaQuery.of(context).size.width/8.5,
              child: TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Question()));
              }, 
            child: Text('Dễ',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600),),),
            decoration: BoxDecoration(color: Colors.blue,border: Border.all(width: 2),boxShadow: [BoxShadow(color: Colors.black,offset: Offset(3,3))]),),
            Container(
              margin: EdgeInsets.only(bottom: 20,top: 20),
              width: MediaQuery.of(context).size.width/2.7,
              height: MediaQuery.of(context).size.width/8.5,
              child: TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Question()));
              }, 
            child: Text('Trung bình',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600),),),
            decoration: BoxDecoration(color: Colors.blue,border: Border.all(width: 2),boxShadow: [BoxShadow(color: Colors.black,offset: Offset(3,3))]),),
            Container(
              margin: EdgeInsets.only(bottom: 20,top: 20),
              width: MediaQuery.of(context).size.width/2.7,
              height: MediaQuery.of(context).size.width/8.5,
              child: TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.black),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Question()));
              }, 
            child: Text('Khó',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600),),),
            decoration: BoxDecoration(color: Colors.blue,border: Border.all(width: 2),boxShadow: [BoxShadow(color: Colors.black,offset: Offset(3,3))]),)
                      ],
                    ),
                  )
                ],
              ),
            )
    ));
  }
}