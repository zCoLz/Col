import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  Widget rankUser(String name, int score,String rankImage, int top){
    return Column(
              children: [
                Text('Top $top',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                Image(image: AssetImage('acssets/Rank/$rankImage'),width: MediaQuery.of(context).size.width/2.2,),
                Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                Text('Điểm : $score',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),)
              ],
            );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Layout().background_image,
      child: Scaffold(appBar: AppBar(title: Text('Bảng xếp hạng'),)
      ,backgroundColor: Colors.transparent,
      drawer: PageDrawer(),
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            rankUser('Nhựt Minh', 15000, 'RankMaster.png',1),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  rankUser('Lộc', 12000, 'RankMaster.png',2),
                  rankUser('ABC', 10000, 'RankMaster.png',3),
                ],
              ),
            )
          ],
        ),
      ),
      ),
    );
  }
}