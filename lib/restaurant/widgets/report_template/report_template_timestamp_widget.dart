import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_provider.dart';
import '../../../utils/constants.dart';
import '../../providers/report-template/report_template_provider.dart';

class ReportTemplateTimestampWidget extends StatelessWidget {
  const ReportTemplateTimestampWidget({super.key});
  final String _prefixRTLayoutsTimestampBy =
      'screens.reportTemplate.layouts.children.timestamp.children.by';
  @override
  Widget build(BuildContext context) {
    ReportTemplateProvider reportTemplateProvider =
        context.read<ReportTemplateProvider>();
    return Padding(
      padding: const EdgeInsets.only(top: AppStyleDefaultProperties.p),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Selector<AppProvider, String?>(
              selector: (context, state) => state.currentUser?.profile.fullName,
              builder: (context, fullName, child) => Text(
                  '${_prefixRTLayoutsTimestampBy.tr()} $fullName (${reportTemplateProvider.formatDateReportTimestamp(dateTime: DateTime.now())})')),
        ],
      ),
    );
  }
}
