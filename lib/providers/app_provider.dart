import 'dart:async';
import 'package:dart_meteor/dart_meteor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/screens/app_screen.dart';
import 'package:flutter_template/storages/auth_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
String ONBOARD_KEY = "GD2G82CG9G82VDFGVD22DVG";

class AppProvider extends ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  // final StreamController<bool> _loginStateChange =
  //     StreamController<bool>.broadcast();
  bool _connected = false;
  bool _loginState = false;
  bool _initialized = false;
  bool _onboarding = false;
  AppProvider(this.sharedPreferences);

  //getter
  // Stream<bool> get loginStateChange => _loginStateChange.stream;
  bool get connected => _connected;
  bool get loginState => _loginState;
  bool get initialized => _initialized;
  bool get onboarding => _onboarding;

  //setter
  set loginState(bool state) {
    _loginState = state;
    // _loginStateChange.add(state);
    notifyListeners();
  }

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  set onboarding(bool value) {
    sharedPreferences.setBool(ONBOARD_KEY, value);
    _onboarding = value;
    notifyListeners();
  }

  //methods
  Future<void> onAppInit() async {
    _onboarding = sharedPreferences.getBool(ONBOARD_KEY) ?? false;
    // This is just to demonstrate the splash screen is working.
    // In real-life applications, it is not recommended to interrupt the user experience by doing such things.
    await Future.delayed(const Duration(seconds: 2));
    _initialized = true;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    // Keep listening to server connection
    meteor.status().listen((onData) {
      _connected = onData.connected;
      if (_connected) {
        meteor.user().listen((onData) {
          _loginState = onData != null ? true : false;
          notifyListeners();
        });
      }
      notifyListeners();
    });

    // Auto login if login token exist
    AuthStorage authStorage = AuthStorage();
    final loginTokenResult = await authStorage.getLoginToken();
    if (loginTokenResult['loginToken'] != null) {
      try {
        final result = await meteor.loginWithToken(
            token: loginTokenResult['loginToken'],
            tokenExpires: loginTokenResult['loginTokenExpires']);
        if (result != null && result.userId.isNotEmpty) {
          _loginState = true;
          authStorage.setLoginToken(loginResult: result);
          notifyListeners();
        }
      } catch (e) {
        if (e is MeteorError) {
          // print(e.message);
        }
      }
    }
  }
}
