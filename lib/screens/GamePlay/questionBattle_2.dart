import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/model/Question_Model.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/GamePlay/battleResult_1.dart';
import 'package:home_page/screens/GamePlay/battleResult_2.dart';

class QuestionBattle_2 extends StatefulWidget {
  QuestionBattle_2({super.key, required this.id, required this.listQuestions});
  int id;
  var listQuestions;
  @override
  State<QuestionBattle_2> createState() => _QuestionBattleState_2();
}

class _QuestionBattleState_2 extends State<QuestionBattle_2>
    with SingleTickerProviderStateMixin {
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;
  int countTime = 30;
  late AnimationController _controller;
  List<Question> questions = [];
  List<Question> randomQuestion = [];
  //Khai bao bien _currenIndex
  int _currentIndex = 0;
  bool isLock = false;
  int diem = 0;
  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
    if (_controller.isAnimating || _controller.isCompleted) {
      _controller.dispose();
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    questions = widget.listQuestions;
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: countTime));
    _controller.addListener(() {
      if (_controller.isCompleted) {
        if (_currentIndex == 9) Navigator.pop(context);
        setState(() {
          _currentIndex++;
        });
      }
    });
    _startTimer();
    //_controller.forward(); //start time
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        if (mounted) {
          setState(() {
            seconds--;
          });
        }
      } else if (_currentIndex == 9) {
        timer!.cancel();
        setState(() {
          isLock = true;
        });
        fireDb().getReady(widget.id, true);
        Future.delayed(const Duration(seconds: 1),() => 
        Navigator.push(context, 
        MaterialPageRoute(builder: (context)=>BattleResult_2(id: widget.id,))));
      } else {
        timer!.cancel();
        setState(() {
          isLock = true;
        });
        Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
          setState(() {
            seconds = maxSeconds;
            _currentIndex++;
            isLock = false;
          });
          _startTimer();
        });
      }
    });
  }

  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    /* Widget buttonAnswer(String title) {
      return Container(
        height: MediaQuery.of(context).size.height / 16,
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          border: Border.all(width: 1),
        ),
        child: TextButton(
            style: TextButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width / 1.2, 35)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BattleHistory()));
            },
            child: Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 17),
            )),
      );
    } */

    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('rooms')
            .where('id', isEqualTo: widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          String image_1;
          String name_1;
          String image_2;
          String name_2;
          try {
            var rooms = snapshot.data!.docs;
            image_1 = snapshot.data!.docs[0]['player_1.userImages'];
            name_1 = snapshot.data!.docs[0]['player_1.name'];
            image_2 = snapshot.data!.docs[0]['player_2.userImages'];
            name_2 = snapshot.data!.docs[0]['player_2.name'];
            return Container(
                decoration: Layout().background_image,
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      centerTitle: true,
                      title: const Text(
                        'Đối kháng',
                        style: TextStyle(
                            color: Color.fromARGB(255, 55, 55, 55),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      /* leading: IconButton(
                          onPressed: () async {
                            try {
                              Future.delayed(Duration.zero, () async {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, 'home', (route) => false);
                                await fireDb().getPlay(widget.id, false);
                                await fireDb().leaveRoom(widget.id);
                              });
                              //await fireDb().leaveRoom(widget.id);
                            } catch (e) {
                              const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 40,
                          )), */
                    ),
                    body: Column(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                          child: Column(children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Điểm : ${rooms[0]['player_1.score']}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      if (image_1 == '')
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 5, 0, 10),
                                            child: CircleAvatar(
                                              radius: 25,
                                              child: Text(
                                                  name_1
                                                      .substring(0, 1)
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: 30)),
                                            ))
                                      else
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 10),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'acssets/avatar/$image_1'),
                                            radius: 30,
                                          ),
                                        ),
                                      Text(
                                        rooms[0]['player_1.name'],
                                        style: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Image(
                                    image: const AssetImage("acssets/vs.png"),
                                    width: MediaQuery.of(context).size.width /4,
                                  ),
                                  Column(
                                    children: [
                                    Text(
                                      "Điểm : ${rooms[0]['player_2.score']}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    if (image_2 == '')
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 5, 0, 10),
                                            child: CircleAvatar(
                                              radius: 25,
                                              child: Text(
                                                  name_2
                                                      .substring(0, 1)
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      fontSize: 30)),
                                            ))
                                      else
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 10),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'acssets/avatar/$image_2'),
                                            radius: 30,
                                          ),
                                        ),
                                    Text(
                                      rooms[0]['player_2.name'],
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ]),
                                ],
                              ),
                            ),
                            Container(
                                //height: MediaQuery.of(context).size.height/1.5,
                                margin: const EdgeInsets.only(top: 20),
                                child: /* StreamBuilder<QuerySnapshot>(
                                  builder: (context, snapshot) {
                                    //Neu co du lieu co loi
                                    if (snapshot.hasError) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    //Neu chua co du lieu
                                    if (!snapshot.hasData) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } */
                                    /*  questions = snapshot.data!.docs
                                      .map((e) => Question.fromQueryDoucumentSnapshot(e))
                                      .toList(); */
                                    Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: Text('${_currentIndex+1}/10',style: const TextStyle(fontSize: 20),),
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                        maxHeight: MediaQuery.of(context).size.height/4.3
                                      ),
                                      //height: MediaQuery.of(context).size.height/4.3,
                                      width: 400,
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 5, 0),
                                          child: Text(
                                            questions[_currentIndex].title,
                                            style: const TextStyle(
                                                backgroundColor: Colors.white,
                                                fontSize: 20),
                                            softWrap: true,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.6,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    questions[_currentIndex]
                                                        .answer
                                                        .length;
                                                i++)
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (isLock) return;
                                                    questions[_currentIndex]
                                                                .key ==
                                                            i
                                                        ? seconds >= 27
                                                            ? diem += 25
                                                            : seconds >= 25
                                                                ? diem += 20
                                                                : seconds >= 20
                                                                    ? diem += 15
                                                                    : diem += 10
                                                        : null;
                                                      fireDb().updateScore(widget.id, 2, diem);
                                                    _controller.repeat();
                                                    if (_currentIndex == 9) {
                                                      timer!.cancel();
                                                      setState((){
                                                        isLock = true;        
                                                      });
                                                      fireDb().getReady(widget.id, true);
                                                      Future.delayed(const Duration(seconds: 1),() => 
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BattleResult_2(id: widget.id,))));
                                                    } else {
                                                      timer!.cancel();
                                                      setState(() {
                                                        isLock = true;
                                                      });
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 1,
                                                              milliseconds:
                                                                  500), () {
                                                        setState(() {
                                                          _currentIndex++;
                                                          seconds = maxSeconds;
                                                          isLock = false;
                                                        });
                                                        _startTimer();
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    width: 400,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: isLock
                                                            ? questions[_currentIndex]
                                                                        .key ==
                                                                    i
                                                                ? Colors.green
                                                                : Colors.red
                                                            : Colors.white),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      questions[_currentIndex]
                                                          .answer[i],
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                                //}),
                                ),
                          ]),
                        )),
                        Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    Text(
                                      'Thời gian : $seconds s',
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  ],
                                )),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.info_sharp,
                                      size: 40,
                                    ))
                              ],
                            ))
                      ],
                    )));
          } catch (e) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
