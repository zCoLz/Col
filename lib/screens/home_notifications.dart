import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PageNoti extends StatefulWidget {
  const PageNoti({super.key});

  @override
  State<PageNoti> createState() => _PageNotiState();
}

class _PageNotiState extends State<PageNoti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(onPressed: (() {}), icon: Icon(Icons.power_settings_new)),
        ],
      ),
      drawer: PageDrawer(),
   
      body: Container(decoration:components().background_image,child: Center(child: Text("HomeNoti",style: TextStyle(fontSize: 40),),))
    );
  }
}
