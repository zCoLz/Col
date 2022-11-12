import 'package:flutter/material.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("acssets/background2.jpg"), fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: Text(""),
            actions: [
              IconButton(
                  onPressed: (() {}), icon: Icon(Icons.power_settings_new)),
            ],
          ),
          drawer: PageDrawer(),
          body: Center(
            child: Container(
              child: Column(children: [
                Icon(
                  Icons.account_circle,
                  size: 60,
                ),
                Text(
                  "Quang Thiếu U",
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Số điện thoại",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Số điện thoại",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Số điện thoại",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                )
              ]),
            ),
          )
          //Column(children: [
          //     Icon(Icons.account_circle),
          //     Text("Quang Thiếu U"),
          //     Container(
          //         child: Padding(
          //       padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          //       child: TextField(
          //         obscureText: false,
          //         textAlign: TextAlign.left,
          //         decoration: InputDecoration(
          //             border: OutlineInputBorder(),
          //             hintText: 'Số điện thoại',
          //             hintStyle: TextStyle(
          //                 color: Colors.grey,
          //                 fontSize: 16,
          //                 fontStyle: FontStyle.italic,
          //                 fontWeight: FontWeight.bold)),

          //       ),

          //     )),
          //     Container(
          //         child: Padding(
          //       padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          //       child: TextField(
          //         obscureText: false,
          //         textAlign: TextAlign.left,
          //         decoration: InputDecoration(
          //             border: OutlineInputBorder(),
          //             hintText: '0351511xxx',
          //             hintStyle: TextStyle(
          //                 color: Colors.grey,
          //                 fontSize: 16,
          //                 fontStyle: FontStyle.italic,
          //                 fontWeight: FontWeight.bold)),
          //       ),
          //     )),
          //     Container(
          //         child: Padding(
          //       padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          //       child: TextField(
          //         obscureText: false,
          //         textAlign: TextAlign.left,
          //         decoration: InputDecoration(
          //             border: OutlineInputBorder(),
          //             hintText: 'Số điện thoại',
          //             hintStyle: TextStyle(
          //                 color: Colors.grey,
          //                 fontSize: 16,
          //                 fontStyle: FontStyle.italic,
          //                 fontWeight: FontWeight.bold)),
          //       ),
          //     )),
          //     Container(
          //         child: Padding(
          //       padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          //       child: TextField(
          //         obscureText: false,
          //         textAlign: TextAlign.left,
          //         decoration: InputDecoration(
          //             border: OutlineInputBorder(),
          //             hintText: 'quangthieu@gmail',
          //             hintStyle: TextStyle(
          //                 color: Colors.grey,
          //                 fontSize: 16,
          //                 fontStyle: FontStyle.italic,
          //                 fontWeight: FontWeight.bold)),
          //       ),
          //     )),
          //   ]),
          ),
    );
  }
}
