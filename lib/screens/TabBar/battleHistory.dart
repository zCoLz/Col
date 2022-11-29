
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';

class BattleHistory extends StatefulWidget {
  const BattleHistory({super.key});

  @override
  State<BattleHistory> createState() => _BattleHistoryState();
}

class _BattleHistoryState extends State<BattleHistory> {
  Widget user(int score,String name, String question,int result){
    Color colors = Colors.red;
    String battle = 'Thua';
    if(result==1){
      setState(() {
        colors = Colors.blue;
        battle = 'Thắng';
      });
    }else {
      setState(() {
        colors = Colors.red;
        battle = 'Thua';
      });
    }
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width/3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text('Điểm : $score',style: TextStyle(fontSize: 18),),
                      ),
                      Icon(Icons.account_circle,size: 80,),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,bottom: 20),
                        child: Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                      Text(question,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(battle,style: TextStyle(color: colors,fontSize: 17,fontWeight: FontWeight.w600),),
                      )
                    ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Layout().background_image,
      child: Scaffold(appBar: AppBar(title: Text('Lịch sử đấu đối kháng'),
     ),backgroundColor: Colors.transparent,
     body: Container(
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/6,horizontal: 13),
      width: MediaQuery.of(context).size.width/1.1,
      height: MediaQuery.of(context).size.height/2.2,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          border: Border.all(width: 3)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                user(100, 'Nhựt Minh', '10/10', 1),
                Image(image: AssetImage('acssets/vs.png'),width: MediaQuery.of(context).size.width/6,),
                 user(60, 'Quang thieu Em', '6/10', 0)
              ],
            )
          ],
        ),
     ),),
    );
  }
}