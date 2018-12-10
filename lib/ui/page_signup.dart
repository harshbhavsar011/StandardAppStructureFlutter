import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:standardappstructure/ui/page_login.dart';
import 'package:standardappstructure/utils/constants.dart';
import 'package:standardappstructure/utils/utils.dart';
import 'package:standardappstructure/widgets/box_customfeild.dart';
import 'package:standardappstructure/widgets/custom_textfield.dart';
import 'package:standardappstructure/widgets/progressview.dart';

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
  String passString;
  String confirmPassString;

// Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ProgressWidget(
        isShow: isLoading,
        opacity: 0.6,
        child: Container(
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
                            _pwdFeildWidget(),
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
      ),
    );
  }

  Container _signUpButtonWidget() {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: height / 40, horizontal: width / 15),
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.all(12.0),
        child: Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        color: Colors.blue,
        onPressed: () {
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
      icon: Icons.lock_outline,
      validator: validatePasswordMatching,
      onChanged: (String val) {
        confirmPassString = val;
      },
      onSaved: (String val) {
        _confirmPassoword = val;
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


  Container _pwdFeildWidget(){
    return Container(
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: width / 30,
          ),
          Expanded(
              child: Container(
                margin: EdgeInsets.only(top: height / 400, bottom: height / 400, left: width / 50, right: width / 50),
                padding: EdgeInsets.all(height / 100),
                alignment: Alignment.center,
                height: height / 14,
                decoration:  BoxDecoration(
                    color: Colors.grey.shade100,
                    border:  Border.all(color: Colors.grey.shade400, width: 1.0),
                    borderRadius:  BorderRadius.circular(8.0)),
                child:  TextFormField(
                  key: passKey,
                  obscureText: true,
                  controller: _passwordController,
                  onSaved: (String val) {
                    _password = val;
                  },
                  validator: validatePassword,
                  decoration:  InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: height/34,
                      ),
                    hintText: "Enter Password",
                    ),
                ),
              )),
        ],
      ),
      padding: EdgeInsets.only(bottom : height / 58),
      margin: EdgeInsets.only(
          top: height / 50, right: width / 20, left: width / 30),
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

  String validatePasswordMatching(String value) {
    var password = passKey.currentState.value;

    if (value.length == 0) {
      return "Password is Required";
    } else if (value != password) {
      return 'Password is not matching';
    }
    return null;
  }



  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      //If all data are correct then save data to out variables
      //Make a REST Api Call with success Go to Login Page after User Created.

      _formKey.currentState.save();
      setLoading(true);

      Utils.checkConnection().then((connectionResult) {
        if (connectionResult) {
          firebaseSignUp();
        } else {
          setLoading(false);
          Utils.showAlert(context, "Flutter",
              "Internet is not connected. Please check internet connection.",
              () {
            Navigator.pop(context);
          }, true);
        }
      });
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void firebaseSignUp() {
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
      }, false);
    })
      ..catchError((e) {
        setLoading(false);
        Utils.showAlert(
            context, "Flutter", "User is already registred with this Email-ID.",
            () {
          Navigator.pop(context);
        }, true);
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
