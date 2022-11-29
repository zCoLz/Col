import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/components/home_page.dart';
import 'package:home_page/main.dart';
import 'package:home_page/screens/Login/page_forgetpass.dart';
import 'package:home_page/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: Layout().background_image,
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
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      controller: txtEmail,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          labelText: "Tài khoản"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: txtPass,
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.remove_red_eye_sharp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "Mật khẩu"),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageForgetPass()));
                          }),
                          child: Text(
                            "Quên mật khẩu",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            // try {
                            //   final _user = _auth.signInWithEmailAndPassword(
                            //       email: txtEmail.text, password: txtPass.text);
                            //   _auth.authStateChanges().listen((event) {
                            //     if (event != null) {
                            //       txtEmail.clear();
                            //       txtPass.clear();
                            //       Navigator.pushNamedAndRemoveUntil(
                            //           context, 'home', (route) => false);
                            //     } else {
                            //       final snackbar = SnackBar(
                            //           content: Text(
                            //               'Email hoặc mật khẩu không chính xác'));
                            //       ScaffoldMessenger.of(context)
                            //           .showSnackBar(snackbar);
                            //     }
                            //   });
                            // } catch (e) {
                            //   final snackBar = SnackBar(
                            //       content: Text('Lỗi kết nối đến Server'));
                            //   ScaffoldMessenger.of(context)
                            //       .showSnackBar(snackBar);
                            // }
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                          },
                          child: Text(
                            "Đăng nhập",
                            style: TextStyle(fontSize: 18),
                          )),
                    )
                  ],
                )),
              ],
            ),
          )),
        ));
  }
}
