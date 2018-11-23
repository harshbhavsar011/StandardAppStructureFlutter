import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:standardappstructure/utils/constants.dart';
import 'package:standardappstructure/utils/utils.dart';
import 'package:standardappstructure/widgets/box_customfeild.dart';
import 'package:standardappstructure/widgets/custom_textfield.dart';

class PageForgotPassword extends StatefulWidget {
  @override
  _PageForgotPasswordState createState() => _PageForgotPasswordState();
}

class _PageForgotPasswordState extends State<PageForgotPassword> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _email;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.grey.shade100,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Header(),
                    _emailFeild(),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }



  Header() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          _passwordIconWidget(),
          SizedBox(height: 24.0),
          Text("Forgot your password",
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),),
          SizedBox(height: 28.0),
          Text("Please fill your details below",
            style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal),),
        ],
      );

  CircleAvatar _passwordIconWidget() {
    return CircleAvatar(
          maxRadius: 82.0,
          child: Image.asset("assets/icons/imgforgot.png"),
          backgroundColor: Colors.blueAccent.shade50,
        );
  }
  BoxFeild _emailWidget() {
    return BoxFeild(

      hintText: "Enter email",
      lableText: "Email",
      obscureText: false,
      onSaved: (String val) {
        _email = val;
      },
      validator: validateEmail,
      icon: Icons.email,
    );
  }

  _emailFeild() =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _emailWidget(),
          SizedBox(height: 20.0),

      Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
        width: double.infinity,
        child: RaisedButton(
          padding: EdgeInsets.all(12.0),
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          color: Colors.blue,
          onPressed: () {
            setLoading(true);
            _validateInputs();
          },
        ),
      ),
    ],
  );


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
      Utils.checkConnection().then((connectionResult) {
        if (connectionResult) {
          _auth.sendPasswordResetEmail(email: _email).then((result){
            setLoading(false);
          }).catchError((error) {
            print("Errorrr - "+error.toString());
          });

        } else {
          setLoading(false);
          Utils.showAlert(context, "Flutter",
              "Internet is not connected. Please check internet connection.",
                  () {
                Navigator.pop(context);
              },true);
        }
      });
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  //Progress Indicator On/Off
  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

}
