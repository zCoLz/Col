import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/components/levelDesign.dart';

class LevelList extends StatefulWidget {
  LevelList({super.key});
  @override
  State<LevelList> createState() => _LevelListStateState();
}
class _LevelListStateState extends State<LevelList> {
    final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, snapshot) {
        try{
        return Scaffold(
            appBar: AppBar(
                title: Text(''),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      size: 40,
                    )),
                actions: [
                  Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.power_settings_new,
                            size: 35,
                          )))
                ]),
            body: Container(decoration: Layout().background_image,
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: GridView.builder(
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Level(index: index);
                  },
                )));
      }catch(e){
        return Center(child: CircularProgressIndicator(),);
      }
      }
    );
  }
}
