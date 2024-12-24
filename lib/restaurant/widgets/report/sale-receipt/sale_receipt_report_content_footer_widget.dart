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
                  width: 245.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InvoiceFormatCurrencyWidget(
                        value: footers[i].value.khr,
                        currencySymbolFontSize: 14.0,
                      ),
                      Text(
                        ' = ',
                        style: style,
                      ),
                      InvoiceFormatCurrencyWidget(
                          currencySymbolFontSize: 14.0,
                          baseCurrency: 'USD',
                          value: footers[i].value.usd),
                      Text(
                        ' = ',
                        style: style,
                      ),
                      InvoiceFormatCurrencyWidget(
                          currencySymbolFontSize: 14.0,
                          baseCurrency: "THB",
                          value: footers[i].value.thb)
                    ],
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
