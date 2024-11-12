import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../utils/constants.dart';
import '../../../models/reports/sale-detail/sale_detail_report_model.dart';
import '../../../utils/report/sale_detail_report_utils.dart';
import '../../invoice/invoice_format_currency_widget.dart';

class SaleDetailReportContentFooterWidget extends StatelessWidget {
  final SaleDetailReportModel saleDetailReport;
  const SaleDetailReportContentFooterWidget(
      {super.key, required this.saleDetailReport});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<SelectOptionModel> footers = [
      SelectOptionModel(
          label: SaleDetailReportDTFooterType.qty.toTitle,
          value: saleDetailReport.qty,
          extra: 'qty'),
      SelectOptionModel(
          label: SaleDetailReportDTFooterType.discount.toTitle,
          value: saleDetailReport.discountAmount),
      SelectOptionModel(
          label: SaleDetailReportDTFooterType.totalKhr.toTitle,
          value: saleDetailReport.totalDoc.khr,
          extra: 'KHR'),
      SelectOptionModel(
          label: SaleDetailReportDTFooterType.totalUsd.toTitle,
          value: saleDetailReport.totalDoc.usd,
          extra: 'USD'),
      SelectOptionModel(
          label: SaleDetailReportDTFooterType.totalThb.toTitle,
          value: saleDetailReport.totalDoc.thb,
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
                            child: footers[i].extra == 'qty'
                                ? Text('${footers[i].value}')
                                : InvoiceFormatCurrencyWidget(
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
