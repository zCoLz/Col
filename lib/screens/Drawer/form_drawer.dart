import 'package:flutter/material.dart';
import 'package:home_page/components/home_page.dart';
import 'package:home_page/screens/Drawer/pageRank.dart';
import 'package:home_page/screens/Login/form_login_signup.dart';
import 'package:home_page/screens/Login/page_OTP.dart';
import 'package:home_page/screens/Login/page_login.dart';
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
                            Text("Quang THieu U",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                       Padding(
                         padding: const EdgeInsets.only(right: 75),
                         child: Row(
                          children: [
                            Text("Cấp 0",style: TextStyle(fontSize: 15),),
                          ],
                      ),
                       ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text("Trang chủ"),
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
                  MaterialPageRoute(builder: ((context) => PageOTP())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text("Đăng xuất"),
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
