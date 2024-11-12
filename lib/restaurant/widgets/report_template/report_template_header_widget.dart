import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_provider.dart';
import '../../providers/report-template/report_template_provider.dart';

class ReportTemplateHeaderWidget extends StatelessWidget {
  final String reportTitle;

  const ReportTemplateHeaderWidget({
    super.key,
    required this.reportTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Selector<AppProvider, String>(
          selector: (context, state) => state.company.first.general.name,
          builder: (context, companyName, child) =>
              Text(companyName, style: theme.textTheme.titleLarge),
        ),
        Text(reportTitle.tr(), style: theme.textTheme.titleLarge),
        Selector<ReportTemplateProvider, String>(
            selector: (context, state) => state.reportPeriod,
            builder: (context, reportPeriod, child) => Text(reportPeriod)),
      ],
    );
  }
}
