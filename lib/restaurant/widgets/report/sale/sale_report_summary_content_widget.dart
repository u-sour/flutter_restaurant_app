import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/reports/sale/sale_summary_report_model.dart';
import '../../../providers/reports/sale_report_provider.dart';
import 'sale_report_summary_content_table_widget.dart';

class SaleReportSummaryContentWidget extends StatelessWidget {
  const SaleReportSummaryContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<SaleReportProvider, List<SaleSummaryReportModel>>(
      selector: (context, state) => state.saleSummaryReportResult,
      builder: (context, saleReportSummaryResult, child) {
        return SaleReportSummaryContentTableWidget(
          saleSummaryDataReport: saleReportSummaryResult,
        );
      },
    );
  }
}
