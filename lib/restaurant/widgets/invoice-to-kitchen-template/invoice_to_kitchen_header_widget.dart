import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart';
import 'package:provider/provider.dart';
import '../../../providers/printer_provider.dart';
import '../../../utils/convert_date_time.dart';

class InvoiceToKitchenHeaderWidget extends StatelessWidget {
  final String tableLocation;
  final String orderNum;
  const InvoiceToKitchenHeaderWidget(
      {super.key, required this.tableLocation, required this.orderNum});
  final prefixInvoiceHeader = 'screens.sale.invoice.info';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final PrinterProvider readPrinterProvider = context.read<PrinterProvider>();
    final PaperSize paperSize = readPrinterProvider.controller.paperSize;
    const Color baseColor = Colors.black;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                  // text: '$prefixInvoiceHeader.date'.tr(),
                  style: paperSize == PaperSize.mm80
                      ? theme.textTheme.headlineMedium!.copyWith(
                          color: baseColor, fontWeight: FontWeight.bold)
                      : theme.textTheme.bodyLarge!.copyWith(
                          color: baseColor, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: ConvertDateTime.formatTimeStampToString(
                            DateTime.now(), false,
                            formatStyle: 'dd/MM/yyyy hh:mm a'))
                  ]),
            ),
            RichText(
              text: TextSpan(
                  // text: '$prefixInvoiceHeader.tableLocation'.tr(),
                  style: paperSize == PaperSize.mm80
                      ? theme.textTheme.headlineMedium!.copyWith(
                          color: baseColor, fontWeight: FontWeight.bold)
                      : theme.textTheme.bodyLarge!.copyWith(
                          color: baseColor, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: tableLocation),
                  ]),
            )
          ],
        ),
        if (orderNum.isNotEmpty)
          RichText(
            text: TextSpan(
                text: '$prefixInvoiceHeader.orderNumber'.tr(),
                style: paperSize == PaperSize.mm80
                    ? theme.textTheme.headlineMedium!.copyWith(color: baseColor)
                    : theme.textTheme.bodyLarge!.copyWith(color: baseColor),
                children: [
                  TextSpan(
                      text: orderNum,
                      style: paperSize == PaperSize.mm80
                          ? theme.textTheme.headlineMedium!
                              .copyWith(color: baseColor)
                          : theme.textTheme.bodyLarge!.copyWith(
                              color: baseColor, fontWeight: FontWeight.bold))
                ]),
          ),
      ],
    );
  }
}
