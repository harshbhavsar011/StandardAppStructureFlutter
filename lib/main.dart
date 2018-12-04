import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:standardappstructure/ui/introscreens/page_onboarding.dart';
import 'package:standardappstructure/ui/page_dash.dart';
import 'package:standardappstructure/ui/page_login.dart';
import 'package:standardappstructure/ui/page_signup.dart';
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
    firstScreen = LoginPage();
    /*SharedPreferencesUtils.getOnBoardScreen().then((value) {
      if (value) {
        //Navigate to OnBoarding Screen.
        //Navigate to OnBoarding First Time..
        firstScreen = OnboardingMainPage();
      } else {

        SharedPreferencesUtils.getLogin().then((value) {
          if (value) {
            //Navigate to DashBoard If user already logged In.
            firstScreen = Dashboard();
          }else{
            firstScreen = LoginPage();
          }

        });



      }
    });*/
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: firstScreen,
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

    SharedPreferencesUtils.getOnBoardScreen().then((value) {
      if (value) {
        //Navigate to OnBoarding Screen.
        //Navigate to OnBoarding First Time..
        firstScreen = OnboardingMainPage();
      } else {
        firstScreen = LoginPage();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
        home: firstScreen
    );
  }
}





