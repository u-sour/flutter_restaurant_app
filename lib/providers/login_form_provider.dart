import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFormProvider with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  bool _showPassword = true;
  bool _rememberMe = false;
  late String _username;
  LoginFormProvider(this.sharedPreferences);

  // getter
  bool get showPassword => _showPassword;
  bool get rememberMe => _rememberMe;
  String get username => _username;

  // setter
  set setShowPassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  // methods
  void initState() {
    _rememberMe = sharedPreferences.getBool('rememberMe') ?? false;
    _username = "";
    if (_rememberMe) {
      _username = sharedPreferences.getString('username')!;
    }
  }

  void switchShowPassword(bool value) => setShowPassword = value;
}
