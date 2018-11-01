import "package:flutter/material.dart";
import 'package:standardappstructure/ui/page_signup.dart';
import 'package:standardappstructure/utils/constants.dart';
import 'package:standardappstructure/widgets/box_customfeild.dart';
import 'package:standardappstructure/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  FocusNode _emailFocusNode = new FocusNode();
  FocusNode _passFocusNode = new FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.grey.shade200,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              loginBody(),
            ],
          ),
        ),
      ),
    );
  }

  loginFields() => Container(
        child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _emailWidget(),
                _passwordWidget(),
                SizedBox(height: 30.0),
                _loginButtonWidget(),
                SizedBox(height: 16.0),
                Text("Forgot Password?", style: TextStyle(fontSize: 16.0)),
                SizedBox(height: 16.0),
                Divider(height: 4.0, color: Colors.grey),
                SizedBox(height: 16.0),
                _socialButtons(),
                SizedBox(height: 30.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Dont have an Account?",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 16.0)),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PageSignUp()),
                        );
                      },
                      child: Text(" Sign Up!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 18.0)),
                    ),
                  ],
                )
              ],
            )),
      );

  Row _socialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          maxRadius: 24.0,
          child: Image.asset("assets/icons/icnfb.png"),
        ),
        Padding(padding: EdgeInsets.only(left: 16.0, right: 16.0)),
        CircleAvatar(
          maxRadius: 24.0,
          child: Image.asset("assets/icons/icngmail.png"),
        )
      ],
    );
  }

  Container _loginButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.all(12.0),
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        color: Colors.blue,
        onPressed: () {
          _validateInputs();
        },
      ),
    );
  }

  BoxFeild _emailWidget() {
    return BoxFeild(
      controller: _emailController,
      focusNode: _emailFocusNode,
      hintText: "Enter email",
      lableText: "Email",
      obscureText: false,
      onSaved: (String val) {
        _email = val;
      },
      validator: validateEmail,
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(_passFocusNode);
      },
      icon: Icons.email,
    );
  }

  BoxFeild _passwordWidget() {
    return BoxFeild(
      controller: _passwordController,
      focusNode: _passFocusNode,
      hintText: "Enter Password",
      lableText: "Password",
      obscureText: true,
      icon: Icons.lock_outline,
      validator: validatePassword,
      onSaved: (String val) {
        _password = val;
      },
    );
  }

  loginHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlutterLogo(
            size: 80.0,
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      );

  loginBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        loginHeader(),
        loginFields(),
      ],
    );
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      return "Password is Required";
    } else if (value.length < 6) {
      return "Password Should be more than 6.";
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


  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      // Go to Dashboard
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }


}
