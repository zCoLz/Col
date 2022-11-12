import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PageRank extends StatefulWidget {
  const PageRank({super.key});

  @override
  State<PageRank> createState() => _PageRankState();
}

class _PageRankState extends State<PageRank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Layout().background_image,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          
          title: Text("Bảng xếp hạng"),
        ),
        drawer: PageDrawer(),
        body: ListView(children: [
          ListTile(
            leading: Image.asset(
              "acssets/hang1.png",
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                "Minh Sad Boy",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                "Điểm: 1595",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          ListTile(
            leading: Image.asset(
              "acssets/hang2.png",
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                "Lộc không vui",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                "Điểm: 1592",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          ListTile(
            leading: Image.asset(
              "acssets/hang3.png",
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                "Quang thiếu u",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                "Điểm: 1590",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              leading: Text(
                "#4",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Phi hay quạo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Điểm: 1588",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              leading: Text(
                "#5",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Quyền không ngu",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Điểm: 1586",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              leading: Text(
                "#6",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Bình Bóng bảy",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Điểm: 1584",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
