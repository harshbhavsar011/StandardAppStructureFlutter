import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    this.widget.usersData = new List();

    //Call Rest API for getting User list from server.
    WebServices(this).getUsersLists(context) as List<Users>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressWidget(isShow: this.widget.isLoading, opacity: 0.5,
        child: _homeBody(),
      ),
    );
  }


  //Home Body Widget to display list of data
  Widget _homeBody() {
    return ListView.builder(
        itemCount: this.widget.usersData.length,
        itemBuilder: (BuildContext ctxt, int index) {
          //  return new Text(this.widget.usersData[index].name);
          return new ListTile(
            onTap: null,
            contentPadding: EdgeInsets.all(8.0),

            leading: new CircleAvatar(
              backgroundColor: Colors.blue,
            ),
            title: new Text(this.widget.usersData[index].name),
            trailing: Icon(Icons.person),

          );
        });
  }

  //Do you work If Internet is not available
  @override
  void onApiFailure(Exception exception) {
    setLoading(false);
    Utils.showAlert(context, "Ws call", "Something went wrong.",(){
      Navigator.pop(context);
    });
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
