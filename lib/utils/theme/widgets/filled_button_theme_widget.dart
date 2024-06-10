import 'package:flutter/material.dart';
import '../../constants.dart';

class FilledThemeWidget {
  FilledThemeWidget._();
  static final List<FilledButtonThemeData> _filledBtns = [
    FilledButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
            const EdgeInsets.all(AppStyleDefaultProperties.bp)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyleDefaultProperties.r),
          ),
        ),
      ),
    ),
    FilledButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
            const EdgeInsets.all(AppStyleDefaultProperties.bp)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyleDefaultProperties.r),
          ),
        ),
      ),
    )
  ];
  //getter
  static FilledButtonThemeData get light => _filledBtns.first;
  static FilledButtonThemeData get dark => _filledBtns.last;
}
