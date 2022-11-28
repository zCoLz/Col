import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
class Question extends StatefulWidget {
  Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
    double _headerHeight = 55.0;
  double _bodyHeight = 250.0;
  bool flag = false;
  BottomDrawerController _controller = BottomDrawerController();
  @override
  Widget build(BuildContext context) {
    Widget buttonAnswer(String title) {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: TextButton(
            style: TextButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 2.6, 35)),
            onPressed: () {},
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 17),
            )),
        decoration: BoxDecoration(
            color: Colors.white10,
            border: Border.all(width: 3),
            borderRadius: BorderRadius.circular(40)),
      );
    }

    return Container(
        decoration: Layout().background_image,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Sport',
                style: TextStyle(
                    color: Color.fromARGB(255, 55, 55, 55),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 40,
                  )),
            ),
            body: Container(
              child: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        height: MediaQuery.of(context).size.height,
                        margin: EdgeInsets.fromLTRB(20, 50, 20, 5),
                        child: Column(children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                'Điểm 00',
                                style: TextStyle(fontSize: 23),
                              )),
                              Text(
                                'Thời gian : 30s',
                                style: TextStyle(fontSize: 23),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 30, 0, 50),
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buttonAnswer('Đáp án 1'),
                              buttonAnswer('Đáp án 2')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              buttonAnswer('Đáp án 3'),
                              buttonAnswer('Đáp án 4')
                            ],
                          ),
                        ]),
                      )),
                    ],
                  ),
                   _buildBottomDrawer(context)
                ],
              ),
            )));
  }
   Widget _buildBottomDrawer(BuildContext context) {
    return BottomDrawer(
      header: _buildBottomDrawerHead(context),
      body: _buildBottomDrawerBody(context),
      headerHeight: _headerHeight,
      drawerHeight: _bodyHeight,
      color: Colors.white.withOpacity(0.5),
      controller: _controller,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 60,
          spreadRadius: 5,
          offset: const Offset(2, -6), // changes position of shadow
        ),
      ],
    );
  }

  Widget _buildBottomDrawerHead(BuildContext context){
     return Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              Icon(
                                Icons.monetization_on_rounded,
                                color: Colors.yellow,
                                size: 30,
                              ),
                              Text(
                                '100',
                                style: TextStyle(fontSize: 18),
                              ),
                              Padding(padding: EdgeInsets.only(left: 15)),
                              Icon(
                                Icons.diamond_rounded,
                                size: 30,
                                color: Colors.red,
                              ),
                              Text(
                                '100',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          )),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if(flag==false){
                                    _controller.open();
                                    flag=true;
                                  }
                                  else{
                                    _controller.close();
                                    flag=false;
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.info_sharp,
                                size: 40,
                              ))
                        ],
                      ));
  }
  Widget ideal(IconData icon,String label){
    return Container(
      width: MediaQuery.of(context).size.width/2.2,
      height: MediaQuery.of(context).size.width/7,
      margin: EdgeInsets.fromLTRB(0, 10, 0 , 20),
      child:  TextButton(onPressed: (){}, child:Row(
                    children: [
                      Icon(icon,color: Colors.black,size: 40,),
                      Text(label,style: TextStyle(color: Colors.black,fontSize: 13))
                    ],
                  ),)
    );
  }
  Widget _buildBottomDrawerBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _bodyHeight,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
          child: Column(
            children: [
              Row(
                children: [
                  ideal(Icons.question_mark, 'Gợi ý'),
                 ideal(Icons.star, 'Hiển thị đáp án đúng')
                ],
              ),
              Row(
                children: [
                   ideal(Icons.hearing_rounded, 'Nghe Bot chọn'),
                 ideal(Icons.star_half_outlined, '50/50')
                ],
              )
            ],
          ),
        ),
      ),
    );
}
}
