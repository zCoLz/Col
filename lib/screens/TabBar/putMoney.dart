import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PutMoney extends StatefulWidget {
  const PutMoney({super.key});

  @override
  State<PutMoney> createState() => _PutMoneyState();
}

class _PutMoneyState extends State<PutMoney> {
  Widget putMoney(String namePut,IconData icon){
    return TextButton(onPressed: (){}, child:  Padding(padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
            child: Row(
              children: [
                Icon(icon,size: 45,color: Colors.black,),
               Padding(padding: EdgeInsets.only(left: 15),child: Text(namePut,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),))
              ],
            ),));
  }
  Widget line = Divider(height: 2,color: Colors.black,);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Layout().background_image,
      child: Scaffold(appBar: AppBar(title: Text('Nạp tiền')
      ),
      backgroundColor: Colors.transparent,
      drawer: PageDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.account_circle,size: 80,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.diamond_outlined,color: Colors.red,size: 30,),
                        Padding(padding: EdgeInsets.only(left: 5),child: Text('100',style: TextStyle(fontSize: 18),))
                      ],
                    ),
                    Text('Quang thieu Em',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),)
                  ],
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 70),
               child: line),
            putMoney('Thẻ tín dụng hoặc thẻ ghi nợ', Icons.add_card_outlined),
            line,
            putMoney('QR Code', Icons.qr_code),
            line,
            putMoney('Thẻ ATM Banking', Icons.account_balance),
            line
          ],
        ),
      ),
      ),
    );
  }
}