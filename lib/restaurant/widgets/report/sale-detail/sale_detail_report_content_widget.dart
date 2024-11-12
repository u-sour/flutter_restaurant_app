import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/reports/sale-detail/sale_detail_report_model.dart';
import '../../../providers/reports/sale_detail_report_provider.dart';
import '../../../utils/report/sale_detail_report_utils.dart';
import 'sale_detail_report_content_footer_widget.dart';
import 'sale_detail_report_content_table_widget.dart';

class SaleDetailReportContentWidget extends StatelessWidget {
  const SaleDetailReportContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<SaleDetailReportProvider,
        ({SaleDetailReportModel saleDetailReportResult, String groupBy})>(
      selector: (context, state) => (
        saleDetailReportResult: state.saleDetailReportResult,
        groupBy: state.groupBy
      ),
      builder: (context, data, child) {
        List<SaleDetailReportDTRowType> fields =
            SaleDetailReportDTRowType.values;
        if (data.groupBy == "item") {
          fields = fields
              .where((f) => f != SaleDetailReportDTRowType.itemName)
              .toList();
        }
        return Column(
          children: [
            SaleDetailReportContentTableWidget(
              fields: fields,
              saleDetailDataReport: data.saleDetailReportResult.data,
              groupBy: data.groupBy,
            ),
            SaleDetailReportContentFooterWidget(
                saleDetailReport: data.saleDetailReportResult)
          ],
        );
      },
    );
  }
}
