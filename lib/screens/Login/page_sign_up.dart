import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.cyan[300],
      body: SingleChildScrollView(child: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //image
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 350),
                   child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.close)),
                 ),
                Image.asset(
                  "acssets/2.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "ĐĂNG KÝ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          //account
          Padding(
            padding: const EdgeInsets.fromLTRB(0 , 0, 0, 60),
            child: Column(
              children: [
                Container(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextField(
                    obscureText: false,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        hintText: 'Số điện thoại',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)),
                  ),
                )),
                //password
                Container(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black)),
                      hintText: 'Nhập tên hiển thị',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
                Container(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black)),
                      hintText: 'Nhập tài khoản',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
                Container(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black)),
                      hintText: 'Nhập mật khẩu',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
                Container(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.black)),
                      hintText: 'Nhập lại mật khẩu',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
                ElevatedButton(onPressed: (() {}), child: Text("Đăng ký"))
              ],
            ),
          ),
        
          //sign in button
        ]),
      ),) 
      
    );
  }
}
