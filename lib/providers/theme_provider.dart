import 'package:flutter/material.dart';
import '../storages/theme_storage.dart';

class ThemeProvider extends ChangeNotifier {
  final ThemeStorage _themeStorage = ThemeStorage();
  ThemeMode _themeMode = ThemeMode.system;

  Future<void> initState() async {
    final String? theme = await _themeStorage.getTheme();
    if (theme != null) {
      switch (theme) {
        case "light":
          switchTheme(ThemeMode.light);
          break;
        case "dark":
          switchTheme(ThemeMode.dark);
          break;
        default:
          switchTheme(ThemeMode.system);
      }
    }
  }

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
