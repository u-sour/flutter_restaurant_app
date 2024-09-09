import 'package:flutter/material.dart';
import '../../../../../utils/constants.dart';
import '../../../../models/sale/detail/sale_detail_extra_item_model.dart';
import '../../../format_currency_widget.dart';

class SaleDetailExtraItemsChildWidget extends StatelessWidget {
  final SaleDetailExtraItemModel extraItem;
  const SaleDetailExtraItemsChildWidget({super.key, required this.extraItem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: RichText(
          text: TextSpan(
              text: '${extraItem.itemName} | ',
              style: theme.textTheme.bodyLarge,
              children: [
            WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: FormatCurrencyWidget(
                    value: extraItem.amount, color: AppThemeColors.primary))
          ])),
    );
  }
}
