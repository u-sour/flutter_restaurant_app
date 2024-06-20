import 'package:flutter/material.dart';
import '../constants.dart';
import 'widgets/app_bar_theme_widget.dart';
import 'widgets/bottom_nav_bar_theme_widget.dart';
import 'widgets/elevated_button_theme_widget.dart';
import 'widgets/filled_button_theme_widget.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
        primary: AppThemeColors.primary,
        secondary: AppThemeColors.secondary,
        onSecondary: Colors.white),
    fontFamily: AppThemeFonts.en,
    fontFamilyFallback: AppThemeFonts.fonts,
    appBarTheme: AppBarThemeWidget.light,
    textTheme: const TextTheme(labelLarge: TextStyle(color: Colors.white)),
    elevatedButtonTheme: ElevatedThemeWidget.light,
    filledButtonTheme: FilledThemeWidget.light,
    bottomNavigationBarTheme: BottomNavBarThemeWidget.light,
    listTileTheme:
        ListTileThemeData(selectedTileColor: AppThemeColors.primary.shade100),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: AppThemeColors.primary,
        onSecondary: Colors.white),
    fontFamily: AppThemeFonts.en,
    fontFamilyFallback: AppThemeFonts.fonts,
    appBarTheme: AppBarThemeWidget.dark,
    textTheme:
        const TextTheme(labelLarge: TextStyle(color: AppThemeColors.primary)),
    elevatedButtonTheme: ElevatedThemeWidget.dark,
    filledButtonTheme: FilledThemeWidget.dark,
    bottomNavigationBarTheme: BottomNavBarThemeWidget.dark,
    listTileTheme: const ListTileThemeData(selectedTileColor: Colors.white10),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
