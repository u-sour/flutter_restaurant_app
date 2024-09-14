import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/convert_date_time.dart';
import '../../models/exchange/exchange_model.dart';
import '../../models/invoice-template/description/description_left_right_schema_model.dart';
import '../../models/invoice-template/label_style_model.dart';
import '../../models/invoice-template/value_style_model.dart';
import '../../models/sale/invoice/sale_invoice_for_print_model.dart';
import '../../providers/sale/sale_provider.dart';

class InvoiceTemplateDescriptionWidget extends StatelessWidget {
  final bool showSubLabel;
  final DescriptionLeftRightSchemaModel description;
  final LabelStyleModel labelStyle;
  final LabelStyleModel subLabelStyle;
  final ValueStyleModel valueStyle;
  final SaleInvoiceForPrintModel sale;
  final ExchangeModel exchange;
  final bool receiptPrint;
  const InvoiceTemplateDescriptionWidget({
    super.key,
    required this.showSubLabel,
    required this.description,
    required this.labelStyle,
    required this.subLabelStyle,
    required this.valueStyle,
    required this.sale,
    required this.exchange,
    required this.receiptPrint,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color baseColor = Colors.black;
    SaleProvider readSaleProvider = context.read<SaleProvider>();
    // covert data to json and set new fields customerName, timeIn, timeOut & exchangeRate
    Map<String, dynamic> saleDoc = sale.toJson();
    saleDoc['customerName'] = saleDoc['guestName'];
    saleDoc['timeIn'] =
        ConvertDateTime.formatTimeStampToString(saleDoc['date'], true);
    if (!receiptPrint) {
      saleDoc['timeOut'] =
          ConvertDateTime.formatTimeStampToString(DateTime.now(), true);
    }
    List<String> allowedCurrencies =
        readSaleProvider.getAllowedCurrencies(context: context);
    String isShowTHB =
        allowedCurrencies.contains('THB') ? '= ${exchange.thb}฿' : '';
    saleDoc['exchangeRate'] = '${exchange.usd}\$ = ${exchange.khr}៛ $isShowTHB';
    return Row(
      children: description.visible && description.showOnReceipt == null ||
              description.visible &&
                  description.showOnReceipt != null &&
                  description.showOnReceipt == true &&
                  receiptPrint
          ? [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Label
                Text(
                  description.label,
                  style: theme.textTheme.bodySmall!.copyWith(
                      color: baseColor,
                      fontSize: labelStyle.fontSize,
                      fontWeight: labelStyle.fontWeight != null &&
                              labelStyle.fontWeight == 'bold'
                          ? FontWeight.bold
                          : null),
                ),
                // Sub Label
                if (showSubLabel)
                  Text(
                    description.subLabel,
                    style: theme.textTheme.bodySmall!.copyWith(
                        color: baseColor,
                        fontSize: subLabelStyle.fontSize,
                        fontWeight: subLabelStyle.fontWeight != null &&
                                subLabelStyle.fontWeight == 'bold'
                            ? FontWeight.bold
                            : null),
                  )
              ]),
              // Separate
              Text(':',
                  style: theme.textTheme.bodySmall!.copyWith(color: baseColor)),
              // Value
              Expanded(
                child: Text(
                  saleDoc[description.field],
                  softWrap: true,
                  style: theme.textTheme.bodySmall!.copyWith(
                      color: baseColor,
                      fontSize: valueStyle.fontSize,
                      fontWeight: valueStyle.fontWeight != null &&
                              valueStyle.fontWeight == 'bold'
                          ? FontWeight.bold
                          : null),
                ),
              )
            ]
          : [],
    );
  }
}
