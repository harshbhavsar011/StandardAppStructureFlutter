import 'package:flutter/material.dart';
import 'login_bloc.dart';

class LoginProvider extends InheritedWidget {

  final loginBloc = new LoginBloc();

  LoginProvider({Key key, Widget child})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(LoginProvider) as LoginProvider).loginBloc;
  }

}