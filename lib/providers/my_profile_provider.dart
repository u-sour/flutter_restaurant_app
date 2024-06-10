import 'package:flutter/foundation.dart';

class MyProfileProvider extends ChangeNotifier {
  bool _isFromEnabled = false;

  // getter
  get isFromEnabled => _isFromEnabled;

  // setter
  set setIsFormEnabled(bool value) {
    _isFromEnabled = value;
    notifyListeners();
  }

  // methods
  void changeFormEnabled(bool value) => setIsFormEnabled = value;
}
