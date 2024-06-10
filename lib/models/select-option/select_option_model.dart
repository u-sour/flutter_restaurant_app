import 'package:flutter/material.dart';

class SelectOptionModel {
  final IconData? icon;
  final String label;
  final dynamic value;
  final dynamic extra;

  const SelectOptionModel({
    this.icon,
    required this.label,
    required this.value,
    this.extra,
  });
}
