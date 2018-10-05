import 'package:flutter/material.dart';
import 'package:standardappstructure/ui/page_dashboard.dart';
import 'package:standardappstructure/ui/page_home.dart';
import 'package:standardappstructure/ui/page_listing.dart';
import 'package:standardappstructure/ui/page_dashboard.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home:  DashboardPage(),
    );
  }
}


