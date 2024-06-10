import 'dart:ui';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../constants.dart';

enum AWESOMESNACKBARTYPE { success, failure, warning, info }

extension AwesomeSnackBarExtension on AWESOMESNACKBARTYPE {
  Color get defaultColor {
    switch (this) {
      case AWESOMESNACKBARTYPE.success:
        return AppThemeColors.success;
      case AWESOMESNACKBARTYPE.failure:
        return AppThemeColors.failure;
      case AWESOMESNACKBARTYPE.warning:
        return AppThemeColors.warning;
      case AWESOMESNACKBARTYPE.info:
        return AppThemeColors.info;
      default:
        return AppThemeColors.success;
    }
  }

  String get defaultTitle {
    switch (this) {
      case AWESOMESNACKBARTYPE.success:
        return "alert.success.title";
      case AWESOMESNACKBARTYPE.failure:
        return "alert.failure.title";
      case AWESOMESNACKBARTYPE.warning:
        return "alert.warning.title";
      case AWESOMESNACKBARTYPE.info:
        return "alert.info.title";
      default:
        return "alert.success.title";
    }
  }

  String get defaultMessage {
    switch (this) {
      case AWESOMESNACKBARTYPE.success:
        return "alert.success.message";
      case AWESOMESNACKBARTYPE.failure:
        return "alert.failure.message";
      case AWESOMESNACKBARTYPE.warning:
        return "alert.warning.message";
      case AWESOMESNACKBARTYPE.info:
        return "alert.info.message";
      default:
        return "alert.success.message";
    }
  }

  ContentType get defaultContentType {
    switch (this) {
      case AWESOMESNACKBARTYPE.success:
        return ContentType.success;
      case AWESOMESNACKBARTYPE.failure:
        return ContentType.failure;
      case AWESOMESNACKBARTYPE.warning:
        return ContentType.warning;
      case AWESOMESNACKBARTYPE.info:
        return ContentType.help;
      default:
        return ContentType.success;
    }
  }
}
