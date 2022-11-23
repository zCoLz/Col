import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/Drawer/form_drawer.dart';

class PageNoti extends StatefulWidget {
  const PageNoti({super.key});

  @override
  State<PageNoti> createState() => _PageNotiState();
}

class _PageNotiState extends State<PageNoti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PageDrawer(),
      body: Container(decoration:Layout().background_image,child:
      CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 0,
          flexibleSpace: FlexibleSpaceBar(title: Text("Notifications"),),
        ),SliverFixedExtentList(itemExtent: 95  ,delegate: SliverChildBuilderDelegate(childCount: 20,
        (BuildContext context, int index){
          return Container(alignment: Alignment.center,
           child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
               color: Colors.white.withOpacity(0.6),
                child: ListTile(leading: IconButton(onPressed: (() {
                  
                }), icon: Icon(Icons.notifications)),
                title: Text("Thông 1"),subtitle: Text("Đây là thông báo"),trailing: PopupMenuButton(itemBuilder: (context) =>[PopupMenuItem(child: Row(children: [Text("Xóa")],))] ),),
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
