import 'package:flutter/material.dart';
import 'package:standardappstructure/widgets/custom_textfield.dart';

class PageForgotPassword extends StatefulWidget {
  @override
  _PageForgotPasswordState createState() => _PageForgotPasswordState();
}

class _PageForgotPasswordState extends State<PageForgotPassword> {
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
              containerBody(),
            ],
          ),
        ),
      ),
    );
  }

  containerBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Header(),
        Fields(),
      ],
    );
  }

  Header() => Column(

    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Image.asset("assets/icons/imgforgot.png"),

      SizedBox(height: 20.0),
      Text("Forgot your password",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.w500),),
      SizedBox(height: 10.0),
      Text("Please fill your details below",style: TextStyle(fontSize: 16.0,fontStyle: FontStyle.normal),),
    ],
      );

  Fields() => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      BoxTextField(
        hintText: "Enter Email",
        lableText: "Email",
        obscure: false,
        icon: Icons.email,
      ),
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
          onPressed: () {},
        ),
      ),
    ],
  );
}
