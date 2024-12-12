import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InvoiceToKitchenHeaderWidget extends StatelessWidget {
  final String tableLocation;
  final String orderNum;
  const InvoiceToKitchenHeaderWidget(
      {super.key, required this.tableLocation, required this.orderNum});
  final prefixInvoiceHeader = 'screens.sale.invoice.info';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color baseColor = Colors.black;
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     RichText(
        //       text: TextSpan(
        //           text: '$prefixInvoiceHeader.date'.tr(),
        //           style: theme.textTheme.bodyMedium!
        //               .copyWith(color: baseColor, fontWeight: FontWeight.bold),
        //           children: [
        //             TextSpan(
        //                 text: ConvertDateTime.formatTimeStampToString(
        //                     DateTime.now(), true))
        //           ]),
        //     ),
        //     RichText(
        //       text: TextSpan(
        //           text: '$prefixInvoiceHeader.tableLocation'.tr(),
        //           style: theme.textTheme.bodyMedium!
        //               .copyWith(color: baseColor, fontWeight: FontWeight.bold),
        //           children: [
        //             TextSpan(text: tableLocation),
        //           ]),
        //     )
        //   ],
        // ),
        if (orderNum.isNotEmpty)
          RichText(
            text: TextSpan(
                text: '$prefixInvoiceHeader.orderNumber'.tr(),
                style: theme.textTheme.bodyMedium!.copyWith(color: baseColor),
                children: [
                  TextSpan(
                      text: orderNum,
                      style: theme.textTheme.bodyMedium!.copyWith(
                          color: baseColor, fontWeight: FontWeight.bold))
                ]),
          ),
      ],
    );
  }
}
