
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/components/toggleButton.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}
const bool checknormal = false;
class _SettingState extends State<Setting> {
  Widget box(String label,bool? check){
     return Container(
      width: MediaQuery.of(context).size.width/1.1,
      height: MediaQuery.of(context).size.width/8,
        margin: EdgeInsets.fromLTRB(20,10,20,25),
                child: Row(
                  children: <Widget>[
                    Expanded(child:
                    Padding(
                      padding: EdgeInsets.only(left: 15), 
                      child:Text(label,style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600),))),
                       if(check !=null)
                          ToggleButton(check: check,)
                  ],
                ),
                decoration: BoxDecoration(color: Colors.white,border: Border.all(width: 2)),
              );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Layout().background_image,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Cài đặt'),
        ),
         drawer: PageDrawer(),
         body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: 30),
              child: box('Thông báo',false), ),
              box('Giao diện', true),
              box('Giới thiệu',null)
            ],
          ),
         ),
         ),
        
    );
  }
}