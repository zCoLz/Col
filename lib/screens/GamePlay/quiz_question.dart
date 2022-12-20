import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:home_page/components/constants.dart';
import 'package:home_page/components/time.dart';
import 'package:home_page/model/Question_Model.dart';
import 'package:home_page/screens/GamePlay/difficult.dart';
import 'package:home_page/screens/GamePlay/listLevel.dart';
import 'package:home_page/screens/TabBar/history.dart';

class Questions extends StatefulWidget {
  const Questions({Key? key, required this.idSubject, required this.level})
      : super(key: key);
  final int idSubject;
  final int level;
  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions>
    with SingleTickerProviderStateMixin {
  double _headerHeight = 55.0;
  double _bodyHeight = 250.0;

  final countTime = 600;
  late AnimationController _controller;
  //Khai bao bien _currenIndex
  int _currentIndex =0;
  bool flag = false;
  BottomDrawerController bottom = BottomDrawerController();
  final _firestore = FirebaseFirestore.instance;
  //List Question
  List<Question> questions = [];
//Xu ly button cau tra loi
  bool isLock = false;
  int diem = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_controller.isAnimating || _controller.isCompleted) {
      _controller.dispose();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: countTime));
    _controller.addListener(() {
      if (_controller.isCompleted) {
        if (_currentIndex == 9) Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Difficult(idSubject: widget.idSubject)));
        setState(() {
          _currentIndex++;
        });
      }
    });
    _controller.forward(); //start time
  }

  Widget build(BuildContext context) {
    var snapshots = _firestore
        .collection('questions')
        .where('level', isEqualTo: widget.level)
        .where('subject.id', isEqualTo: widget.idSubject)
        .snapshots();
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

    return StreamBuilder(
        stream: snapshots,
        builder: (context, snapshot) {
          //Neu co du lieu co loi
          if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          //Neu chua co du lieu
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          questions = snapshot.data!.docs
              .map((e) => Question.fromQueryDoucumentSnapshot(e))
              .toList();
          // debugPrint(questions.length.toString());

          // questions.forEach(
          //   (element) {
          //     debugPrint(element.toString());
          //   },
          // );
          return Container(
              decoration: Layout().background_image,
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      'Javascipt',
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
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                              child: Column(children: [
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Center(
                                      child: Text(
                                        "${_currentIndex + 1}/10",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    )),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Điểm ${diem}',
                                      style: TextStyle(fontSize: 23),
                                    )),
                                    Time(
                                        animation:
                                            StepTween(begin: countTime, end: 0)
                                                .animate(_controller))
                                  ],
                                ),
                                // Container(
                                //   margin: EdgeInsets.fromLTRB(0, 30, 0, 50),
                                //   child: Text(
                                //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                //     style: TextStyle(
                                //         fontSize: 15,
                                //         fontStyle: FontStyle.italic,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //   children: [
                                //     buttonAnswer('Đáp án 1'),
                                //     buttonAnswer('Đáp án 2')
                                //   ],
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                //   children: [
                                //     buttonAnswer('Đáp án 3'),
                                //     buttonAnswer('Đáp án 4')
                                //   ],
                                // ),
                                Divider(
                                  thickness: 2,
                                  color: Colors.black,
                                ),
                                Container(
                                  width: 350,
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 5, 0),
                                    child: Text(
                                      questions[_currentIndex].title,
                                      style: TextStyle(
                                          backgroundColor: Colors.white,
                                          fontSize: 20),
                                      softWrap: true,
                                    ),
                                  ),
                                ),
                                for (int i = 0;
                                    i < questions[_currentIndex].answer.length;
                                    i++)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (isLock) return;
                                        questions[_currentIndex].key == i
                                            ? diem++
                                            : null;
                                        _controller.repeat();
                                        if (_currentIndex == 9) {
                                          setState(() {
                                            isLock = true;
                                            showDialog(context: context, builder: (context)=> _showDiaglog(context));
                                          });
                                          
                                        } else {
                                          setState(() {
                                            isLock = true;
                                          });
                                          Future.delayed(
                                              Duration(
                                                  seconds: 1,
                                                  milliseconds: 500), () {
                                            setState(() {
                                              _currentIndex++;
                                              isLock = false;
                                            });
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: 400,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: isLock
                                                ? questions[_currentIndex]
                                                            .key ==
                                                        i
                                                    ? Colors.green
                                                    : Colors.red
                                                : Colors.white),
                                        padding: EdgeInsets.all(15),
                                        child: Text(
                                          questions[_currentIndex].answer[i],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                              ]),
                            )),
                          ],
                        ),
                        _buildBottomDrawer(context)
                      ],
                    ),
                  )));
        });
  }

  Widget _showDiaglog(BuildContext context) {
    return AlertDialog(

      content: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Điểm",style: TextStyle(fontSize: 30),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$diem/10',style: TextStyle(fontSize: 22),),
              ),
              ElevatedButton(onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LevelList()), (route) => false);
              }, child: Text("Ok",style: TextStyle(fontSize: 15),))
            ]),
      ),
    );
  }

  Widget _buildBottomDrawer(BuildContext context) {
    return BottomDrawer(
      header: _buildBottomDrawerHead(context),
      body: _buildBottomDrawerBody(context),
      headerHeight: _headerHeight,
      drawerHeight: _bodyHeight,
      color: Colors.white.withOpacity(0.5),
      controller: bottom,
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

  Widget _buildBottomDrawerHead(BuildContext context) {
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
                    if (flag == false) {
                      bottom.open();
                      flag = true;
                    } else {
                      bottom.close();
                      flag = false;
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

  Widget ideal(IconData icon, String label) {
    return Container(
        width: MediaQuery.of(context).size.width / 2.2,
        height: MediaQuery.of(context).size.width / 7,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
        child: TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 40,
              ),
              Text(label, style: TextStyle(color: Colors.black, fontSize: 13))
            ],
          ),
        ));
  }

  Widget _buildBottomDrawerBody(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _bodyHeight,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
