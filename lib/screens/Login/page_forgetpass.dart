import 'package:flutter/material.dart';
import 'package:home_page/screens/Login/page_OTP.dart';

class PageForgetPass extends StatefulWidget {
  const PageForgetPass({super.key});

  @override
  State<PageForgetPass> createState() => _PageForgetPassState();
}

class _PageForgetPassState extends State<PageForgetPass> {
  TextEditingController OTPController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("acssets/background2.jpg"), fit: BoxFit.fill),
        ),
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
                    "Quên mật khẩu",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Cho chúng tôi biết số điện thoại bạn đã đắng ký tài khoản?",
                    style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Chúng tôi sẽ gửi mã OTP về SMS cho bạn",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          labelText: "Nhập số điện thoại"),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                            onPressed: (() {
                              Navigator.push(context, MaterialPageRoute(builder: ((context) => PageOTP())));
                            }),
                            child: Text(
                              "Gửi OTP",
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
