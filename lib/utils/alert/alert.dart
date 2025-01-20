import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/alert/toastification_utils.dart';
import 'package:toastification/toastification.dart';

class Alert {
  static show({
    required ToastificationType type,
    ToastificationStyle style = ToastificationStyle.fillColored,
    String? title,
    String? description,
    Alignment alignment = Alignment.topCenter,
    Duration autoCloseDuration = const Duration(seconds: 2),
  }) =>
      toastification.show(
        autoCloseDuration: autoCloseDuration,
        alignment: alignment,
        type: type,
        style: style,
        title: Text(title ?? type.defaultTitle,
                style: const TextStyle(fontWeight: FontWeight.bold))
            .tr(),
        description: Text(description ?? type.defaultDescription).tr(),
        primaryColor: type.defaultColor,
      );
}
