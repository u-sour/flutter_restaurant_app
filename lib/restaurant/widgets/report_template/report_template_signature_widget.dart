import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants.dart';
import '../../providers/report-template/report_template_provider.dart';

class ReportTemplateSignatureWidget extends StatelessWidget {
  const ReportTemplateSignatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ReportTemplateProvider readReportTemplateProvider =
        context.read<ReportTemplateProvider>();
    return Padding(
      padding: const EdgeInsets.only(top: AppStyleDefaultProperties.p),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0;
              i < readReportTemplateProvider.reportSignature.length;
              i++)
            Text(readReportTemplateProvider.reportSignature[i].tr())
        ],
      ),
    );
  }
}
