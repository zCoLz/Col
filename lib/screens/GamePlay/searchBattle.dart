import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/GamePlay/questionBattle.dart';
class SearchBattle extends StatefulWidget {
  const SearchBattle({super.key});
  @override
  State<SearchBattle> createState() => _searchBattleState();
}
class _searchBattleState extends State<SearchBattle> {
  @override
  Widget build(BuildContext context) { 
    Widget avatar(String images,String userName){
      return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(backgroundImage: AssetImage('acssets/avatar/$images'),radius: 30,),
                  Padding(padding: EdgeInsets.only(top: 15),
                  child: Text(userName,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),))],);    
    }
    Widget avatarBattle(){
      return Container(
              margin: EdgeInsets.fromLTRB(0, 80, 0, 10),
              width: MediaQuery.of(context).size.width/1.2, 
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                avatar('minhdeptrai.jpg', 'Minh đẹp trai'),
                Image(image: AssetImage("acssets/vs.png"),width: MediaQuery.of(context).size.width/4,),
                avatar('quangthieuU.jpg', 'Quang thieu U'),
               ],));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(onPressed: (){ Navigator.pop(context);}, icon: Icon(Icons.chevron_left,size: 40,)), 
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
            Text('00:10s',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
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
}