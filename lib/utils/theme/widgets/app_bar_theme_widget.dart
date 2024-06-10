import 'package:flutter/material.dart';

class AppBarThemeWidget {
  AppBarThemeWidget._();
  static final List<AppBarTheme> _appBars = [
    const AppBarTheme(),
    const AppBarTheme()
  ];
  //getter
  static AppBarTheme get light => _appBars.first;
  static AppBarTheme get dark => _appBars.last;
}
