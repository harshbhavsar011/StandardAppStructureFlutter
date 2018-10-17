import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:standardappstructure/utils/constants.dart';

bool _isValidEmail(String email) {
  return RegExp(Constants.PATTERN_EMAIL, caseSensitive: false).hasMatch(email);
}

bool _isValidPassword(String password) {
  return password.length >= 6;
}

class LoginBloc{
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();


  Function(String) get changeEmail    => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Stream<bool>   get submitValid => Observable.combineLatest2(_email, _password, (e, p) => true);



  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (_isValidEmail(email)) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (_isValidPassword(password)) {
        sink.add(password);
      } else {
        sink.addError('Password should not be less than 6.');
      }
    },
  );

  submit() {
    final validEmail    = _email.value;
    final validPassword = _password.value;
    print('$validEmail and $validPassword');
  }

  dispose() {
    _email.close();
    _password.close();
  }
}
