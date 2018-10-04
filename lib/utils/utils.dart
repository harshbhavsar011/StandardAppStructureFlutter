import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class Utils {


  static   bool isInternetAvailable = false;

  static bool isInternetConnected()  {
    checkConnection().then((connectionResult) {
      if(connectionResult){
        isInternetAvailable =  true;
      }
      else{
        isInternetAvailable =  false;
      }

    });
    return isInternetAvailable;
    }

  static Future<bool> checkConnection() async{

    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());

    print("connection : "+connectivityResult.toString());

    if ((connectivityResult == ConnectivityResult.mobile) || (connectivityResult == ConnectivityResult.wifi)){
      return true;
    } else {
      return false;
    }
  }

  static void showAlert(BuildContext context, String text) {


    var alert = new AlertDialog(
      content: Container(
        child: Row(
          children: <Widget>[Text(text)],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }


  }
