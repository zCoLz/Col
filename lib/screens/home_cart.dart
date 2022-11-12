import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PageCart extends StatefulWidget {
  const PageCart({super.key});

  @override
  State<PageCart> createState() => _PageCartState();
}

class _PageCartState extends State<PageCart> {
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
        decoration: components().background_image,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Row(
              children: [
                Icon(
                  Icons.energy_savings_leaf,
                  size: 35,
                  color: Colors.green,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.diamond,
                              size: 30,
                              color: Colors.red,
                            ),
                            Text(
                              "100",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
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
                              "100",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                child: ListTile(
                    title: const Text('Vật phẩm gợi ý',style: TextStyle(fontWeight: FontWeight.bold),),
                    tileColor: Colors.orange,
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
                child: ListTile(
                    title: const Text('Vật phẩm đáp án từ BOT',style: TextStyle(fontWeight: FontWeight.bold)),
                    tileColor: Colors.orange,
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
                child: ListTile(
                    title: const Text('Vật phẩm 50/50',style: TextStyle(fontWeight: FontWeight.bold)),
                    tileColor: Colors.orange,
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
                child: ListTile(
                    title: const Text('Vật phẩm hiển thị đáp án đúng*',style: TextStyle(fontWeight: FontWeight.bold)),
                    tileColor: Colors.orange,
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
                child: ListTile(
                    title: const Text('Vật phẩm thẻ đổi tên',style: TextStyle(fontWeight: FontWeight.bold)),
                    tileColor: Colors.orange,
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
                child: ListTile(
                    title: const Text('Hình nền và ảnh hồ sơ',style: TextStyle(fontWeight: FontWeight.bold)),
                    tileColor: Colors.orange,
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Icon(Icons.crop_original,size: 30,color: Colors.black,),
                    ),
                    subtitle: const Text("số lượng: 100"),
                    trailing: IconButton(
                        onPressed: (() {}), icon: Icon(Icons.add_circle,color: Colors.black,))),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
