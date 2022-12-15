import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/screens/GamePlay/difficult.dart';

class Level extends StatefulWidget {
  Level({super.key,required this.index});
  int index;
  @override
  State<Level> createState() => _LevelStateState();
}

class _LevelStateState extends State<Level> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('subjects').orderBy('id').snapshots(),
      builder: (context, snapshot) {
        try{
          final subject = snapshot.data!.docs;
        return StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('users').where('email',isEqualTo: _auth.currentUser!.email).snapshots(),
          builder: (context, snapshot) {
            try{
            return TextButton(
                onPressed: (() {
                  if (snapshot.data!.docs[0]['chapter']>widget.index) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: ((context) => Difficult(idSubject: subject[widget.index]['id'],))));
                  }
                  else{
                    showDialog(context: context, builder: (context) => AlertDialog(
                      title: const Text('Bạn chưa mở khóa màn trước đó'),
                      actions: [
                        ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                          },child: const Center(child: Text('OK')))
                      ],
                    ));
                  }
                }),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image(
                        image: AssetImage('acssets/subject/${subject[widget.index]['subjectImage']}'),
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if(snapshot.data!.docs[0]['chapter']<=widget.index)
                                  const Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                Text(
                                  subject[widget.index]['title'],
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ]))
                    ],
                  ),
                ));
          }catch(e){
            return const Center(child: CircularProgressIndicator(),);
          }
          }
        );
            }catch(e){
              return const Center(child: CircularProgressIndicator(),);
            }
      }
    );
  }
}
