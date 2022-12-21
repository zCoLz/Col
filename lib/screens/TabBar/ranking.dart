import 'package:cloud_firestore/cloud_firestore.dart';
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
                Image(image: AssetImage('acssets/Rank/$rankImage'),width: MediaQuery.of(context).size.width/2.4,),
                Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                Text('Điểm : $score',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),)
              ],
            );
  }
  @override
  Widget build(BuildContext context) {
    final _fireStore = FirebaseFirestore.instance;
    return Container(
      decoration: Layout().background_image,
      child: Scaffold(appBar: AppBar(title: Text('Top xếp hạng'),)
      ,backgroundColor: Colors.transparent,
      drawer: PageDrawer(),
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('users').orderBy('rankScore',descending: true).snapshots(),
              builder: (context, snapshot) {
                try{
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }
                var user = snapshot.data!.docs;
               return Column(
                children: [
                rankUser(user[0]['name'],user[0]['rankScore'], user[0]['rank'],1),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  rankUser(user[1]['name'],user[1]['rankScore'], user[1]['rank'],2),
                  rankUser(user[2]['name'],user[2]['rankScore'], user[2]['rank'],3),
                ],
              ),
            )
          ]);
          }catch(e){
            return Center(child: Text('Chưa có xếp hạng'),);
          }
          }
        ),
      ),
      ),
    );
  }
}