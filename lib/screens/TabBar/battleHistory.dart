import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/dbContext.dart';

class BattleHistory extends StatefulWidget {
  BattleHistory({super.key,required this.id});
  final int id;
  @override
  State<BattleHistory> createState() => _BattleHistoryState();
}

class _BattleHistoryState extends State<BattleHistory> {
  final _fireStore = FirebaseFirestore.instance;
  Widget HistoryView(int score, String name,String email,int result) {
    Color colors = Colors.red;
    String battle = 'Thua';
    final query = _fireStore.collection('users').where('email',isEqualTo: email).snapshots();
    if (result == 1) {
        colors = Colors.blue;
        battle = 'Thắng';
    } else if(result==0) {
        colors = Colors.red;
        battle = 'Thua';
    }else{
       colors = Colors.amber;
        battle = 'Hòa';
    }
    return StreamBuilder<QuerySnapshot>(
      stream: query,
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        String image = snapshot.data!.docs[0]['userImages'];
        return Container(
          margin: const EdgeInsets.only(top: 30),
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'Điểm : $score',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
             if (image == '')
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: CircleAvatar(
                      radius: 25,
                      child: Text(name.substring(0, 1).toUpperCase(),
                          style: const TextStyle(fontSize: 30)),
                    ))
              else
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('acssets/avatar/$image'),
                    radius: 30,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              /* Text(
                'Rank',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ), */
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  battle,
                  style: TextStyle(
                      color: colors, fontSize: 17, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Layout().background_image,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lịch sử đấu đối kháng'),
        ),
        backgroundColor: Colors.transparent,
        body: StreamBuilder<QuerySnapshot>(
          stream: _fireStore.collection('battleHistoreis').where('id',isEqualTo: widget.id).snapshots(),
          builder: (context, snapshot) {
            try{
              if(!snapshot.hasData)
                 return Center(child: CircularProgressIndicator(),); 
            final user = snapshot.data!.docs[0];
            return Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 6, horizontal: 13),
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 2.2,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  border: Border.all(width: 3)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HistoryView(user['player_1.score'], user['player_1.name'],user['player_1.email'],user['player_1.result']),
                      Image(
                        image: const AssetImage('acssets/vs.png'),
                        width: MediaQuery.of(context).size.width / 6,
                      ),
                      HistoryView(user['player_2.score'], user['player_2.name'],user['player_2.email'],user['player_2.result']),
                    ],
                  ),
                  Padding(padding: const EdgeInsets.all(30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right :8.0),
                            child: Icon(Icons.alarm_outlined,size: 30,),
                          ),
                          Text(user['created'].toString().substring(0,19),
                          style: TextStyle(fontSize: 20),),
                        ],
                      ),)
                ],
              ),
            );
          }catch(e){
            return //Center(child: Text('Có lỗi xảy ra'),);
            Text(e.toString());
          }
          }
        ),
      ),
    );
  }
}
