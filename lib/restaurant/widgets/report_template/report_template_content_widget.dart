import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants.dart';
import '../../../widgets/loading_widget.dart';
import '../../providers/report-template/report_template_provider.dart';

class ReportTemplateContentWidget extends StatelessWidget {
  final Widget reportContent;
  const ReportTemplateContentWidget({super.key, required this.reportContent});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppStyleDefaultProperties.p),
      child: Selector<ReportTemplateProvider, bool>(
        selector: (context, state) => state.isFiltering,
        builder: (context, isFiltering, child) => Stack(
          children: [
            reportContent,
            if (isFiltering) ...[
              Positioned.fill(
                child: Container(
                    color: theme.colorScheme.onPrimary.withOpacity(.8),
                    child: const LoadingWidget()),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
