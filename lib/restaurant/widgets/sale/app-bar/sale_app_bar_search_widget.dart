import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants.dart';
import '../../../providers/sale/categories/sale_categories_provider.dart';
import '../../../providers/sale/products/sale_products_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/debounce.dart';
import '../../badge_widget.dart';
import '../../search_widget.dart';

class SaleAppBarSearchWidget extends StatelessWidget {
  const SaleAppBarSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Debounce debounce = Debounce();
    SaleProductsProvider readSaleProductsProvider =
        context.read<SaleProductsProvider>();
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppStyleDefaultProperties.p),
      child: Row(
        children: [
          Expanded(
              child: SearchWidget(
            controller: readSaleProductsProvider.searchController,
            onChanged: (String? search) {
              if (search != null) {
                debounce.run(() {
                  String categoryId = context
                      .read<SaleCategoriesProvider>()
                      .selectedCategories
                      .last
                      .id;
                  String productGroupId =
                      readSaleProductsProvider.productGroupId;
                  bool showExtraFood = readSaleProductsProvider.showExtraFood;

                  readSaleProductsProvider.filter(
                      search: search,
                      categoryId: categoryId,
                      productGroupId: productGroupId,
                      showExtraFood: showExtraFood);
                });
              }
            },
          )),
          const SizedBox(width: AppStyleDefaultProperties.w),
          BadgeWidget(
            count: 8,
            child: SizedBox(
              width: 48.0,
              height: 48.0,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: const Icon(RestaurantDefaultIcons.notification),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
