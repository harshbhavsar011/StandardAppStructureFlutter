import 'package:flutter/material.dart';
import 'package:standardappstructure/ui/page_login.dart';
import 'package:standardappstructure/utils/constants.dart';
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
              Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Column(
                    children: <Widget>[
                      _nameWidget(),
                      _emailWidget(),
                      _phoneWidget(),
                      _passwordWidget(),
                      _confirmPassWidget(),
                      SizedBox(height: 30.0),
                      _signUpButtonWidget()
                    ],
                  )),
            ],
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
      validator: validatePassword,
      onSaved: (String val) {
        _name = val;
      },
    );
  }

  BoxFeild _phoneWidget() {
    return BoxFeild(
      hintText: "Enter Mobile Number",
      lableText: "Mobile Number",
      keyboardType: TextInputType.phone,
      icon: Icons.phone,
      validator: validateMobile,
      onSaved: (String val) {
        _phoneNo = val;
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

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return "Phone number is Required";
    } else if (value.length != 10) {
      return "Phone number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Phone Number must be digits";
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
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      //Make a REST Api Call with success Go to Login Page after User Created.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }


}
