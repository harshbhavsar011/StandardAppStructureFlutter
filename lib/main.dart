import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:standardappstructure/ui/introscreens/page_onboarding.dart';
import 'package:standardappstructure/ui/page_dash.dart';
import 'package:standardappstructure/ui/page_login.dart';
import 'package:standardappstructure/ui/page_signup.dart';
import 'package:standardappstructure/ui/page_splash.dart';
import 'package:standardappstructure/utils/sharedprefutils.dart';


void main() => runApp(defaultTargetPlatform == TargetPlatform.iOS ? IOSApp() : AndroidApp());


class IOSApp extends StatefulWidget {
  @override
  IOSAppState createState() {
    return new IOSAppState();
  }

}

class IOSAppState extends State<IOSApp> {
  Widget firstScreen;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class AndroidApp extends StatefulWidget {
  @override
  AndroidAppState createState() {
    return new AndroidAppState();
  }
}

class AndroidAppState extends State<AndroidApp> {

  Widget firstScreen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
        home: SplashScreen()
    );
  }
}





