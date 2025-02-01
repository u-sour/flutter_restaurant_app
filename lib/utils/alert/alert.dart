import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/alert/toastification_utils.dart';
import 'package:toastification/toastification.dart';

class Alert {
  static show({
    required ToastificationType type,
    ToastificationStyle style = ToastificationStyle.fillColored,
    String? title,
    Map<String, String>? titleNamedArgs,
    String? description,
    Map<String, String>? descriptionNamedArgs,
    Alignment alignment = Alignment.topCenter,
    Duration autoCloseDuration = const Duration(seconds: 3),
  }) =>
      toastification.show(
        autoCloseDuration: autoCloseDuration,
        alignment: alignment,
        type: type,
        style: style,
        title: Text(title ?? type.defaultTitle,
                style: const TextStyle(fontWeight: FontWeight.bold))
            .tr(namedArgs: titleNamedArgs),
        description: Text(description ?? type.defaultDescription)
            .tr(namedArgs: descriptionNamedArgs),
        primaryColor: type.defaultColor,
      );
}
