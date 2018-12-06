import 'dart:async';
import 'package:flutter/material.dart';
import 'package:standardappstructure/ui/introscreens/page_onboarding.dart';
import 'package:standardappstructure/ui/page_dash.dart';
import 'package:standardappstructure/ui/page_login.dart';
import 'package:standardappstructure/utils/sharedprefutils.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {

      SharedPreferencesUtils.getOnBoardScreen().then((value) {
        if (value) {
          //Navigate to OnBoarding Screen.
          //Navigate to OnBoarding First Time..
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OnboardingMainPage()));
        } else {
          SharedPreferencesUtils.getLogin().then((value) {
            if (value) {
              //Navigate to DashBoard If user already logged In.
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()));
            }else{
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            }
          });
        }
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Expanded(
          child: FlutterLogo(
            size: 60.0,
          ),
        ),
      )
    );
  }
}