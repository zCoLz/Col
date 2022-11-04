import 'package:flutter/material.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(""),
          actions: [
            IconButton(
                onPressed: (() {}), icon: Icon(Icons.power_settings_new)),
          ],
        ),
        drawer: PageDrawer(),
        backgroundColor: Colors.cyan[300],
        body: Container(
          child: Column(children: [
            Icon(Icons.account_circle),
            Text("Quang Thiếu U"),
            Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                obscureText: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Số điện thoại',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
              ),
            )),
            Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                obscureText: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '0351511xxx',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
              ),
            )),
            Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                obscureText: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Số điện thoại',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
              ),
            )),
            Container(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextField(
                obscureText: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'quangthieu@gmail',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold)),
              ),
            )),
          ]),
        ));
  }
}
