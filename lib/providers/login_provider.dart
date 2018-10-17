import 'package:flutter/material.dart';
import 'package:standardappstructure/blocs/login_bloc.dart';

class LoginProvider extends InheritedWidget {
  const LoginProvider({
    Key key,
    @required Widget child,
  })
      : assert(child != null),
        super(key: key, child: child);

  static LoginProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(LoginProvider) as LoginProvider;
  }

  @override
  bool updateShouldNotify(LoginProvider old) {
    return true;
  }
}