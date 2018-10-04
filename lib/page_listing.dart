import 'package:flutter/material.dart';
import 'package:standardappstructure/model/users.dart';
import 'package:standardappstructure/service/apilistener.dart';
import 'service/webservices.dart';
import 'widgets/progressview.dart';



class ListPage extends StatefulWidget {
  bool isLoading = false;
  String _data = "HAS";

  List<Users> usersData;

  @override
  _MyAppState createState() => _MyAppState();

}


class _MyAppState extends State<ListPage> implements ApiListener {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.widget.usersData = new List();
    //setLoading(true);
    WebServices(this, true).getUsersLists() as List<Users>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ws Calls"),
      ),
      body: ProgressWidget(inAsyncCall: true,
        opacity: 0.5,
        child: _homeBody(),
      ),
    );
  }

  Widget _homeBody() {
    return ListView.builder
      (
        itemCount: this.widget.usersData.length,

        itemBuilder: (BuildContext ctxt, int index) {
          return new Text(this.widget.usersData[index].name);
        }

    );
  }

  @override
  void onApiFailure(Exception exception) {
    setLoading(false);
  }

  @override
  void onApiSuccess(Object mObject) {
    setLoading(false);

    if (mObject is List<Users>) {
      print("Yesss Users ." + mObject.toString());
    }
    this.widget.usersData.addAll(mObject);

    print("dd " + mObject.toString());
  }

  void setLoading(bool loading) {
    setState(() {
      this.widget.isLoading = loading;
    });
  }



}