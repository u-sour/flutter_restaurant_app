import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class SaleDetailHeaderActionsWidget extends StatelessWidget {
  const SaleDetailHeaderActionsWidget({super.key});
  final prefixHeaderAction = "screens.sale.detail.headerActions";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(RestaurantDefaultIcons.extraFoods),
          label: const Text('screens.sale.category.extraFoods.extraFoods').tr(),
          style: FilledButton.styleFrom(padding: const EdgeInsets.all(8.0)),
        ),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(RestaurantDefaultIcons.operations),
          label:
              const Text('screens.sale.detail.footerActions.operations').tr(),
          style: FilledButton.styleFrom(padding: const EdgeInsets.all(8.0)),
        )
      ],
    );
  }
}
