import 'package:flutter/material.dart';
import 'package:standardappstructure/widgets/box_customfeild.dart';


class PageSignUp extends StatefulWidget {
  @override
  _PageSignUpState createState() => _PageSignUpState();
}

class _PageSignUpState extends State<PageSignUp> {
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
              BoxFeild(
                controller: textEditingController,
                hintText: "Enter Name",
                lableText: "Name",
                icon: Icons.person,
              ),

              BoxFeild(
                controller: textEditingController,
                hintText: "Enter Email",
                lableText: "Email",
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              BoxFeild(
                controller: textEditingController,
                hintText: "Enter Mobile Number",
                lableText: "Mobile Number",
                keyboardType: TextInputType.phone,
                icon: Icons.phone,
              ),

              BoxFeild(
                controller: textEditingController,
                hintText: "Enter Password",
                lableText: "Password",
                obscureText: true,
                icon: Icons.lock_outline,
              ),
              BoxFeild(
                controller: textEditingController,
                hintText: "Confirm Password",
                lableText: "Confirm Password",
                obscureText: true,
                icon: Icons.lock_outline,
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  color: Colors.blue,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
