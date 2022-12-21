import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PageCart extends StatefulWidget {
  const PageCart({super.key});

  @override
  State<PageCart> createState() => _PageCartState();
}

class _PageCartState extends State<PageCart> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(""),
        actions: [
          IconButton(onPressed: (() {}), icon: Icon(Icons.power_settings_new)),
        ],
      ),
      drawer: PageDrawer(),

      body: Container(
        decoration: Layout().background_image,
        child: StreamBuilder<QuerySnapshot>(
          stream: _fireStore.collection('users').where('email',isEqualTo: _auth.currentUser!.email).snapshots(),
          builder: (context, snapshot) {
            try{
            return Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Row(
                      children: [
                        const Icon(
                          Icons.energy_savings_leaf,
                          size: 35,
                          color: Colors.green,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.diamond,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                      Text(
                                       // _login.email.toString(),
                                        snapshot.data!.docs[0]['coins'].toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.monetization_on_rounded,
                                        size: 30,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        snapshot.data!.docs[0]['money'].toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          "20/20",
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Material(
                    color: Colors.grey.withOpacity(0.8),
                    child: ListTile(
                        title: const Text('Vật phẩm gợi ý',style: TextStyle(fontWeight: FontWeight.bold),),
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Icon(Icons.contact_support,size: 30,color: Colors.black,),
                        ),
                        subtitle: const Text("số lượng: 100"),
                        trailing: IconButton(
                            onPressed: (() {}), icon: Icon(Icons.add_circle,color: Colors.black,))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Material(
                    color: Colors.grey.withOpacity(0.8),
                    child: ListTile(
                        title: const Text('Vật phẩm đáp án từ BOT',style: TextStyle(fontWeight: FontWeight.bold)),
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Icon(Icons.hearing,size: 30,color: Colors.black, ),
                        ),
                        subtitle: const Text("số lượng: 100"),
                        trailing: IconButton(
                            onPressed: (() {}), icon: Icon(Icons.add_circle,color: Colors.black))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Material(
                    color: Colors.grey.withOpacity(0.8),
                    child: ListTile(
                        title: const Text('Vật phẩm 50/50',style: TextStyle(fontWeight: FontWeight.bold)),
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Icon(Icons.star_half,size: 30,color: Colors.black,),
                        ),
                        subtitle: const Text("số lượng: 100"),
                        trailing: IconButton(
                            onPressed: (() {}), icon: Icon(Icons.add_circle,color: Colors.black))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Material(
                    color: Colors.grey.withOpacity(0.8),
                    child: ListTile(
                        title: const Text('Vật phẩm hiển thị đáp án đúng*',style: TextStyle(fontWeight: FontWeight.bold)),
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Icon(Icons.star,size: 30,color: Colors.black,),
                        ),
                        subtitle: const Text("số lượng: 100"),
                        trailing: IconButton(
                            onPressed: (() {}), icon: Icon(Icons.add_circle,color: Colors.black))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Material(
                    color: Colors.grey.withOpacity(0.8),
                    child: ListTile(
                        title: const Text('Vật phẩm thẻ đổi tên',style: TextStyle(fontWeight: FontWeight.bold)),
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Icon(Icons.contact_support,size: 30,color: Colors.black,),
                        ),
                        subtitle: const Text("số lượng: 100"),
                        trailing: IconButton(
                            onPressed: (() {}), icon: Icon(Icons.add_circle,color: Colors.black))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Material(
                    color: Colors.grey.withOpacity(0.8),
                    child: ListTile(
                        title: const Text('Hình nền và ảnh hồ sơ',style: TextStyle(fontWeight: FontWeight.bold)),
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Icon(Icons.crop_original,size: 30,color: Colors.black,),
                        ),
                        subtitle: const Text("số lượng: 100"),
                        trailing: IconButton(
                            onPressed: (() {
                              fireDb().setUserImage('minhdeptrai.jpg');
                            }), icon: Icon(Icons.add_circle,color: Colors.black,))),
                  ),
                ),
              ),
            ]);
          }
          catch(e){
            return Center(child: CircularProgressIndicator(),);
          }
          }
        ),
      ),
    );
  }
}
