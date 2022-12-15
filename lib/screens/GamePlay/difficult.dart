import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_page/components/Layout.dart';
import 'package:home_page/screens/GamePlay/quiz_question.dart';
class Difficult extends StatefulWidget {
  const Difficult({super.key,required this.idSubject});
  final int idSubject;
  @override
  State<Difficult> createState() => _DifficultState();
}

class _DifficultState extends State<Difficult> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: Layout().background_image,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 40,
                  )),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('subjects').where('id',isEqualTo: widget.idSubject).snapshots(),
              builder: (context, snapshot) {
                try{
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 20, 0, 40),
                      child: Text(
                        'Chủ đề :  ${snapshot.data!.docs[0]['title']}',
                        style:
                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('acssets/subject/${snapshot.data!.docs[0]['subjectImage']}'),
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.width / 2.5,
                          ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20, top: 50),
                          width: MediaQuery.of(context).size.width / 2.7,
                          height: MediaQuery.of(context).size.width / 8.5,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(width: 2),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black, offset: Offset(3, 3))
                              ]),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Questions(idSubject: widget.idSubject,level: 1,)));
                            },
                            child: const Text(
                              'Dễ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600)
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20, top: 20),
                          width: MediaQuery.of(context).size.width / 2.7,
                          height: MediaQuery.of(context).size.width / 8.5,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(width: 2),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black, offset: Offset(3, 3))
                              ]),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Questions(idSubject: widget.idSubject,level: 2,)));
                            },
                            child: const Text(
                              'Trung bình',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        /* Container(
                          margin: const EdgeInsets.only(bottom: 20, top: 20),
                          width: MediaQuery.of(context).size.width / 2.7,
                          height: MediaQuery.of(context).size.width / 8.5,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Questions(idSubject: widget.idSubject,level: 3,) ));
                            },
                            child: const Text(
                              'Khó',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),), */
                          Container(
                            margin: const EdgeInsets.only(bottom: 20, top: 20),
                            width: MediaQuery.of(context).size.width / 2.7,
                            height: MediaQuery.of(context).size.width / 8.5,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(width: 2),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black, offset: Offset(3, 3))
                                ]),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.black),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Questions(idSubject: widget.idSubject,level: 3,) ));
                              },
                              child: const Text(
                                'Khó',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
                }catch(e){
                  return const Center(child: CircularProgressIndicator(),);
                }
                }
            )
            ));
  }
}
