import 'package:flutter/material.dart';
import 'package:standardappstructure/page_home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      showPerformanceOverlay: false,
      home:  HomePage(),
    );
  }
}
