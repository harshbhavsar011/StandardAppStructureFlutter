import 'package:flutter/material.dart';
import 'package:standardappstructure/blocs/login_provider.dart';
import 'package:standardappstructure/ui/page_forgot_pass.dart';
import 'package:standardappstructure/ui/page_login.dart';
import 'package:standardappstructure/ui/page_signup.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginProvider(
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/signup': (context) => PageSignUp(),
          '/forgotpassword': (context) => PageForgotPassword(),
        },
      ),
    );
  }
}


