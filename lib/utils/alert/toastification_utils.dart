import 'dart:ui';
import 'package:toastification/toastification.dart';
import '../constants.dart';

extension ToastificationExtension on ToastificationType {
  Color get defaultColor {
    switch (this) {
      case ToastificationType.error:
        return AppThemeColors.failure;
      case ToastificationType.warning:
        return AppThemeColors.warning;
      case ToastificationType.info:
        return AppThemeColors.info;
      default:
        return AppThemeColors.success;
    }
  }

  String get defaultTitle {
    switch (this) {
      case ToastificationType.error:
        return "alert.failure.title";
      case ToastificationType.warning:
        return "alert.warning.title";
      case ToastificationType.info:
        return "alert.info.title";
      default:
        return "alert.success.title";
    }
  }

  String get defaultDescription {
    switch (this) {
      case ToastificationType.error:
        return "alert.failure.message";
      case ToastificationType.warning:
        return "alert.warning.message";
      case ToastificationType.info:
        return "alert.info.message";
      default:
        return "alert.success.message";
    }
  }
}
