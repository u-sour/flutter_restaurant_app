import 'package:flutter/material.dart';

class ScreenListTileWidgetModel {
  final String? index;
  final IconData icon;
  final String title;
  final void Function()? onTap;

  const ScreenListTileWidgetModel({
    this.index,
    required this.icon,
    required this.title,
    this.onTap,
  });
}
