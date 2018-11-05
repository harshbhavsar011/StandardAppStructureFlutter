import 'dart:async';
import 'package:flutter/material.dart';
import 'package:standardappstructure/ui/introscreens/page_onboarding.dart';
import 'package:standardappstructure/ui/page_dash.dart';
import 'package:standardappstructure/ui/page_login.dart';
import 'package:standardappstructure/ui/page_signup.dart';
import 'package:standardappstructure/utils/sharedprefutils.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => PageSignUp(),
      },
    );
  }

}


