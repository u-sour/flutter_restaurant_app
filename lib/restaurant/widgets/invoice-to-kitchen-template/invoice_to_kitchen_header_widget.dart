import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../utils/convert_date_time.dart';

class InvoiceToKitchenHeaderWidget extends StatelessWidget {
  final String tableLocation;
  const InvoiceToKitchenHeaderWidget({super.key, required this.tableLocation});
  final prefixInvoiceHeader = 'screens.sale.invoice.info';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color baseColor = Colors.black;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: '$prefixInvoiceHeader.date'.tr(),
              style: theme.textTheme.bodySmall!
                  .copyWith(color: baseColor, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: ConvertDateTime.formatTimeStampToString(
                        DateTime.now(), true))
              ]),
        ),
        RichText(
          text: TextSpan(
              text: '$prefixInvoiceHeader.tableLocation'.tr(),
              style: theme.textTheme.bodySmall!
                  .copyWith(color: baseColor, fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: tableLocation),
              ]),
        )
      ],
    );
  }
}
