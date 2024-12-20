import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart';
import 'package:provider/provider.dart';
import '../../../providers/printer_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/convert_date_time.dart';
import '../../models/exchange/exchange_model.dart';
import '../../models/invoice-template/description/description_left_right_schema_model.dart';
import '../../models/invoice-template/label_style_model.dart';
import '../../models/invoice-template/value_style_model.dart';
import '../../models/sale/invoice/print/sale_invoice_for_print_model.dart';
import '../../providers/sale/sale_provider.dart';

class InvoiceTemplateDescriptionWidget extends StatelessWidget {
  final bool showSubLabel;
  final DescriptionLeftRightSchemaModel description;
  final LabelStyleModel labelStyle;
  final LabelStyleModel subLabelStyle;
  final ValueStyleModel valueStyle;
  final SaleInvoiceForPrintModel sale;
  final String paymentBy;
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
    required this.paymentBy,
    required this.exchange,
    required this.receiptPrint,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final PrinterProvider readPrinterProvider = context.read<PrinterProvider>();
    final PaperSize paperSize = readPrinterProvider.controller.paperSize;
    const Color baseColor = Colors.black;
    SaleProvider readSaleProvider = context.read<SaleProvider>();
    // covert data to json and set new fields customerName, timeIn, timeOut & exchangeRate
    Map<String, dynamic> saleDoc = sale.toJson();
    saleDoc['customerName'] = saleDoc['guestName'];
    saleDoc['timeIn'] =
        ConvertDateTime.formatTimeStampToString(saleDoc['date'], true);
    saleDoc['timeOut'] =
        ConvertDateTime.formatTimeStampToString(DateTime.now(), true);
    saleDoc['paymentBy'] = paymentBy;
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
                  paymentBy.isNotEmpty
          ? [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Label
                Text(
                  description.label,
                  style: theme.textTheme.bodySmall!.copyWith(
                      color: baseColor,
                      fontSize: paperSize == PaperSize.mm80 &&
                              labelStyle.fontSize != null
                          ? labelStyle.fontSize! +
                              AppStyleDefaultProperties.iefs
                          : labelStyle.fontSize,
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
                        fontSize: paperSize == PaperSize.mm80 &&
                                subLabelStyle.fontSize != null
                            ? subLabelStyle.fontSize! +
                                AppStyleDefaultProperties.iefs
                            : subLabelStyle.fontSize,
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
                  '${saleDoc[description.field]}',
                  softWrap: true,
                  style: theme.textTheme.bodySmall!.copyWith(
                      color: baseColor,
                      fontSize: paperSize == PaperSize.mm80 &&
                              valueStyle.fontSize != null
                          ? valueStyle.fontSize! +
                              AppStyleDefaultProperties.iefs
                          : valueStyle.fontSize,
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
