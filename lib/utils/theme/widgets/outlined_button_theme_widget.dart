import 'package:flutter/material.dart';
import '../../constants.dart';

class OutlinedThemeWidget {
  OutlinedThemeWidget._();
  static final List<OutlinedButtonThemeData> _outlinedBtns = [
    OutlinedButtonThemeData(
      style: ButtonStyle(
        side: WidgetStateProperty.all(
          const BorderSide(color: AppThemeColors.primary),
        ),
      ),
    ),
    OutlinedButtonThemeData(
      style: ButtonStyle(
        side: WidgetStateProperty.all(
          const BorderSide(color: Colors.white),
        ),
      ),
    )
  ];
  //getter
  static OutlinedButtonThemeData get light => _outlinedBtns.first;
  static OutlinedButtonThemeData get dark => _outlinedBtns.last;
}
