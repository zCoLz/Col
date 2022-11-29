import 'package:flutter/material.dart';
import 'package:home_page/components/home_page.dart';
import 'package:home_page/screens/Drawer/pageRank.dart';
import 'package:home_page/screens/Login/form_login_signup.dart';
import 'package:home_page/screens/Login/pageHistory.dart';
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
                            Text("Quang THieu U",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                       Padding(
                         padding: const EdgeInsets.only(right: 50),
                         child: Row(
                          children: [
                            Text("Cấp 0",style: TextStyle(fontSize: 18),),
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
            title: Text("Trang chủ",style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Home())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.history_edu),
            title: Text("Lịch sử đấu đối kháng",style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => PageHistory())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart_rounded ),
            title: Text("Bảng xếp hạng",style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => PageRank())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart_rounded ),
            title: Text("Nạp tiền",style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => PageRank())));
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart_rounded ),
            title: Text("Đổi mật khẩu",style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => PageRank())));
            },
          ),
           ListTile(
            leading: const Icon(Icons.settings ),
            title: Text("Cài đặt",style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => PageRank())));
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
