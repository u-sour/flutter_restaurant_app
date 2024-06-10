import 'package:dart_meteor/dart_meteor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  // Create SharedPreferences
  final Future<SharedPreferences> _authPrefs = SharedPreferences.getInstance();

  // Login Token
  void setLoginToken({required MeteorClientLoginResult loginResult}) async {
    SharedPreferences authPrefs = await _authPrefs;
    authPrefs.setString('loginToken', loginResult.token);
    authPrefs.setString('loginTokenExpires',
        loginResult.tokenExpires.millisecondsSinceEpoch.toString());
  }

  Future<Map<String, dynamic>> getLoginToken() async {
    SharedPreferences authPrefs = await _authPrefs;

    // Convert login token expires from String to DateTime
    DateTime expires = DateTime.now();
    if (authPrefs.getString('loginTokenExpires') != null) {
      String tokenExpiresStr = authPrefs.getString('loginTokenExpires')!;
      int milliseconds = int.parse(tokenExpiresStr);
      expires = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    }

    Map<String, dynamic> loginToken = {
      'loginToken': authPrefs.getString('loginToken'),
      'loginTokenExpires': expires
    };

    return loginToken;
  }

  void clearLoginToken() async {
    SharedPreferences authPrefs = await _authPrefs;
    authPrefs.remove('loginToken');
    authPrefs.remove('loginTokenExpires');
  }

  // User
  void setUser({required Map<String, dynamic> userDoc}) async {
    SharedPreferences authPrefs = await _authPrefs;
    authPrefs.setString('id', userDoc['_id']);
    authPrefs.setString('username', userDoc['username']);
    authPrefs.setString('fullName', userDoc['profile']['fullName']);
  }

  Future<Map<String, dynamic>> getUser() async {
    SharedPreferences authPrefs = await _authPrefs;
    Map<String, dynamic> user = {
      'id': authPrefs.getString('id'),
      'username': authPrefs.getString('username'),
      'fullName': authPrefs.getString('fullName'),
    };

    return user;
  }

  void clearUser() async {
    SharedPreferences authPrefs = await _authPrefs;
    authPrefs.remove('id');
    authPrefs.remove('username');
    authPrefs.remove('fullName');
  }

  // Remember me
  void setRememberMe({required bool rememberMe}) async {
    SharedPreferences authPrefs = await _authPrefs;
    authPrefs.setBool('rememberMe', rememberMe);
  }

  Future<bool?> getRememberMe() async {
    SharedPreferences authPrefs = await _authPrefs;
    return authPrefs.getBool('rememberMe');
  }

  void clearRememberMe() async {
    SharedPreferences authPrefs = await _authPrefs;
    authPrefs.remove('rememberMe');
  }
}
