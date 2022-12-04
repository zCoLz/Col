import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/dbContext.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: Layout().background_image,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //image
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.16,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.32,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(190, 0, 0, 90),
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
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "ĐĂNG KÝ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            ),
                            Form(
                                child: Column(
                              children: [
                                // TextFormField(
                                //   style: TextStyle(fontSize: 20,color: Colors.black),
                                //   decoration: InputDecoration(
                                //       border: OutlineInputBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(20)),
                                //       labelText: "Số điện thoại"),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    controller: txtEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        labelText: "Nhập Email"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: TextFormField(
                                    controller: txtPass,
                                    obscureText: true,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        labelText: "Nhập mật khẩu"),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 10),
                                //   child: TextFormField(
                                //      style: TextStyle(fontSize: 20,color: Colors.black),
                                //     decoration:InputDecoration(
                                //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                //         labelText: "Nhập lại mật khẩu"),
                                //   ),
                                // ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: ElevatedButton(
                                        onPressed: () async{
                                          if(txtEmail.text==''||txtPass.text==''){
                                            final snackBar = SnackBar(
                                                content:
                                                    Text('Không được bỏ trống Email và Password'));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                          else{
                                            var check =  await _auth.fetchSignInMethodsForEmail(txtEmail.text);
                                           if(check.contains('password')){
                                               final snackBar = SnackBar(
                                                  content: Text('Tài Khoản Này đã tồn tại'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                           }
                                           else{
                                          try {
                                            final newUser =_auth
                                            .createUserWithEmailAndPassword(email:txtEmail.text , password: txtPass.text)
                                            ;
                                            if (newUser != null) {
                                              //final user=  _auth.currentUser;
                                              
                                              Navigator.pop(context,
                                                  'Đăng Ký Thành Công!');
                                            } else {
                                              final snackBar = SnackBar(
                                                  content: Text('Tài Khoản Này Không Hợp Lệ'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          } catch (e) {
                                            final snackBar = SnackBar(
                                                content:
                                                    Text('Có Lỗi Xảy Ra!'));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                          }}}
                                        ,
                                        child: Text(
                                          "Đăng ký",
                                          style: TextStyle(fontSize: 20),
                                        )),
                                  ),
                                )
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          )),
    );
  }
}
