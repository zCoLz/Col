import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/home.dart';

class ChangePassWord extends StatefulWidget {
  const ChangePassWord({super.key});

  @override
  State<ChangePassWord> createState() => _ChangePassWordState();
}

class _ChangePassWordState extends State<ChangePassWord> {
  TextEditingController txtpassOld = TextEditingController();
  TextEditingController txtpassNew = TextEditingController();
  TextEditingController txtpassRe = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: Layout().background_image,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Đổi mật khẩu'),
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: txtpassOld,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Mật khẩu cũ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    //readOnly: true,
                    controller: txtpassNew,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Mật khẩu mới",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    //readOnly: true,
                    controller: txtpassRe,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Nhập lại Mật khẩu mới",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width/3,
                  color: Colors.blue,
                  child: TextButton(
                    onPressed: ()async{
                      if(txtpassOld.text=='' || txtpassNew.text==''||txtpassRe.text==''){
                        showDialog(context: context, builder: (context)=>AlertDialog(
                          title: Text('Không được bỏ trống'),
                          actions: [
                            ElevatedButton(onPressed: ()async{
                              Navigator.pop(context);
                            }, child: Text('Ok'))
                          ],
                        ));
                      }else{
                      _auth.signInWithEmailAndPassword(email: _auth.currentUser!.email.toString(),
                         password: txtpassOld.text).then((value){
                          if(value!=null){
                             _auth.currentUser!.updatePassword(txtpassNew.text).then((value){
                                 showDialog(context: context, builder: (context)=>AlertDialog(
                          title: Text('Đổi mật khẩu thành công'),
                          actions: [
                            ElevatedButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
                            }, child: Text('Ok'))
                          ],
                        ));
                            });
                           
                          }else{
                            showDialog(context: context, builder: (context)=>
                            AlertDialog(
                              title: Center(child: CircularProgressIndicator(),),
                            ));
                          }
                         }).onError((error, stackTrace){
                          showDialog(context: context, builder: (context)=>AlertDialog(
                          title: Text('Mật khẩu không chính xác'),
                          actions: [
                            ElevatedButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text('Ok'))
                          ],
                        ));
                         });
                         }
                    }, child: Center(child: Text('Đổi mật khẩu',style: TextStyle(color: Colors.white),))),
                )
              ],
            ),
          ),
        ));
  }
}
