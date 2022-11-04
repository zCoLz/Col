import 'package:flutter/material.dart';

class PageOTP extends StatefulWidget {
  const PageOTP({super.key});

  @override
  State<PageOTP> createState() => _PageOTPState();
}

class _PageOTPState extends State<PageOTP> {
  TextEditingController OTPController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[300],
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: Image.asset(
                'acssets/2.png',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(
                "Nhập OTP",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: TextField(
                    controller: OTPController,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black)),
                        hintText: 'Nhập OTP',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold))),
              ),
            ),
            ElevatedButton(onPressed: (() {}), child: Text("Đăng nhập"))
          ],
        ),
      ),
    );
  }
}
