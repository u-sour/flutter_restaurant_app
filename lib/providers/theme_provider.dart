import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  // getter
  ThemeMode get themeMode => _themeMode;

  // setter
  set themeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  // methods
  void switchTheme(ThemeMode value) => themeMode = value;
}
