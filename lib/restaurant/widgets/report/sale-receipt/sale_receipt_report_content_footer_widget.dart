import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../utils/constants.dart';
import '../../../models/reports/sale-receipt/sale_receipt_total_doc_report_model.dart';
import '../../../utils/report/sale_receipt_report_utils.dart';
import '../../invoice/invoice_format_currency_widget.dart';

class SaleReceiptReportContentFooterWidget extends StatelessWidget {
  final SaleReceiptTotalDocReportModel saleReceiptTotalDoc;
  const SaleReceiptReportContentFooterWidget(
      {super.key, required this.saleReceiptTotalDoc});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<SelectOptionModel> footers = [
      SelectOptionModel(
        label: SaleReceiptReportDTFooterType.openAmount.toTitle,
        value: saleReceiptTotalDoc.openAmountDoc,
      ),
      SelectOptionModel(
          label: SaleReceiptReportDTFooterType.receivedAmount.toTitle,
          value: saleReceiptTotalDoc.receiveAmountDoc),
      SelectOptionModel(
        label: SaleReceiptReportDTFooterType.fee.toTitle,
        value: saleReceiptTotalDoc.feeAmountDoc,
      ),
      SelectOptionModel(
        label: SaleReceiptReportDTFooterType.balance.toTitle,
        value: saleReceiptTotalDoc.remainingAmountDoc,
      ),
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
                                value: footers[i].value.khr)),
                        const TextSpan(text: ' = '),
                        WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: InvoiceFormatCurrencyWidget(
                                baseCurrency: 'USD',
                                value: footers[i].value.usd)),
                        const TextSpan(text: ' = '),
                        WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: InvoiceFormatCurrencyWidget(
                                baseCurrency: "THB",
                                value: footers[i].value.thb))
                      ]),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
