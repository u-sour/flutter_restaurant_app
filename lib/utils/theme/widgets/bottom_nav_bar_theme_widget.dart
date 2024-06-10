import 'package:flutter/material.dart';
import '../../constants.dart';

class BottomNavBarThemeWidget {
  BottomNavBarThemeWidget._();
  static final List<BottomNavigationBarThemeData> _bottomNavBars = [
    BottomNavigationBarThemeData(
      backgroundColor: AppThemeColors.primary[700],
      selectedItemColor: AppThemeColors.primary,
      selectedLabelStyle: const TextStyle(color: Colors.white),
      unselectedLabelStyle: const TextStyle(color: Colors.white),
    ),
    BottomNavigationBarThemeData(
      backgroundColor: AppThemeColors.primary[700],
      selectedItemColor: AppThemeColors.primary,
      selectedLabelStyle: const TextStyle(color: Colors.white),
      unselectedLabelStyle: const TextStyle(color: Colors.white),
    ),
  ];
  //getter
  static BottomNavigationBarThemeData get light => _bottomNavBars.first;
  static BottomNavigationBarThemeData get dark => _bottomNavBars.last;
}
