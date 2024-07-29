import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants.dart';
import '../../../models/sale/product-group/sale_product_group_model.dart';
import '../../../providers/sale/products/sale_products_provider.dart';

class SaleProductGroupItemWidget extends StatelessWidget {
  final SaleProductGroupModel productGroup;
  final void Function()? onPressed;
  const SaleProductGroupItemWidget(
      {super.key, required this.productGroup, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Selector<SaleProductsProvider, String>(
        selector: (context, state) => state.productGroupId,
        builder: (context, productGroupId, child) {
          bool isProductGroupSelected =
              productGroupId == productGroup.id ? true : false;
          return OutlinedButton.icon(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: theme.colorScheme.primary),
                  backgroundColor:
                      isProductGroupSelected ? theme.colorScheme.primary : null,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppStyleDefaultProperties.r)))),
              label: Row(
                children: [
                  Text(
                    productGroup.name,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: isProductGroupSelected
                          ? theme.colorScheme.onPrimary
                          : null,
                      fontWeight:
                          isProductGroupSelected ? FontWeight.bold : null,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ));
        });
  }
}
