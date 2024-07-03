import 'package:flutter/material.dart';
import 'package:flutter_template/utils/constants.dart';
import '../../../models/sale/category/sale_category_model.dart';

class SaleCategoryItemWidget extends StatelessWidget {
  final SaleCategoryModel category;
  final void Function()? onPressed;
  const SaleCategoryItemWidget(
      {super.key, required this.category, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppThemeColors.primary),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        label: Row(
          children: [
            Text(
              category.parent.label,
              style: TextStyle(color: theme.textTheme.bodySmall?.color),
            )
          ],
        ));
  }
}
