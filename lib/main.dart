import 'package:flutter/material.dart';
import 'package:home_page/screens/Login/page_login.dart';
import 'package:home_page/screens/Login/form_login_signup.dart';
import 'package:home_page/screens/home_cart.dart';
import 'package:home_page/screens/home_notifications.dart';
import 'package:home_page/components/home_page.dart';
import 'package:home_page/screens/home_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage_Login_SignUp(),
    );
  }
}

