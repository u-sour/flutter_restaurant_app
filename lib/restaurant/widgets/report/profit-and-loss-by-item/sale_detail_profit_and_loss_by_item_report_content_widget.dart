import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/reports/profit-and-loss-by-item/sale_detail_profit_and_loss_by_item_report_model.dart';
import '../../../providers/reports/sale_detail_profit_and_loss_by_item_report_provider.dart';
import '../../../utils/report/sale_detail_profit_and_loss_by_item_report_utils.dart';
import 'sale_detail_profit_and_loss_by_item_report_content_footer_widget.dart';
import 'sale_detail_profit_and_loss_by_item_report_content_table_widget.dart';

class SaleDetailProfitAndLossByItemReportContentWidget extends StatelessWidget {
  const SaleDetailProfitAndLossByItemReportContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<SaleDetailProfitAndLossByItemReportProvider,
        SaleDetailProfitAndLossByItemReportModel>(
      selector: (context, state) => state.sdProfitAndLossByItemReportResult,
      builder: (context, sdProfitAndLossByItemReportResult, child) {
        List<SaleDetailProfitAndLossByItemReportDTRowType> fields =
            SaleDetailProfitAndLossByItemReportDTRowType.values;

        return Column(
          children: [
            SaleDetailProfitAndLossByItemReportContentTableWidget(
              fields: fields,
              sdProfitAndLossByItemDataReport:
                  sdProfitAndLossByItemReportResult.data,
            ),
            SaleDetailProfitAndLossByItemReportContentFooterWidget(
                saleDetailProfitAndLossByItemReport:
                    sdProfitAndLossByItemReportResult)
          ],
        );
      },
    );
  }
}
