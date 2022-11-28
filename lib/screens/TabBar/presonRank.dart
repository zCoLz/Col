import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PresonalRank extends StatefulWidget {
  const PresonalRank({super.key});

  @override
  State<PresonalRank> createState() => _PersonalRankState();
}

class _PersonalRankState extends State<PresonalRank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Layout().background_image,
      child: Scaffold(
        backgroundColor: Colors.transparent,appBar: AppBar(
        title: Text('Rank cá nhân'),),
         drawer: PageDrawer(),
         body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/6),
            child: Column(
              children: [
                Image(image: AssetImage('acssets/Rank/RankBac.png')),
                Text('Quang thieu Em',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Padding(padding: EdgeInsets.all(20) ,
                  child: Text('Điểm : 1995',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),))
              ],
            ),
         ),
         ),
    );
  }
}