import 'package:flutter/material.dart';
import 'package:standardappstructure/ui/page_listing.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey.shade200,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.call_to_action,
              color: Colors.black87,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          shrinkWrap: false,
          crossAxisCount: 2,
          crossAxisSpacing: 1.0,
          padding: EdgeInsets.all(1.0),
          children: <Widget>[
            makeDashboardItem(
                "Users",
                Icons.person,
                gradientBankCard(Color.fromRGBO(230, 79, 149, 1.0),
                    Color.fromRGBO(229, 79, 140, 0.7)),(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListPage()),
              );
            }),
            makeDashboardItem(
                "Posts",
                Icons.featured_play_list,
                gradientBankCard(Color.fromRGBO(140, 128, 255, 1.0),
                    Color.fromRGBO(140, 128, 255, 0.8)),(){

            }),
            makeDashboardItem(
                "Countries",
                Icons.flag,
                gradientBankCard(Color.fromRGBO(255, 138, 50, 1.0),
                    Color.fromRGBO(255, 138, 50, 0.8)),(){

            }),
            makeDashboardItem(
                "Comments",
                Icons.alarm,
                gradientBankCard(Color.fromRGBO(134, 146, 160, 1.0),
                    Color.fromRGBO(134, 146, 160, 0.9)),(){

            }),
            makeDashboardItem(
                "Albums",
                Icons.photo_album,
                gradientBankCard(Color.fromRGBO(78, 152, 254, 1.0),
                    Color.fromRGBO(84, 187, 251, 1.0)),(){

            }),
            // makeDashboardItem("Posts", Icons.featured_play_list,gradientBankCard(Color.fromRGBO(44, 178, 155,1.0),  Color.fromRGBO(44, 178, 155,0.7))),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }

  LinearGradient gradientBankCard(Color startColor, Color endColor) {
    return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [startColor, endColor],
        stops: [0.0, 0.7]);
  }

  Card makeDashboardItem(
      String title, IconData icon, LinearGradient linearGradient,VoidCallback onTap) {
    return Card(
        elevation: 6.0,
        margin: new EdgeInsets.all(10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Container(
          decoration: BoxDecoration(
              gradient: linearGradient,
              borderRadius: BorderRadius.circular(16.0)),
          child: new InkWell(
            onTap: onTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.white,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.white)),
                )
              ],
            ),
          ),
        ));
  }
}
