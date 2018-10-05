import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            loginBody(),
          ],
        ),
      ),
    );
  }

  loginFields() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter your username",
                  labelText: "Username",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextField(
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                ),
              ),
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
                  style: TextStyle(color: Colors.white,fontSize: 18.0),
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
            RichText(
              text: new TextSpan(children:
            <TextSpan>[
              new TextSpan(text: 'Dont have an Account?  ',style: new TextStyle(fontWeight: FontWeight.normal,
                 color: Colors.black,
                 fontSize: 16.0 )),
              new TextSpan(text: ' Sign Up!', style: new TextStyle(fontWeight: FontWeight.bold,
              color: Colors.blue,fontSize: 16.0 )),
            ], ), )
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
