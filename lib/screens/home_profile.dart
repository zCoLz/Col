import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({super.key});

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  TextEditingController _controller  = TextEditingController();
  TextEditingController _account = TextEditingController(text: 'QuangThieuEm');
    TextEditingController _pasword = TextEditingController(text: '**********');
      TextEditingController _phone = TextEditingController(text: '0130584xxx');
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Layout().background_image,
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
                  
                  padding: const EdgeInsets.fromLTRB(5 , 20, 5, 0),
                  child: TextField(
                    controller: _phone,
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
                  padding: const EdgeInsets.fromLTRB(5 , 20, 5, 0),
                  child: TextField(
                    controller: _account,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Tài khoản",
                        hintText: _account.text,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5 , 20, 5, 0),
                  child: TextField(
                    controller: _pasword,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Mật khẩu",
                        hintText: _pasword.text,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                  
                ),
                
                Padding(
                  padding: const EdgeInsets.fromLTRB(5 , 20, 5, 0),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                              onPressed: (() {

                              }), child: Text("Xác nhận",style: TextStyle(fontSize: 20),)),
                  ),
                ),
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
