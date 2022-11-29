import 'package:flutter/material.dart';
import 'package:home_page/screens/TabBar/pageRank.dart';
import 'package:home_page/screens/Login/form_login_signup.dart';
import 'package:home_page/screens/Login/pageHistory.dart';
import 'package:home_page/screens/Login/page_OTP.dart';
import 'package:home_page/screens/TabBar/presonRank.dart';
import 'package:home_page/screens/TabBar/putMoney.dart';
import 'package:home_page/screens/TabBar/ranking.dart';
import 'package:home_page/screens/TabBar/setting.dart';
import 'package:home_page/screens/home.dart';

class PageDrawer extends StatefulWidget {
  const PageDrawer({super.key});

  @override
  State<PageDrawer> createState() => _PageDrawerState();
}

class _PageDrawerState extends State<PageDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(children: [
              Row(
                children: [Icon(Icons.account_circle,size: 60,), 
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text("Quang Thieu Em",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                       Padding(
                         padding: const EdgeInsets.only(right: 50),
                         child: Row(
                          children: [
                            Text("Cấp 10",style: TextStyle(fontSize: 15),),
                          ],
                      ),
                       ),
                    ],
                  ),
                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row( 
                      children:[
                   Padding(padding: EdgeInsets.only(left: 10),
                   child: Text('Rank : ',style: TextStyle(fontSize: 18),)),
                  Image(image:  AssetImage('acssets/Rank/RankBac.png'),
                  width: MediaQuery.of(context).size.width/5.5,),
                  ])),
                  Text('Điểm : 1995',style: TextStyle(fontSize: 15),)
                  ])
            ]),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text("Trang chủ",style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Home())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart_rounded ),
            title: Text("Bảng xếp hạng"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => PageRank())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.history_edu),
            title: Text("Lịch sử đấu đối kháng"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => PageRank())));
            },
          ),
          ListTile(
            leading: Icon(Icons.monetization_on_rounded),
            title: Text('Nạp tiền'),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PutMoney()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Cài đặt'),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text("Đăng xuất",style: TextStyle(fontSize: 18),),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => HomePage_Login_SignUp())));
            },
          ),
        ],
      ),
    );
  }
}
