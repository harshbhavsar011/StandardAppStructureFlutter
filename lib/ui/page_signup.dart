import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:standardappstructure/ui/page_login.dart';
import 'package:standardappstructure/utils/constants.dart';
import 'package:standardappstructure/utils/utils.dart';
import 'package:standardappstructure/widgets/box_customfeild.dart';
import 'package:standardappstructure/widgets/custom_textfield.dart';

class PageSignUp extends StatefulWidget {
  @override
  _PageSignUpState createState() => _PageSignUpState();
}

class _PageSignUpState extends State<PageSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();

  bool _autoValidate = false;
  String _name, _email, _phoneNo, _password, _confirmPassoword;
  bool isLoading = false;

// Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FocusNode _nameFocusNode = new FocusNode();
  FocusNode _emailFocusNode = new FocusNode();
  FocusNode _phoneNoFocusNode = new FocusNode();
  FocusNode _passFocusNode = new FocusNode();
  FocusNode _cofirmpassFocusNode = new FocusNode();

  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.grey.shade200,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Form(
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child: Column(
                        children: <Widget>[
                          _nameWidget(),
                          _emailWidget(),
                          _passwordWidget(),
                          _confirmPassWidget(),
                          SizedBox(height: 30.0),

                        ],
                      )),
                  _signUpButtonWidget()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _signUpButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.all(12.0),
        child: Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        color: Colors.blue,
        onPressed: () {
          setLoading(true);
          _validateInputs();
        },
      ),
    );
  }

  BoxFeild _confirmPassWidget() {
    return BoxFeild(
      hintText: "Confirm Password",
      lableText: "Confirm Password",
      obscureText: true,
      controller: _confirmPassController,
      icon: Icons.lock_outline,
      validator: validatePasswordMatching,
      onSaved: (String val) {
        _confirmPassoword = val;
      },
    );
  }

  BoxFeild _passwordWidget() {
    return BoxFeild(
      key: passKey,
      hintText: "Enter Password",
      lableText: "Password",
      obscureText: true,
      icon: Icons.lock_outline,
      controller: _passwordController,
      validator: validatePassword,
      onSaved: (String val) {
        _password = val;
      },
    );
  }

  BoxFeild _emailWidget() {
    return BoxFeild(
      hintText: "Enter Email",
      lableText: "Email",
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      validator: validateEmail,
      onSaved: (String val) {
        _email = val;
      },
    );
  }

  BoxFeild _nameWidget() {
    return BoxFeild(
      hintText: "Enter Name",
      lableText: "Name",
      icon: Icons.person,
      validator: validateName,
      onSaved: (String val) {
        _name = val;
      },
    );
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateEmail(String value) {
    RegExp regExp = RegExp(Constants.PATTERN_EMAIL, caseSensitive: false);

    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Enter valid email address.";
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      return "Password is Required";
    } else if (value.length < 6) {
      return "Password Should be more than 6.";
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.length == 0) {
      return "Password is Required";
    }
    return null;
  }


  String validatePasswordMatching(String value) {
    var password = passKey.currentState.value;

    if (value.length == 0) {
      return "Password is Required";
    } else if (value != password) {
      return 'Password is not matching';
    }
    return null;
  }



  /*bool validatePasswordMatching() {

    if (_passwordController.text != _confirmPassController.text) {
      Utils.showAlert(context, "Flutter", "Passwords are not matched.", () {
        Navigator.pop(context);
      },true);
      return false;
    } else {
      return true;
    }
  }*/

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      //Make a REST Api Call with success Go to Login Page after User Created.

        _formKey.currentState.save();


        Utils.checkConnection().then((connectionResult) {
          if (connectionResult) {
            firebaseSignUp();
          } else {
            setLoading(false);
            Utils.showAlert(context, "Flutter",
                "Internet is not connected. Please check internet connection.",
                    () {
                  Navigator.pop(context);
                },true);
          }
        });


        /*if (validatePasswordMatching()) {

          Utils.checkConnection().then((connectionResult) {
            if (connectionResult) {
              firebaseSignUp();
            } else {
              setLoading(false);
              Utils.showAlert(context, "Flutter",
                  "Internet is not connected. Please check internet connection.",
                      () {
                    Navigator.pop(context);
                  },true);
            }
          });
        }else{
          setLoading(false);
          setState(() {
            _autoValidate = true;
          });
        }*/




    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void firebaseSignUp() {
    setLoading(true);
    handleSignUp(_email, _password).then((FirebaseUser user) {
      print(user);
      setLoading(false);

      Utils.showAlert(context, "Flutter", "You have registered successfully.",
          () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },false);
    })
      ..catchError((e) {
        setLoading(false);
        Utils.showAlert(
            context, "Flutter", "User is already registred with this Email-ID.",
            () {
          Navigator.pop(context);
        },true);
      });
  }

  //Progress Indicator On/Off
  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  Future<FirebaseUser> handleSignUp(email, password) async {
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    assert(user != null);
    assert(await user.getIdToken() != null);

    return user;
  }
}
