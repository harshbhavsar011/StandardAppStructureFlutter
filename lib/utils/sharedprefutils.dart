import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
class SharedPreferencesUtils {
  /// Instantiation of the SharedPreferences Instances
  static final  String _onBordingVisibility = "onBordingVisibility";

  /// Method that returns the onBoarding screen visibility
  static Future<bool> getOnBoardingVisibility() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onBordingVisibility) ?? false;
  }

  /// Method that set the  onBoarding screen visibility
  static  Future<bool> setOnBoardingVisibility(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_onBordingVisibility, value);
  }


}