import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class CustomFormBuilderInputStyle {
  CustomFormBuilderInputStyle._();

  static InputDecoration fbInputStyle(
      {required String labelText,
      bool require = false,
      required ThemeData theme}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 12.0, top: 0.0),
      label: require
          ? RichText(
              text: TextSpan(
                  text: '*',
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: AppThemeColors.failure),
                  children: [
                  TextSpan(
                      text: labelText.tr(), style: theme.textTheme.bodyMedium)
                ]))
          : Text(labelText.tr()),
    );
  }

  static InputDecoration fbSearchInputStyle(
      {IconData prefixIcon = AppDefaultIcons.search,
      String hintText = 'screens.formBuilderInputDecoration.search'}) {
    return InputDecoration(
      prefixIcon: Icon(prefixIcon),
      hintText: hintText.tr(),
    );
  }
}
