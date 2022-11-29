import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PageHistory extends StatefulWidget {
  const PageHistory({super.key});

  @override
  State<PageHistory> createState() => _PageHistoryState();
}

class _PageHistoryState extends State<PageHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PageDrawer(),
      body: Container(decoration:Layout().background_image,child:
      CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 0,
          flexibleSpace: FlexibleSpaceBar(title: Text("Lịch sử đối kháng"),),
        ),SliverFixedExtentList(itemExtent: 95  ,delegate: SliverChildBuilderDelegate(childCount: 20,
        (BuildContext context, int index){
          return Container(alignment: Alignment.center,
           child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
               color: Colors.white.withOpacity(0.6),
                child: ListTile(leading: IconButton(onPressed: (() {
                  
                }), icon: Icon(Icons.history_edu)),
                title: Text("Quang Thieu Em"),subtitle: Text("1600"),trailing: Text("+10"),),
              ),
            ),
           
           ],)
          );
        }),),
      ],)
      //  Container(child: Column(children: [
      //   ListView(
      //     children: [
      //       Card(child: ListTile(
      //         leading: IconButton(onPressed: (() {
                
      //         }), icon: Icon(Icons.notifications)),
      //       ))
      //     ],
      //   )
        
      // ]),)
      )
    );
  }
}
