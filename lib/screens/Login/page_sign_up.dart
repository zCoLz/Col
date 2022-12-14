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
                                "????NG K??",
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
                                //       labelText: "S??? ??i???n tho???i"),
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
                                        labelText: "Nh???p Email"),
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
                                        labelText: "Nh???p m???t kh???u"),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 10),
                                //   child: TextFormField(
                                //      style: TextStyle(fontSize: 20,color: Colors.black),
                                //     decoration:InputDecoration(
                                //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                //         labelText: "Nh???p l???i m???t kh???u"),
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
                                                    Text('Kh??ng ???????c b??? tr???ng Email v?? Password'));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                          else{
                                            var check =  await _auth.fetchSignInMethodsForEmail(txtEmail.text);
                                           if(check.contains('password')){
                                               final snackBar = SnackBar(
                                                  content: Text('T??i Kho???n N??y ???? t???n t???i'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                           }
                                           else{
                                          try {
                                            final newUser =_auth
                                            .createUserWithEmailAndPassword(email:txtEmail.text , password: txtPass.text)
                                            .then((value)async {
                                              if(value!=null){
                                                 final user=  _auth.currentUser;
                                                await fireDb().createUser(user!.email.toString());
                                              }
                                            })
                                            ;
                                            if (newUser != null) {
                                              //final user=  _auth.currentUser;
                                              
                                              Navigator.pop(context,
                                                  '????ng K?? Th??nh C??ng!');
                                            } else {
                                              final snackBar = SnackBar(
                                                  content: Text('T??i Kho???n N??y Kh??ng H???p L???'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          } catch (e) {
                                            final snackBar = SnackBar(
                                                content:
                                                    Text('C?? L???i X???y Ra!'));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                          }}}
                                        ,
                                        child: Text(
                                          "????ng k??",
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
