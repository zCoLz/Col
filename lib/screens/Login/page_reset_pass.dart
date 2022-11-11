import 'package:flutter/material.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("acssets/background2.jpg"),
                    fit: BoxFit.cover)),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //image
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Image.asset(
              "acssets/2.png",
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          //account
          Container(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: TextField(
             
              obscureText: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black)),
                  hintText: 'Mật khẩu mới',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
            ),
          )),
          //password
          Container(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 50),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.black)),
                hintText: 'Nhập lại mật khẩu',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
              ),
            ),
          )),
          
          ElevatedButton(onPressed: (() {}), child: Text("Xác Nhận"))
          //sign in button
        ]),
      ),
    );
  }
}
