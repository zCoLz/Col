
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/TabBar/battleHistory.dart';
import 'package:home_page/screens/home.dart';

class QuestionBattle_2 extends StatefulWidget {
  QuestionBattle_2({super.key,required this.id});
  int id;
  @override
  State<QuestionBattle_2> createState() => _QuestionBattleState();
}

class _QuestionBattleState extends State<QuestionBattle_2> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Widget buttonAnswer(String title) {
      return Container(
        height: MediaQuery.of(context).size.height/16,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: TextButton(
          
            style: TextButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width/1.2, 35)),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => BattleHistory()));
            },
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 17),
            )),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            border: Border.all(width: 1),
            ),
      );
    }
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('rooms').where('id',isEqualTo: widget.id).snapshots(),
      builder: (context, snapshot) {
        try{
        return Container(
            decoration: Layout().background_image,
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    'Sport',
                    style: TextStyle(
                        color: Color.fromARGB(255, 55, 55, 55),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: IconButton(
                      onPressed: () async{
                       try{
                        Future.delayed(Duration.zero,()async{
                          Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
                        await fireDb().getPlay(widget.id,false);
                        await fireDb().leaveRoom(widget.id);
                        });
                      //await fireDb().leaveRoom(widget.id);
                      }catch(e){ 
                         Center(child: CircularProgressIndicator(),);}
                          
                      },
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 40,
                      )),
                ),
                body: Container(
                  child: Column(
                    children: <Widget>[
                       Expanded( 
                        child: Container( 
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.fromLTRB(20, 20, 20,5),
                          child: 
                        Column(
                          children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                            Column(
                              children: [
                                Text("Điểm : ${snapshot.data!.docs[0]['player_1.score']}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0) ,child:Icon(Icons.account_circle,size: 80,)),
                                Text(snapshot.data!.docs[0]['player_1.name'],style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),)
                              ],
                            ),
                            Image(image: AssetImage("acssets/vs.png"),width: MediaQuery.of(context).size.width/4,)
                            ,
                            Column(
                              children: [
                                Text("Điểm : ${snapshot.data!.docs[0]['player_2.score']}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0) ,child:Icon(Icons.account_circle,size: 80,)),
                                Text(snapshot.data!.docs[0]['player_2.name'],style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),)
                              ]),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 30, 0, 50),
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                              buttonAnswer('Đáp án 1'),
                              buttonAnswer('Đáp án 2'),
                              buttonAnswer('Đáp án 3'),
                              buttonAnswer('Đáp án 4')
                        ]),)
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child:
                    Row(
                    children: [
                    Expanded(child: Row(children: [
                      Text(
                        'Thời gian : 30s',
                         style: TextStyle(fontSize: 20),
                          )
                    ],)),
                   IconButton(onPressed: (){}, icon: Icon(Icons.info_sharp,size: 40,))
                  ],))
                    ],
                  ),
                )));
      }catch(e){
        return Center(child: CircularProgressIndicator(),);
      }
      }
    );
  }
}