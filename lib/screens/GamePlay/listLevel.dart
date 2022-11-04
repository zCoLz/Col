import 'package:flutter/material.dart';
import 'package:home_page/components/home_page.dart';
import 'package:home_page/model/dbContext.dart';

class LevelList extends StatefulWidget{
  LevelList({super.key});
  @override
  State<LevelList> createState() => _LevelListStateState();
}

class _LevelListStateState extends State<LevelList>{
  @override
  Widget build(BuildContext context) {
          DbContext().createLevel();
      return Scaffold(
        appBar: AppBar(
        title: Text(''),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        }, icon: Icon(Icons.chevron_left,size: 40,)), 
         actions: [
            Padding(padding: EdgeInsets.only(right:15), child:
            IconButton(onPressed: (){
            }, icon: Icon(Icons.power_settings_new,size: 35,)))
          ]),
          backgroundColor: Colors.cyan.shade300,
          body: Container(
            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: DbContext.lstLevel.length,
            itemBuilder: (context, index) {
                return DbContext.lstLevel[index];
            },
          ))
      );
  }
}