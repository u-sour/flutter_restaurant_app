import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../utils/constants.dart';
import '../../../models/reports/profit-and-loss-by-item/sale_detail_profit_and_loss_by_item_report_model.dart';
import '../../../utils/report/sale_detail_profit_and_loss_by_item_report_utils.dart';
import '../../invoice/invoice_format_currency_widget.dart';

class SaleDetailProfitAndLossByItemReportContentFooterWidget
    extends StatelessWidget {
  final SaleDetailProfitAndLossByItemReportModel
      saleDetailProfitAndLossByItemReport;
  const SaleDetailProfitAndLossByItemReportContentFooterWidget(
      {super.key, required this.saleDetailProfitAndLossByItemReport});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<SelectOptionModel> footers = [
      SelectOptionModel(
          label:
              SaleDetailProfitAndLossByItemReportDTFooterType.totalQty.toTitle,
          value: saleDetailProfitAndLossByItemReport.totalQty,
          extra: 'qty'),
      SelectOptionModel(
          label:
              SaleDetailProfitAndLossByItemReportDTFooterType.totalCost.toTitle,
          value: saleDetailProfitAndLossByItemReport.totalCost),
      SelectOptionModel(
          label: SaleDetailProfitAndLossByItemReportDTFooterType
              .totalPrice.toTitle,
          value: saleDetailProfitAndLossByItemReport.totalPrice),
      SelectOptionModel(
          label: SaleDetailProfitAndLossByItemReportDTFooterType
              .totalDiscount.toTitle,
          value: saleDetailProfitAndLossByItemReport.totalDiscountAmount),
      SelectOptionModel(
          label: SaleDetailProfitAndLossByItemReportDTFooterType
              .totalProfitKHR.toTitle,
          value: saleDetailProfitAndLossByItemReport.totalProfitDoc.khr,
          extra: 'KHR'),
      SelectOptionModel(
          label: SaleDetailProfitAndLossByItemReportDTFooterType
              .totalProfitUSD.toTitle,
          value: saleDetailProfitAndLossByItemReport.totalProfitDoc.usd,
          extra: 'USD'),
      SelectOptionModel(
          label: SaleDetailProfitAndLossByItemReportDTFooterType
              .totalProfitTHB.toTitle,
          value: saleDetailProfitAndLossByItemReport.totalProfitDoc.thb,
          extra: 'THB'),
    ];

    TextStyle? style =
        theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(top: AppStyleDefaultProperties.p),
      child: Column(
        children: [
          for (int i = 0; i < footers.length; i++)
            Row(
              children: [
                Expanded(
                    child: Text(
                  footers[i].label.tr(),
                  textAlign: TextAlign.end,
                  style: style,
                )),
                const SizedBox(width: AppStyleDefaultProperties.w),
                SizedBox(
                    width: 125.0,
                    child: footers[i].extra == 'qty'
                        ? Text(
                            '${footers[i].value}',
                            textAlign: TextAlign.end,
                            style: style,
                          )
                        : InvoiceFormatCurrencyWidget(
                            value: footers[i].value,
                            baseCurrency: footers[i].extra,
                            currencySymbolFontSize: 14.0,
                            mainAxisAlignment: MainAxisAlignment.end,
                          ))
              ],
            ),
        ],
      ),
    );
  }
}
