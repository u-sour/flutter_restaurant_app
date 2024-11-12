import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/select-option/select_option_model.dart';

class ReportListWidget extends StatelessWidget {
  final SelectOptionModel report;
  const ReportListWidget({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: ListTile(
        onTap: () => context.pushNamed(report.value),
        leading: Icon(report.icon),
        title: Text(context.tr(report.label)),
      ),
    );
  }
}
