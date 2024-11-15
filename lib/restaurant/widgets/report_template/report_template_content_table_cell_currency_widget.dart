import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../invoice/invoice_format_currency_widget.dart';

class ReportTemplateContentTableCellCurrencyWidget extends StatelessWidget {
  final num value;
  final BoxBorder? border;
  final FontWeight? fontWeight;
  const ReportTemplateContentTableCellCurrencyWidget(
      {super.key, required this.value, this.border, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppStyleDefaultProperties.p / 2),
      decoration: BoxDecoration(border: border),
      child: InvoiceFormatCurrencyWidget(
        value: value,
        mainAxisAlignment: MainAxisAlignment.end,
        fontWeight: fontWeight,
        currencySymbolFontSize: 17.0,
      ),
    );
  }
}
