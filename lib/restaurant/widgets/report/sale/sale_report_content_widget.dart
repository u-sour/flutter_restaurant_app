import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/reports/sale/sale_report_model.dart';
import '../../../providers/reports/sale_report_provider.dart';
import '../../../utils/report/sale_report_utils.dart';
import 'sale_report_content_footer_widget.dart';
import 'sale_report_content_table_widget.dart';

class SaleReportContentWidget extends StatelessWidget {
  const SaleReportContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<SaleReportProvider,
        ({SaleReportModel saleReportResult, String groupBy})>(
      selector: (context, state) =>
          (saleReportResult: state.saleReportResult, groupBy: state.groupBy),
      builder: (context, data, child) {
        return Column(
          children: [
            SaleReportContentTableWidget(
                fields: SaleReportDTRowType.values,
                saleDataReport: data.saleReportResult.data,
                groupBy: data.groupBy),
            SaleReportContentFooterWidget(saleReport: data.saleReportResult)
          ],
        );
      },
    );
  }
}
