import 'package:flutter/material.dart';
import 'package:standardappstructure/model/users.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:standardappstructure/service/apilistener.dart';
import 'package:standardappstructure/utils/utils.dart';
import 'package:standardappstructure/utils/constants.dart';


class WebServices {
  ApiListener mApiListener;

  final JsonDecoder _decoder = new JsonDecoder();

  WebServices(this.mApiListener);

  //This Function executed after any Success call of API
  void _onSuccessResponse(Object mObject) {
    mApiListener.onApiSuccess(mObject);
  }

  // This Function executed after any failure call of API

  void _onFailureResponse(Object mThrowable) {
    // Call on failure method of ApiListener Interface
    mApiListener.onApiFailure(mThrowable);
  }


  // This Function executed when internet connection is not available
   void _onNoInternetConnection() {
     mApiListener.onNoInternetConnection();
  }


// This Function will get list of users from web-server.
  void getUsersLists(BuildContext context) {
    // This Function will check Internet is available or not.
    Utils.checkConnection().then((connectionResult) {

      if(connectionResult){
        http.get(Constants.BASE_URL + Constants.USERS).then((http.Response response) {
          final String res = response.body;
          final int statusCode = response.statusCode;

          if (statusCode < 200 || statusCode > 400 || json == null) {
            _onFailureResponse(new Exception("Error while fetching data"));
          } else {
            //Parsing json response to particular Object.
            final parsed = json.decode(res).cast<Map<String, dynamic>>();
            List<Users> listUsers = parsed.map<Users>((json) => Users.fromJson(json)).toList();
            _onSuccessResponse(listUsers);
          }
        });
      }
      else{
        _onNoInternetConnection();
        Utils.showAlert(context, "WS call","Internet is not connected.",(){
          Navigator.pop(context);
        },true);
      }
    });
  }

  void post(String url, {Map headers, body, encoding}) {
    http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        _onFailureResponse(new Exception("Error while fetching data"));
      } else {
        _onSuccessResponse(_decoder.convert(res));
      }
    });
  }
}