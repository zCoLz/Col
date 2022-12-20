import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:home_page/model/Question_Model.dart';
import 'package:home_page/model/dbContext.dart';
import 'package:home_page/screens/GamePlay/difficult.dart';
import 'package:home_page/screens/GamePlay/listLevel.dart';

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
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;
  int countTime = 30;
  late AnimationController _controller;
  //Khai bao bien _currenIndex
  int _currentIndex =0;
  bool flag = false;
  BottomDrawerController bottom = BottomDrawerController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  //List Question
  List<Question> questions = [];
//Xu ly button cau tra loi
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
    _startTimer();
    //_controller.forward(); //start time
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        if(mounted){
        setState(() {
          seconds--;
        });
        }
      } else if(_currentIndex == 9) {
        timer!.cancel();
        setState(() {
          isLock = true;
        });
        Future.delayed(const Duration(seconds: 1),(() {
          showDialog(
              context: context, builder: (context) => _showDiaglog(context));
        }));
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
  @override
  Widget build(BuildContext context) {
    var snapshots = _firestore
        .collection('questions')
        .where('level', isEqualTo: widget.level)
        .where('subject.id', isEqualTo: widget.idSubject)
        .snapshots();
    /* Widget buttonAnswer(String title) {
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
    } */

    return StreamBuilder(
        stream: snapshots.take(10),
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
                      snapshot.data!.docs[0]['subject.title'],
                      style: const TextStyle(
                          color: Color.fromARGB(255, 55, 55, 55),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: IconButton(
                        onPressed: () async{
                          timer!.cancel();
                          bool? result = await showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: const Text('Đang tạm dừng'),
                              content: const Text('Bạn có muốn thoát ra không ?'),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context)=>const LevelList()), (route) => false);
                                }, child:const Text('Có')),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: const Text('Không')),
                              ],
                            );
                            }
                            );
                            if(result==null) _startTimer();
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 40,
                        )),
                  ),
                  body: Stack(
                    children: [
                      Column(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            height: MediaQuery.of(context).size.height,
                            margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                            child: Column(children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Center(
                                    child: Text(
                                      "${_currentIndex + 1}/10",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  )),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    'Điểm : $diem',
                                    style: const TextStyle(fontSize: 23),
                                  )),
                                  /* Time(
                                      animation:
                                          StepTween(begin: countTime, end: 0)
                                              .animate(_controller)) */
                                  Row(
                                    children: [
                                      const Text('Thời gian : ',style: TextStyle(fontSize: 25),),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width/13,
                                        child: Text(
                                          '$seconds',
                                          style: const TextStyle(fontSize: 25),textAlign: TextAlign.right,
                                        ),
                                      ),
                                      const Text(' s',style: TextStyle(fontSize: 25),)
                                    ],
                                  )
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
                              const Divider(
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
                                    style: const TextStyle(
                                        backgroundColor: Colors.white,
                                        fontSize: 20),
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height/2,
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                for (int i = 0;
                                    i < questions[_currentIndex].answer.length;
                                    i++)
                                  Container(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (isLock) return;
                                        questions[_currentIndex].key == i
                                            ? seconds>=25 ? diem+=20 
                                            : seconds>=20 ? diem+=15
                                            : diem+=10
                                            : null;
                                        _controller.repeat();
                                        if (_currentIndex == 9) {
                                          timer!.cancel();
                                          setState(() {
                                            isLock = true;
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    _showDiaglog(context));
                                          });
                                        } else {
                                          timer!.cancel();
                                          setState(() {
                                            isLock = true;
                                          });
                                          Future.delayed(
                                              const Duration(
                                                  seconds: 1,
                                                  milliseconds: 500), () {
                                            setState(() {
                                              _currentIndex++;
                                              seconds=maxSeconds;
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
                                                BorderRadius.circular(100),
                                            color: isLock
                                                ? questions[_currentIndex]
                                                            .key ==
                                                        i
                                                    ? Colors.green
                                                    : Colors.red
                                                : Colors.white),
                                        padding: const EdgeInsets.all(15),
                                        child: Text(
                                          questions[_currentIndex].answer[i],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                    ],),),
                              ),
                                
                            ]),
                          )),
                        ],
                      ),
                      _buildBottomDrawer(context)
                    ],
                  )));
        });
  }
 bool unclock = false;
 String title = '';
  Widget _showDiaglog(BuildContext context) {
    String score = 'Điểm của bạn ';
    return StreamBuilder(
      stream: _firestore.collection('users').where('email',isEqualTo: _auth.currentUser!.email).snapshots(),
      builder: (context, snapshot) {
        try{
           int chapter;
        if(snapshot.data!.docs[0]['highScore']<diem)
          {
            score = 'Điểm cao nhất ';
            fireDb().setHighScore(diem);
          }
        if(snapshot.data!.docs[0]['chapter']== widget.idSubject-1 && diem>150){
            chapter = snapshot.data!.docs[0]['chapter'];
            fireDb().unClockChapter(++chapter);
            setState(() async{
              unclock=true;
              int count = await fireDb().countChapter();
              if(chapter-1 == count){
              title = 'Chúc mừng bạn đã qua màn. Màn tiếp theo sẽ được cập nhật trong tương lai';
              }else{
              title = 'Chúc mừng bạn đã mở khóa màn tiếp theo';
              }
            });
        }
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    score,
                    style: const TextStyle(fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$diem',
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if(unclock){
                          showDialog(context: context, builder: (context)=>AlertDialog(
                            title: Text(title),
                            actions: [
                            Center(child: TextButton(onPressed: (){
                                Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LevelList()),
                            (route) => false);
                              }, child: const Text('OK'))
                          )],
                          )
                        );
                        }else{
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LevelList()),
                            (route) => false);
                      }},
                      child: const Text(
                        "Ok",
                        style: TextStyle(fontSize: 15),
                      ))
                ]),
          ),
        );
      }catch(e){
        return const Center(child: CircularProgressIndicator(),);
      }
      }
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
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: Row(
          children: [
            Expanded(
                child: Row(
              children: const [
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
                icon: const Icon(
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
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
        child: TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 40,
              ),
              Text(label, style: const TextStyle(color: Colors.black, fontSize: 13))
            ],
          ),
        ));
  }

  Widget _buildBottomDrawerBody(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _bodyHeight,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
