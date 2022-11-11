import 'package:flutter/material.dart';
import 'package:home_page/screens/GamePlay/listLevel.dart';

class Question extends StatefulWidget {
  Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
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
            color: Colors.white,
            border: Border.all(width: 3),
            borderRadius: BorderRadius.circular(40)),
      );
    }

    return Scaffold(
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
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("acssets/background2.jpg"),
                  fit: BoxFit.cover)),
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.fromLTRB(20, 50, 20, 10),
          child: Column(
            children: <Widget>[
              Expanded(
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
              ),
              Container(
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
                      Icon(
                        Icons.info_sharp,
                        size: 40,
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
