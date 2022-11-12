import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/main.dart';
import 'package:home_page/screens/Login/page_forgetpass.dart';
import 'package:home_page/screens/Login/page_login.dart';
import 'package:home_page/screens/home.dart';

class PageResetPass extends StatefulWidget {
  const PageResetPass({super.key});

  @override
  State<PageResetPass> createState() => _PageResetPassState();
}

class _PageResetPassState extends State<PageResetPass> {
  TextEditingController accountController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:Layout().background_image,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "acssets/2.png",
                            height: MediaQuery.of(context).size.height * 0.16,
                            width: MediaQuery.of(context).size.width * 0.32,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(185, 0, 0, 90),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close)),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Text(
                    "Đặt lại mật khẩu",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: accountController,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.remove_red_eye_sharp),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          labelText: "Mật khẩu mới"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.remove_red_eye_sharp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "Nhập lại mật khẩu"),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 75,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            onPressed: (() {
                              
                              Navigator.of(context).popUntil((route) => route.isFirst);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            }),
                            child: Text(
                              "Xác nhận",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    )
                  ],
                )),
              ],
            ),
          )),
        ));
  }
}
