import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:standardappstructure/ui/introscreens/page_onboarding.dart';
import 'package:standardappstructure/ui/page_dash.dart';
import 'package:standardappstructure/ui/page_forgot_pass.dart';
import 'package:standardappstructure/ui/page_signup.dart';
import 'package:standardappstructure/utils/constants.dart';
import 'package:standardappstructure/utils/sharedprefutils.dart';
import 'package:standardappstructure/utils/utils.dart';
import 'package:standardappstructure/widgets/box_customfeild.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:standardappstructure/widgets/progressview.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

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
  bool isLoggedIn = false;
  var profileData;
// Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  var facebookLogin = FacebookLogin();

  GoogleSignInAccount _googleUser;

  String _email, _password;
  bool isLoading = false;
  double width;
  double height;
  Future<FirebaseUser> _googleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;

    FirebaseUser firebaseUser = await _auth.signInWithGoogle(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    print("Google User : ${firebaseUser.displayName}");
    return firebaseUser;
  }

  void _googleSignOut() {
    googleSignIn.signOut();
    print("Google user Signed out");
  }

  //Progress Indicator On/Off
  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

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
                  child: loginBody(),
                ),
              ))),
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
                SizedBox(height: height*0.04),
                _loginButtonWidget(),
                SizedBox(height: height*0.02),
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PageForgotPassword()),
                      );
                    },
                    child: Text("Forgot Password?", style: TextStyle(fontSize: 16.0))),
                SizedBox(height: height*0.02),
                Divider(height: 4.0, color: Colors.grey),
                SizedBox(height: height*0.02),
                _socialButtons(),
                SizedBox(height: height*0.04),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Dont have an Account?",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 16.0)),
                    SizedBox(width: width*0.03),
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
        GestureDetector(
           /* onTap: () => facebookLogin.isLoggedIn
                .then((isLoggedIn) => isLoggedIn ? facebookLogout() : {})*/

           onTap: ()=> initiateFacebookLogin()
          ,
          child: CircleAvatar(
            maxRadius: 24.0,
            child: Image.asset("assets/icons/icnfb.png"),
          ),
        ),
        Padding(padding: EdgeInsets.only(left: width*0.04, right: width*0.04)),
        GestureDetector(
          onTap: () {
            checkUser();
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            maxRadius: 24.0,
            child: Image.asset("assets/icons/icngmail.png"),
          ),
        )
      ],
    );
  }

  void checkUser() {
    //Check if the user is signed in or not.
    if (_auth.currentUser() != null) {
      setState(() {
        //if the user is signed in
        print('Already signed In');
        googleSignIn.signOut();
      });
    } else {
      //call signIn method to make the user sign In
      _googleSignIn()
          .then((FirebaseUser user) => print(user))
          .catchError((e) {
            print(e);
      });
    }
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
      Utils.checkConnection().then((connectionResult) {
        if (connectionResult) {
          setLoading(true);
          handleSignInEmail(_email, _password).then((FirebaseUser user) {
            print(user);
            setLoading(false);



            SharedPreferencesUtils.setLogin(true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          })
            ..catchError((e) {

              setLoading(false);
              Utils.showAlert(context, "Flutter", "User not found please signup first.",
                      () {
                    Navigator.pop(context);
                  },true);
            });
        } else {
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

  Future<FirebaseUser> handleSignInEmail(String email, String password) async {
    final FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    if (user == null) {
      setLoading(false);
      Utils.showAlert(context, "Flutter", "User not found please signup first.",
          () {
        Navigator.pop(context);
      },true);
    } else {
      assert(await user.getIdToken() != null);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      print('signInEmail succeeded: $user');
      return user;
    }
  }

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;

      if(isLoggedIn){
        SharedPreferencesUtils.setLogin(true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()),
        );
      }
    });
  }

  facebookLogout() async {
    await facebookLogin.logOut();
    onLoginStatusChanged(false);
    print("Logged out");
  }


    void initiateFacebookLogin() async {
      var facebookLoginResult =
      await facebookLogin.logInWithReadPermissions(['email']);

      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.error:
          onLoginStatusChanged(false);
          break;
        case FacebookLoginStatus.cancelledByUser:
          onLoginStatusChanged(false);
          break;
        case FacebookLoginStatus.loggedIn:
          var graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult
                  .accessToken.token}');
          var profile = json.decode(graphResponse.body);
          print(profile.toString());

          onLoginStatusChanged(true, profileData: profile);
          break;
      }
    }



}
