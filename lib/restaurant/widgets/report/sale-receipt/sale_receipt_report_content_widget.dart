import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/reports/sale-receipt/sale_receipt_report_model.dart';
import '../../../providers/reports/sale_receipt_report_provider.dart';
import '../../../utils/report/sale_receipt_report_utils.dart';
import 'sale_receipt_report_content_footer_widget.dart';
import 'sale_receipt_report_content_table_widget.dart';

class SaleReceiptReportContentWidget extends StatelessWidget {
  const SaleReceiptReportContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<SaleReceiptReportProvider, SaleReceiptReportModel>(
      selector: (context, state) => state.saleReceiptReportResult,
      builder: (context, saleReceiptReportResult, child) {
        return Column(
          children: [
            SaleReceiptReportContentTableWidget(
              fields: SaleReceiptReportDTRowType.values,
              saleReceiptDataReport: saleReceiptReportResult.data,
            ),
            SaleReceiptReportContentFooterWidget(
                saleReceiptTotalDoc: saleReceiptReportResult.totalDoc)
          ],
        );
      },
    );
  }
}
