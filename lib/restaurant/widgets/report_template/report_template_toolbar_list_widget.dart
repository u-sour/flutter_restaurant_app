import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReportTemplateToolbarListWidget extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool?)? onChanged;
  const ReportTemplateToolbarListWidget(
      {super.key, required this.label, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(label.tr()),
      value: value,
      onChanged: onChanged,
    );
  }
}
