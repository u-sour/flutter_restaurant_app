import 'package:flutter/material.dart';

class AvatarMenuWidgetModel {
  final String? index;
  final IconData? icon;
  final String title;
  final void Function()? onTap;

  const AvatarMenuWidgetModel({
    this.index,
    this.icon,
    required this.title,
    this.onTap,
  });
}
