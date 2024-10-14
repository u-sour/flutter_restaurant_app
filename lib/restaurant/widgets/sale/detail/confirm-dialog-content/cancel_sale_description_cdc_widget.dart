import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/sale/sale/sale_model.dart';
import '../../../../providers/sale/sale_provider.dart';

class CancelSaleDescriptionCdcWidget extends StatelessWidget {
  final bool copy;
  final String _prefixSaleDetailDialog = 'screens.sale.detail.dialog.confirm';
  const CancelSaleDescriptionCdcWidget({super.key, required this.copy});
  @override
  Widget build(BuildContext context) {
    SaleProvider readSaleProvider = context.read<SaleProvider>();
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          '$_prefixSaleDetailDialog.cancelSale.start'.tr(),
          style: theme.textTheme.bodyMedium,
        ),
        Selector<SaleProvider, SaleModel?>(
          selector: (context, state) => state.currentSale,
          builder: (context, currentSale, child) => Text(
              currentSale != null
                  ? readSaleProvider.getInvoiceText(
                      sale: currentSale, context: context)
                  : '',
              style: theme.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold)),
        ),
        Text(
          copy
              ? '$_prefixSaleDetailDialog.cancelSale.endNewCopy'
              : '$_prefixSaleDetailDialog.cancelSale.end',
          style: theme.textTheme.bodyMedium,
        ).tr(),
      ],
    );
  }
}
