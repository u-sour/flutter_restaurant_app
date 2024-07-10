import 'package:flutter/material.dart';
import 'package:flutter_template/utils/theme/widgets/outlined_button_theme_widget.dart';
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
    dividerTheme: DividerThemeData(color: Colors.grey.shade300),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppThemeColors.primary;
        }
        return null;
      }),
    ),
    elevatedButtonTheme: ElevatedThemeWidget.light,
    filledButtonTheme: FilledThemeWidget.light,
    outlinedButtonTheme: OutlinedThemeWidget.light,
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
    dividerTheme: DividerThemeData(color: Colors.grey.shade300),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppThemeColors.primary;
        }
        return null;
      }),
    ),
    elevatedButtonTheme: ElevatedThemeWidget.dark,
    filledButtonTheme: FilledThemeWidget.dark,
    outlinedButtonTheme: OutlinedThemeWidget.dark,
    bottomNavigationBarTheme: BottomNavBarThemeWidget.dark,
    listTileTheme: const ListTileThemeData(selectedTileColor: Colors.white10),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
