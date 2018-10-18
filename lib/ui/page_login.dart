import "package:flutter/material.dart";
import 'package:standardappstructure/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController textEditingController = TextEditingController();

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            BoxTextField(
              controller: textEditingController,
              hintText: "Enter email",
              lableText: "Email",
              obscure: false,
              icon: Icons.email,
            ),
            BoxTextField(
              controller: textEditingController,
              hintText: "Enter Password",
              lableText: "Password",
              obscure: true,
              icon: Icons.lock_outline,
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                color: Colors.blue,
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "Forgot Password?",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Divider(
              height: 4.0,
              color: Colors.grey,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 24.0,
                  child: Image.asset("assets/icons/icnfb.png"),
                ),
                Padding(padding: EdgeInsets.only(left: 16.0, right: 16.0)),
                CircleAvatar(
                  maxRadius: 24.0,
                  child: Image.asset("assets/icons/icn_gmail.png"),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Text("Dont have an Account?",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16.0)),
                GestureDetector(
                  onTap: () {},
                  child: Text(" Sign Up!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 16.0)),
                ),
              ],
            )
          ],
        ),
      );

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
}
