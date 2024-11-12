import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../utils/constants.dart';
import '../../../models/reports/sale/sale_report_model.dart';
import '../../../utils/report/sale_report_utils.dart';
import '../../invoice/invoice_format_currency_widget.dart';

class SaleReportContentFooterWidget extends StatelessWidget {
  final SaleReportModel saleReport;
  const SaleReportContentFooterWidget({super.key, required this.saleReport});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<SelectOptionModel> footers = [
      SelectOptionModel(
          label: SaleReportDTFooterType.subTotal.toTitle,
          value: saleReport.grandSubTotal),
      SelectOptionModel(
          label: SaleReportDTFooterType.discount.toTitle,
          value: saleReport.grandDiscount),
      SelectOptionModel(
          label: SaleReportDTFooterType.totalKhr.toTitle,
          value: saleReport.grandTotalDoc.khr,
          extra: 'KHR'),
      SelectOptionModel(
          label: SaleReportDTFooterType.totalUsd.toTitle,
          value: saleReport.grandTotalDoc.usd,
          extra: 'USD'),
      SelectOptionModel(
          label: SaleReportDTFooterType.totalThb.toTitle,
          value: saleReport.grandTotalDoc.thb,
          extra: 'THB'),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: AppStyleDefaultProperties.p),
      child: Column(
        children: [
          for (int i = 0; i < footers.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                      text: footers[i].label.tr(),
                      style: theme.textTheme.bodyMedium,
                      children: [
                        WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: InvoiceFormatCurrencyWidget(
                                value: footers[i].value,
                                baseCurrency: footers[i].extra))
                      ]),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
