import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/GamePlay/listRoom.dart';

class BattleResult_1 extends StatefulWidget {
  BattleResult_1({super.key,required this.id});
  int id;
  @override
  State<BattleResult_1> createState() => _BattleResultState();
}
String battle = 'Thua';
class _BattleResultState extends State<BattleResult_1> {
  final _fireStore = FirebaseFirestore.instance;
  Widget user(int score, String name, int? result) {
    Color colors = Colors.red;
    if (result == 1) {
        colors = Colors.blue;
        battle = 'Thắng';
    } else if(result==0) {
        colors = Colors.red;
        battle = 'Thua';
    }else if(result==2){
      colors = Colors.amber;
      battle='Hòa';
    }
    else{
      colors = Colors.green;
      battle='';
    }
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
          Icon(
            Icons.account_circle,
            size: 80,
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
          ),
        ],
      ),
    );
  }
int count=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Layout().background_image,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Lịch sử đấu đối kháng'),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6, horizontal: 13),
          width: MediaQuery.of(context).size.width / 1.1,
          height: MediaQuery.of(context).size.height / 2.2,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              border: Border.all(width: 3)),
          child: StreamBuilder<QuerySnapshot>(
            stream: _fireStore.collection('rooms')
            .where('id',isEqualTo: widget.id).snapshots(),
            builder: (context, snapshot) {
              try{
              var rooms = snapshot.data!.docs[0];
              if(!rooms['player_2.ready'] && !rooms['player_1.ready']){
                fireDb().updateResult(widget.id,rooms['player_1.score'], rooms['player_2.score']);
              }
              if(rooms['player_1.result']!=null && rooms['player_2.result']!=null && rooms['battling']){
                var battle = {
                  'created' : rooms['created'],
                  'player_1' :{
                    'email' : rooms['player_1.email'],
                    'name' : rooms['player_1.name'],
                    'score' : rooms['player_1.score'],
                    'result':rooms['player_1.result']
                  },
                   'player_2' :{
                    'email' : rooms['player_2.email'],
                    'name' : rooms['player_2.name'],
                    'score' : rooms['player_2.score'],
                    'result':rooms['player_2.result']
                  },
                };
                fireDb().createBattleHistories(battle);
                String title='Chúc mừng bạn! Bạn đã thắng';
                int money = 200;
                int coin =400;
                int rankScore =20;
                int exp =200;
                String rank= '+20';
                Future.delayed(Duration.zero,(){
                  if(rooms['player_1.result']==0){
                    title = 'Bạn đã thua. Hãy cố gắng lần sau';
                    money=100;
                    coin=200;
                    rankScore=-10;
                    exp = 100;
                    rank = '-10';
                }else if(rooms['player_1.result']==2){
                  title = 'Hòa. Hãy cố nhé';
                    money=150;
                    coin=250;
                    rankScore=10;
                    exp = 150;
                    rank = '+10';
                }
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: Text(title),
                      content: SizedBox(
                        height: MediaQuery.of(context).size.width/3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text('+$money'),
                              const Icon(Icons.diamond_rounded,size: 30,color: Colors.red,),
                            ],),
                            Row(
                              children: [
                                Text('+$coin'),
                              const Icon(Icons.monetization_on_rounded,color: Colors.yellow,size: 30,),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text('$rank điểm rank'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text('+$exp điểm kinh nghiệm'),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text('Ok'))
                      ],
                    );
                  });
                });
              }
              
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        user(rooms['player_1.score'], rooms['player_1.name'],rooms['player_1.result']),
                      Image(
                        image: const AssetImage('acssets/vs.png'),
                        width: MediaQuery.of(context).size.width / 6,
                      ),
                        user(rooms['player_2.score'], rooms['player_2.name'], rooms['player_2.result']),
                    ],
                  ),
                  if(rooms['player_2.ready'] || rooms['player_1.ready'])
                          Column(children: const [
                            CircleAvatar(backgroundImage: AssetImage('acssets/avatar/waiting.gif'),radius: 20,),
                            Text('Đang chờ')
                          ],)
                  else
                    TextButton(
                      onPressed: ()async{
                        if(rooms['battling']){
                         await fireDb().deleteRoom(widget.id, false);
                        }
                        else{
                          await fireDb().deleteRoom(widget.id, true);
                        }
                        Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context)=>listRoom()), (route) => false);
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue))
                    , child: const Text('Trở về',style: TextStyle(color: Colors.white),))
                ],
              );
            }catch(e){
              return Center(child: CircularProgressIndicator(),);
            }
            }
          ),
        ),
      ),
    );
  }
}
