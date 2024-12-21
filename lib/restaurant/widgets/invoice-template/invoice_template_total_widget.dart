import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart';
import '../../../utils/constants.dart';
import '../../models/invoice-template/total/total_list_schema_model.dart';
import '../../models/invoice-template/total/total_schema_model.dart';
import '../../models/sale/invoice/print/sale_invoice_content_model.dart';
import '../invoice/invoice_format_currency_widget.dart';

class InvoiceTemplateTotalWidget extends StatelessWidget {
  final PaperSize paperSize;
  final TotalSchemaModel totalSchema;
  final SaleInvoiceContentModel saleInvoiceContent;
  final bool isPaid;
  final bool isRepaid;
  const InvoiceTemplateTotalWidget({
    super.key,
    required this.paperSize,
    required this.totalSchema,
    required this.saleInvoiceContent,
    required this.isPaid,
    required this.isRepaid,
  });

  bool showFields({required String field}) {
    // is show fee amount
    if (field == "feeAmount") {
      return saleInvoiceContent.feeAmount > 0;
      // is show owed amount
    } else if (field == 'owedAmount') {
      return saleInvoiceContent.returnAmountType == 'owned';
      // is show return amount
    } else if (field == 'returnAmount') {
      return saleInvoiceContent.returnAmountType == 'return';
    }
    // show other fields
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color baseColor = Colors.black;
    List<TotalListSchemaModel> totals = totalSchema.list;
    return Column(
      children: [
        for (int i = 0; i < totals.length; i++)
          if (totals[i].isVisible &&
              (totals[i].invoiceType == null ||
                  // check print receipt
                  totals[i].invoiceType != null &&
                      totals[i].invoiceType!.where((e) {
                        // check is the first payment or is repayment
                        if (e == 'Payment') {
                          return isPaid;
                        } else if (e == 'Repayment') {
                          return isRepaid;
                        }
                        return false;
                      }).isNotEmpty) &&
              showFields(field: totals[i].field))
            Padding(
              padding: EdgeInsets.only(
                  left: totalSchema.labelStyle.paddingRight ?? 0.0,
                  bottom: totalSchema.labelStyle.paddingBottom ?? 0.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${totals[i].label}:',
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: baseColor,
                        fontSize: paperSize == PaperSize.mm80 &&
                                totals[i].labelStyle.fontSize != null
                            ? totals[i].labelStyle.fontSize! +
                                AppStyleDefaultProperties.iefs
                            : totals[i].labelStyle.fontSize,
                        fontWeight: totals[i].labelStyle.fontWeight != null &&
                                totals[i].labelStyle.fontWeight == 'bold'
                            ? FontWeight.bold
                            : null,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child:
                          // (total, receive, owned, return) amount
                          totals[i].field == 'totalAmount' ||
                                  totals[i].field == 'receiveAmount' ||
                                  totals[i].field == 'owedAmount' ||
                                  totals[i].field == 'returnAmount'
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // loop  & format currency by displayCurrencies
                                    for (int j = 0;
                                        j <
                                            totalSchema
                                                .displayCurrencies.length;
                                        j++) ...[
                                      InvoiceFormatCurrencyWidget(
                                        value: totals[i].field == 'totalAmount'
                                            ? saleInvoiceContent
                                                    .totalAmountExchange
                                                    .toJson()[
                                                totalSchema
                                                    .displayCurrencies[j]]
                                            : totals[i].field == 'receiveAmount'
                                                ? saleInvoiceContent
                                                        .receiveAmountExchange
                                                        ?.toJson()[totalSchema
                                                            .displayCurrencies[
                                                        j]] ??
                                                    0
                                                : saleInvoiceContent
                                                        .returnAmountExchange
                                                        ?.toJson()[totalSchema
                                                            .displayCurrencies[
                                                        j]] ??
                                                    0,
                                        baseCurrency:
                                            totalSchema.displayCurrencies[j],
                                        color: baseColor,
                                        priceFontSize: paperSize ==
                                                    PaperSize.mm80 &&
                                                totals[i].valueStyle.fontSize !=
                                                    null
                                            ? totals[i].valueStyle.fontSize! +
                                                AppStyleDefaultProperties.iefs
                                            : totals[i].valueStyle.fontSize,
                                        currencySymbolFontSize: paperSize ==
                                                    PaperSize.mm80 &&
                                                totals[i].valueStyle.fontSize !=
                                                    null
                                            ? totals[i].valueStyle.fontSize! +
                                                2 +
                                                AppStyleDefaultProperties.iefs
                                            : totals[i].valueStyle.fontSize! +
                                                2,
                                        fontWeight:
                                            totals[i].valueStyle.fontWeight !=
                                                        null &&
                                                    totals[i]
                                                            .valueStyle
                                                            .fontWeight ==
                                                        'bold'
                                                ? FontWeight.bold
                                                : null,
                                      ),
                                      if (j + 1 !=
                                          totalSchema.displayCurrencies.length)
                                        Text(' = ',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(
                                              color: baseColor,
                                              fontSize: paperSize ==
                                                          PaperSize.mm80 &&
                                                      totals[i]
                                                              .valueStyle
                                                              .fontSize !=
                                                          null
                                                  ? totals[i]
                                                          .valueStyle
                                                          .fontSize! +
                                                      AppStyleDefaultProperties
                                                          .iefs
                                                  : totals[i]
                                                      .valueStyle
                                                      .fontSize,
                                              fontWeight: totals[i]
                                                              .valueStyle
                                                              .fontWeight !=
                                                          null &&
                                                      totals[i]
                                                              .valueStyle
                                                              .fontWeight ==
                                                          'bold'
                                                  ? FontWeight.bold
                                                  : null,
                                            ))
                                    ],
                                  ],
                                )
                              : InvoiceFormatCurrencyWidget(
                                  value: totals[i].field == 'discount'
                                      ? saleInvoiceContent.saleDoc.discountValue
                                      : saleInvoiceContent
                                              .toJson()[totals[i].field] ??
                                          0,
                                  color: baseColor,
                                  priceFontSize: paperSize == PaperSize.mm80 &&
                                          totals[i].valueStyle.fontSize != null
                                      ? totals[i].valueStyle.fontSize! +
                                          AppStyleDefaultProperties.iefs
                                      : totals[i].valueStyle.fontSize,
                                  currencySymbolFontSize: paperSize ==
                                              PaperSize.mm80 &&
                                          totals[i].valueStyle.fontSize != null
                                      ? totals[i].valueStyle.fontSize! +
                                          2 +
                                          AppStyleDefaultProperties.iefs
                                      : totals[i].valueStyle.fontSize! + 2,
                                  fontWeight:
                                      totals[i].valueStyle.fontWeight != null &&
                                              totals[i].valueStyle.fontWeight ==
                                                  'bold'
                                          ? FontWeight.bold
                                          : null,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ))
                ],
              ),
            ),
        const SizedBox(height: AppStyleDefaultProperties.h * 3.5)
      ],
    );
  }
}
