import 'package:flutter/material.dart';
import 'package:home_page/screens/home_cart.dart';
import 'package:home_page/screens/home_notifications.dart';
import 'package:home_page/components/home_page.dart';
import 'package:home_page/screens/home_profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List screens = [
    PageCart(),
    PageNoti(),
    HomePage(),
    PageProfile(),
  ];
  final PageStorageBucket _bucket = PageStorageBucket();
  Widget currentScreen = HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: _bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                MaterialButton(
                  minWidth: 80,
                  onPressed: () {
                    setState(() {
                      currentScreen = HomePage();
                      currentTab = 0;
                    });
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Trang chủ",
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ]),
                ),
                MaterialButton(
                  minWidth: 80,
                  onPressed: () {
                    setState(() {
                      currentScreen = PageCart();
                      currentTab = 1;
                    });
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.store,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Cửa hàng",
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ]),
                ),
              ]),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                MaterialButton(
                  minWidth: 100,
                  onPressed: () {
                    setState(() {
                      currentScreen = PageNoti();
                      currentTab = 2;
                    });
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Thông báo",
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ]),
                ),
                MaterialButton(
                  minWidth: 100,
                  onPressed: () {
                    setState(() {
                      currentScreen = PageProfile();
                      currentTab = 3;
                    });
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Hồ sơ",
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ]),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
