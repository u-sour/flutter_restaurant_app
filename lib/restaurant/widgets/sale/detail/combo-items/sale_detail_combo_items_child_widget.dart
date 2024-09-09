import 'package:flutter/material.dart';
import '../../../../../utils/constants.dart';
import '../../../../models/sale/detail/sale_detail_combo_item_model.dart';

class SaleDetailComboItemsChildWidget extends StatelessWidget {
  final SaleDetailComboItemModel comboItem;
  const SaleDetailComboItemsChildWidget({super.key, required this.comboItem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: RichText(
          text: TextSpan(
              text: '${comboItem.itemName} x ',
              style: theme.textTheme.bodyLarge,
              children: [
            TextSpan(
                text: '${comboItem.qty}',
                style: const TextStyle(
                    color: AppThemeColors.failure, fontWeight: FontWeight.bold))
          ])),
    );
  }
}
