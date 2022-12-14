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
  IconData icon = Icons.password;
  bool pass =true;
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
                    "????ng nh???p",
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
                          labelText: "Nh???p Email"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: txtPass,
                        obscureText: pass,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(onPressed: (){
                              if(pass){
                                setState(() {
                                  pass=false;
                                  icon = Icons.remove_red_eye_sharp;
                                });
                              }else{
                                setState(() {
                                  pass=true;
                                icon = Icons.password;
                                });
                              }
                            }, icon: Icon(icon,color: Colors.black,)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "M???t kh???u"),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: (() {
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>PageForgetPass()));
                          }),
                          child: Text(
                            "Qu??n m???t kh???u",
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
                                 const snackBar = SnackBar(backgroundColor: Colors.white,content: Text('Kh??ng ???????c b??? tr???ng email v?? password',
                                 style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.w500),));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                              else{
                            try {
                              final _user =  _auth.signInWithEmailAndPassword(email: txtEmail.text, password: txtPass.text)
                                .then((value) async{
                                  if(value!=null){
                                  txtEmail.clear();
                                  txtPass.clear();
                                  const snackbar = SnackBar(content: Text('????ng nh???p th??nh c??ng'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                  setState(() {
                                    Navigator.pushNamedAndRemoveUntil(context,'home', (route) => false);
                                  });}else{
                                    showDialog(context: context, builder: (context)
                                    =>AlertDialog(
                                      title: Center(child: CircularProgressIndicator(),),
                                    ));
                                  }
                                }).onError((error, stackTrace){
                                   const snackBar = SnackBar(content: Text('Email ho???c m???t kh???u kh??ng ????ng',));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                });
                            }
                            catch(e)
                            {
                              final snackBar = SnackBar(content: Text('L???i K???t N???i ?????n Server'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                            }}
                          ,
                          child: Text(
                           '????ng nh???p',
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
