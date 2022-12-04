import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/Login/form_login_signup.dart';
import 'package:home_page/screens/Login/page_forgetpass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtPass = new TextEditingController();
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage_Login_SignUp()));
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          labelText: "Nhập Email"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: txtPass,
                        obscureText: true,
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
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>PageForgetPass()));
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
                          onPressed: () async{
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Home()));
                             if(txtEmail.text==''||txtPass.text==''){
                                 final snackBar = SnackBar(backgroundColor: Colors.white,content: Text('Không được bỏ trống email và password',
                                 style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.w500),));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                              else{
                            try {
                             
                              final _user =  _auth.signInWithEmailAndPassword(email: txtEmail.text, password: txtPass.text);
                                 _auth.userChanges().listen((event) async {
                                if(event != null)
                                {
                                  final user=  _auth.currentUser;
                                  await fireDb().createUser(user!.displayName.toString(),user.email.toString(),user.photoURL.toString(),user.uid.toString(),);
                                  txtEmail.clear();
                                  txtPass.clear();
                                  final snackbar = SnackBar(content: Text('Đăng nhập thành công'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                  Navigator.pushNamedAndRemoveUntil(context,'home', (route) => false);
                                }
                                else{
                                  final snackBar = SnackBar(content: Text('Email hoặc mật khẩu không đúng',));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              });
                            }
                            catch(e)
                            {
                              final snackBar = SnackBar(content: Text('Lỗi Kết Nối Đến Server'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                            }}
                          ,
                          child: Text(
                           'Đăng nhập',
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
