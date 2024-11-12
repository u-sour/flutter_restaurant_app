import 'dart:async';
import 'package:dart_meteor/dart_meteor.dart';
import 'package:flutter/foundation.dart';
import '../models/auth/login_model.dart';
import '../models/servers/response_model.dart';
import '../widgets/screens/app_screen.dart';
import '../storages/auth_storage.dart';
import '../utils/alert/awesome_snack_bar_utils.dart';

class AuthProvider extends ChangeNotifier {
  final String _successMsg =
      'screens.login.children.form.alert.success.message';
  bool _loading = false;
  final StreamController<bool> _onAuthStateChange =
      StreamController.broadcast();

  // getter
  bool get loading => _loading;
  Stream<bool> get onAuthStateChange => _onAuthStateChange.stream;

  // methods
  Future<ResponseModel> login({required LoginModel formDoc}) async {
    final AuthStorage authStorage = AuthStorage();
    ResponseModel result = ResponseModel(
        status: 201, message: _successMsg, type: AWESOMESNACKBARTYPE.success);
    _loading = true;
    notifyListeners();
    try {
      final result = await meteor.loginWithPassword(
          formDoc.username, formDoc.password,
          delayOnLoginErrorSecond: 1);
      _onAuthStateChange.add(true);
      if (result.userId.isNotEmpty) {
        // set current user doc and login token to storage
        authStorage.setUser(userDoc: meteor.userCurrentValue()!);
        authStorage.setLoginToken(loginResult: result);
        _loading = false;
      }
      // set rememberMe with auth storage if rememberMe == true
      if (formDoc.rememberMe) {
        authStorage.setRememberMe(rememberMe: formDoc.rememberMe);
      } else {
        // clear rememberMe with auth storage if rememberMe == false
        authStorage.clearRememberMe();
      }
    } catch (e) {
      if (e is MeteorError) {
        result = ResponseModel(
            status: e.error,
            message: e.message!,
            type: AWESOMESNACKBARTYPE.failure);
        _loading = false;
      }
    }
    notifyListeners();
    return result;
  }

  void logOut() {
    final AuthStorage authStorage = AuthStorage();
    authStorage.clearLoginToken();
    meteor.logout();
    _onAuthStateChange.add(false);
  }
}
