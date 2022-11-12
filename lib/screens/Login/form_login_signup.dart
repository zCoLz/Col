import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Login/page_login.dart';
import 'package:home_page/screens/Login/page_sign_up.dart';

class HomePage_Login_SignUp extends StatefulWidget {
  const HomePage_Login_SignUp({super.key});

  @override
  State<HomePage_Login_SignUp> createState() => _HomePage_Login_SignUpState();
}

class _HomePage_Login_SignUpState extends State<HomePage_Login_SignUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: components().background_image,
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: Image.asset(
                      "acssets/2.png",
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: (() {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                          }), child: Text("Đăng nhập",style: TextStyle(fontSize: 18),)),
                    ),
                  )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: (() {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                          }), child: Text("Đăng ký",style: TextStyle(fontSize: 18),)),
                    ),
                  )),
                ],
              ))),
    );
  }
}