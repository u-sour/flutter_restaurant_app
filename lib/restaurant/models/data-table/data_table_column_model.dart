import 'package:flutter/material.dart';

class DataTableColumnModel {
  final String label;
  final dynamic value;
  final double? width;
  final Alignment alignment;

  const DataTableColumnModel({
    required this.label,
    required this.value,
    this.width,
    this.alignment = Alignment.center,
  });
}
