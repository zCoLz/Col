import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';
import 'package:home_page/screens/TabBar/battleHistory.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
        padding: EdgeInsets.only(top: 20),
        decoration: Layout().background_image,
        child: Column(children: [ 
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Material(
                color: Colors.white.withOpacity(0.8),
                child: ListTile(
                    title: const Text('Thua',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red)),
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Icon(Icons.account_circle_rounded,size: 50,color: Colors.black, ),
                    ),
                    subtitle: Text("14/11/2022"),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => BattleHistory())));
                        }, icon: Icon(Icons.arrow_forward,color: Colors.black))),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Material(
                color: Colors.white.withOpacity(0.8),
                child: ListTile(
                    title: const Text('Thắng',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue)),
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Icon(Icons.account_circle_rounded,size: 50,color: Colors.black, ),
                    ),
                    subtitle: Text("14/11/2022"),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => BattleHistory())));
                        }, icon: Icon(Icons.arrow_forward,color: Colors.black))),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Material(
                color: Colors.white.withOpacity(0.8),
                child: ListTile(
                    title: const Text('Thắng',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue)),
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Icon(Icons.account_circle_rounded,size: 50,color: Colors.black, ),
                    ),
                    subtitle: Text("13/11/2022"),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => BattleHistory())));
                        }, icon: Icon(Icons.arrow_forward,color: Colors.black))),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Material(
                color: Colors.white.withOpacity(0.8),
                child: ListTile(
                    title: const Text('Thua',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red)),
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Icon(Icons.account_circle_rounded,size: 50,color: Colors.black, ),
                    ),
                    subtitle: Text("13/11/2022"),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => BattleHistory())));
                        }, icon: Icon(Icons.arrow_forward,color: Colors.black))),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Material(
                color: Colors.white.withOpacity(0.8),
                child: ListTile(
                    title: const Text('Thắng',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue)),
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Icon(Icons.account_circle_rounded,size: 50,color: Colors.black, ),
                    ),
                    subtitle: Text("11/11/2022"),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => BattleHistory())));
                        }, icon: Icon(Icons.arrow_forward,color: Colors.black))),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Material(
                color: Colors.white.withOpacity(0.8),
                child: ListTile(
                    title: const Text('Thua',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red)),
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Icon(Icons.account_circle_rounded,size: 50,color: Colors.black, ),
                    ),
                    subtitle: Text("11/11/2022"),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => BattleHistory())));
                        }, icon: Icon(Icons.arrow_forward,color: Colors.black))),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Material(
                color: Colors.white.withOpacity(0.8),
                child: ListTile(
                    title: const Text('Thua',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.red)),
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Icon(Icons.account_circle_rounded,size: 50,color: Colors.black, ),
                    ),
                    subtitle: Text("10/11/2022"),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => BattleHistory())));
                        }, icon: Icon(Icons.arrow_forward,color: Colors.black))),
              ),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Material(
                color: Colors.white.withOpacity(0.8),
                child: ListTile(
                    title: const Text('Thắng',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.blue)),
                    leading: Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Icon(Icons.account_circle_rounded,size: 50,color: Colors.black, ),
                    ),
                    subtitle: Text("10/11/2022"),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => BattleHistory())));
                        }, icon: Icon(Icons.arrow_forward,color: Colors.black))),
              ),
            ),
          ),
          
        ]),
      ),
    );
  }
}
