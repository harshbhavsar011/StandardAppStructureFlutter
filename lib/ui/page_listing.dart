import 'package:flutter/material.dart';
import 'package:standardappstructure/model/childitem.dart';
import 'package:standardappstructure/model/users.dart';
import 'package:standardappstructure/service/apilistener.dart';
import 'package:standardappstructure/service/webservices.dart';
import 'package:standardappstructure/utils/utils.dart';
import 'package:standardappstructure/widgets/progressview.dart';

class ListPage extends StatefulWidget {
  bool isLoading = true;
  List<Users> usersData;
  String titleToolbar;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ListPage> implements ApiListener {
  bool internetCheck = true;

  @override
  void initState() {
    super.initState();
    this.widget.usersData = new List();
    Utils.checkConnection().then((connectionResult) {
      if (connectionResult) {
        //Call Rest API for getting User list from server.
        WebServices(this).getUsersLists(context) as List<Users>;
      } else {
        internetCheck = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(230, 79, 149, 1.0),
        title: Text("Users"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),onPressed:(){

    })
        ],
      ),
      body: internetCheck
          ? ProgressWidget(
              isShow: this.widget.isLoading,
              opacity: 0.5,
              child: _homeBody(),
            )
          : Container(
              child: Center(
              child: Text("Internet is not connected please Try again.!"),
            )),
    );
  }

  //Home Body Widget to display list of data
  Widget _homeBody() {
    return ListView.builder(
        itemCount: this.widget.usersData.length,
        itemBuilder: (BuildContext ctxt, int index) {
          //  return new Text(this.widget.usersData[index].name);
          return Container(
            child: new ListTile(
              onTap: (){

              },
              contentPadding: EdgeInsets.all(16.0),
              leading: new CircleAvatar(
                backgroundColor: Color.fromRGBO(230, 79, 149, 0.9),
                radius: 24.0,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: new Text(this.widget.usersData[index].name),
              trailing: Icon(Icons.keyboard_arrow_right),
              dense: true,
            ),
          );
        });
  }

  //Do you work If Internet is not available
  @override
  void onApiFailure(Exception exception) {
    setLoading(false);
    Utils.showAlert(context, "Ws call", "Something went wrong.", () {
      Navigator.pop(context);
    }, true);
  }

  //Do you work If Internet is not available
  @override
  void onNoInternetConnection() {
    setLoading(false);
  }

  //Get All Webservices responses here through Object.
  @override
  void onApiSuccess(Object mObject) {
    setLoading(false);

    //Get All Users
    if (mObject is List<Users>) {
      this.widget.usersData.addAll(mObject);
    }
  }

  //Progress Indicator On/Off
  void setLoading(bool loading) {
    setState(() {
      this.widget.isLoading = loading;
    });
  }
}
