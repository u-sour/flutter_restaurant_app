import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';
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
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(AppStyleDefaultProperties.r)))),
        label: Row(
          children: [
            Text(
              category.parent.label,
              style: theme.textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ));
  }
}
