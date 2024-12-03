import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  // Create SharedPreferences
  final Future<SharedPreferences> _themePrefs = SharedPreferences.getInstance();

  void setTheme({required ThemeMode themeMode}) async {
    SharedPreferences themePrefs = await _themePrefs;
    themePrefs.setString('themeMode', themeMode.name);
  }

  Future<String?> getTheme() async {
    SharedPreferences themePrefs = await _themePrefs;
    return themePrefs.getString('themeMode');
  }
}
