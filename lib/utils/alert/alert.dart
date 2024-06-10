import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'awesome_snack_bar_utils.dart';

class Alert {
  static SnackBar awesomeSnackBar({
    String? title,
    String? message,
    required AWESOMESNACKBARTYPE type,
  }) =>
      SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        padding: const EdgeInsets.only(top: 48.0),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Builder(builder: (context) {
          return AwesomeSnackbarContent(
            color: type.defaultColor,
            title: context.tr(title ?? type.defaultTitle),
            message: context.tr(message ?? type.defaultMessage),

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: type.defaultContentType,
          );
        }),
      );
}
