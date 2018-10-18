import 'package:flutter/material.dart';
import 'package:standardappstructure/widgets/custom_textfield.dart';


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
              BoxTextField(
                controller: textEditingController,
                hintText: "Enter Name",
                lableText: "Name",
                obscure: false,
                icon: Icons.person,
              ),

              BoxTextField(
                controller: textEditingController,
                hintText: "Enter Email",
                lableText: "Email",
                obscure: true,
                icon: Icons.email,
              ),
              BoxTextField(
                controller: textEditingController,
                hintText: "Enter Mobile Number",
                lableText: "Mobile Number",
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
            ],
          ),
        ),
      ),
    );
  }

}
