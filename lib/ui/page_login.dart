import "package:flutter/material.dart";
import 'package:standardappstructure/blocs/login_bloc.dart';
import 'package:standardappstructure/blocs/login_provider.dart';
import 'package:standardappstructure/ui/page_signup.dart';
import 'package:standardappstructure/widgets/box_customfeild.dart';
import 'package:standardappstructure/widgets/custom_textfield.dart';
import 'page_forgot_pass.dart';

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
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {}

  @override
  Widget build(BuildContext context) {
    final loginBloc = LoginProvider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.grey.shade200,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              loginBody(loginBloc),
            ],
          ),
        ),
      ),
    );
  }

  loginFields(LoginBloc loginBloc) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            StreamBuilder(
                stream: loginBloc.email,
                builder: (context, snapshot) {
                  return BoxFeild(
                    controller: _emailController,
                    hintText: "Enter email",
                    lableText: "Email",
                    focusNode: _emailFocusNode,
                    onChanged: loginBloc.changeEmail,
                    obscureText: false,
                    errorText: snapshot.error,
                    onSaved: (String val) {
                      _email = val;
                    },
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(_passFocusNode);
                    },
                    icon: Icons.email,
                  );
                }),
            StreamBuilder(
                stream: loginBloc.password,
                builder: (context, snapshot) {
                  return BoxFeild(
                    controller: _passwordController,
                    hintText: "Enter Password",
                    lableText: "Password",
                    onChanged: loginBloc.changePassword,
                    obscureText: true,
                    icon: Icons.lock_outline,
                    onSaved: (String val) {
                      _password = val;
                    },
                  );
                }),
            SizedBox(
              height: 30.0,
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                width: double.infinity,
                child: StreamBuilder(
                    stream: loginBloc.submitValid,
                    builder: (context, snapshot) {
                      return RaisedButton(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {

                            if(snapshot.hasData){
                              print("on Login Pressed");
                              snapshot.hasData ? loginBloc.submit : null;
                            }else{
                              print("No Data");

                            }
                          });

                        },
                      );
                    })),
            SizedBox(
              height: 16.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageForgotPassword()),
                );
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Divider(
              height: 4.0,
              color: Colors.grey,
            ),
            SizedBox(
              height: 16.0,
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
                  maxRadius: 22.0,
                  backgroundColor: Colors.white,
                  child: Image.asset("assets/icons/icng.png"),
                )
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
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

  loginBody(LoginBloc loginBloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        loginHeader(),
        loginFields(loginBloc),
      ],
    );
  }
}
