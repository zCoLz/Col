import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_page/screens/Login/form_login_signup.dart';
import 'package:home_page/screens/home.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute:
          FirebaseAuth.instance.currentUser == null ? 'welcome' : 'home',
      routes: {
        'welcome': (context) => HomePage_Login_SignUp(),
        'home': (context) => Home(),
      },
      // home: AddQuestion(),
    );
  }
} 
// class AddQuestion extends StatefulWidget {
//   const AddQuestion({super.key});

//   @override
//   State<AddQuestion> createState() => _AddQuestionState();
// }

// class _AddQuestionState extends State<AddQuestion> {
//   final _fireStore = FirebaseFirestore.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: ElevatedButton(onPressed: (() {
//        _fireStore.collection('questions').add({
//           'id': 132,
//           'title': '',
//           'answer':['orange','indigo','blue','yellow'],
//           'key': 3,
//           'subject':{'id':5,'title' :'Python'},
//           'level': 3
//        });
//       }), child: Text("add"))),
//     );
//   }
// }
