import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer_library.dart';
import '../../../utils/convert_date_time.dart';

class InvoiceToKitchenHeaderWidget extends StatelessWidget {
  final PaperSize paperSize;
  final String tableLocation;
  final String orderNum;
  const InvoiceToKitchenHeaderWidget(
      {super.key,
      required this.paperSize,
      required this.tableLocation,
      required this.orderNum});
  final prefixInvoiceHeader = 'screens.sale.invoice.info';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color baseColor = Colors.black;
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
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
