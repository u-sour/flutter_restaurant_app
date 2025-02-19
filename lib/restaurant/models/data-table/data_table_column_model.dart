import 'package:flutter/material.dart';

class DataTableColumnModel {
  final String label;
  final dynamic value;
  final double? width;
  final MainAxisAlignment headingRowAlignment;

  const DataTableColumnModel({
    required this.label,
    required this.value,
    this.width,
    this.headingRowAlignment = MainAxisAlignment.center,
  });
}
