import 'package:flutter/material.dart';
import 'package:standardappstructure/model/users.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:standardappstructure/service/apilistener.dart';

class WebServices {
  ApiListener mApiListener;
  bool isShowProgressDialog;
  Future<http.Response> _response;
  static String base_url = "https://jsonplaceholder.typicode.com/";
  static String users = "users";
  final JsonDecoder _decoder = new JsonDecoder();

  WebServices(this.mApiListener, this.isShowProgressDialog) {
    initializeWebServiceCall();
  }

  void initializeWebServiceCall() async {
    var client = new http.Client();
  }

  //This Function executed after any Success call of API
  void _onSuccessResponse(Object mObject) {
    mApiListener.onApiSuccess(mObject);
  }

  //This Function executed after any failure call of API

  void _onFailureResponse(Object mThrowable) {
    //Call on failure method of ApiListener Interface
    mApiListener.onApiFailure(mThrowable);
  }


  Future<List<Users>> getUsersLists() {
    http.get(base_url + users).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        // throw new Exception("Error while fetching data");
        _onFailureResponse(new Exception("Error while fetching data"));
      } else {
        _onSuccessResponse(Users.fromJson(json.decode(res)));
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
        // throw new Exception("Error while fetching data");
        _onFailureResponse(new Exception("Error while fetching data"));
      } else {
        _onSuccessResponse(_decoder.convert(res));
      }
    });
  }
}