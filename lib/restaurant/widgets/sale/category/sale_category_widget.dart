import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../providers/app_provider.dart';
import '../../../../utils/constants.dart';
import '../../../models/sale/category/sale_category_model.dart';
import '../../../providers/sale/categories/sale_categories_provider.dart';
import '../../../providers/sale/products/sale_products_provider.dart';
import '../../../utils/constants.dart';
import 'sale_category_item_widget.dart';

class SaleCategoryWidget extends StatefulWidget {
  const SaleCategoryWidget({super.key});

  @override
  State<SaleCategoryWidget> createState() => _SaleCategoryWidgetState();
}

class _SaleCategoryWidgetState extends State<SaleCategoryWidget> {
  late AppProvider _readAppProvider;
  late SaleCategoriesProvider _readSaleCategoriesProvider;
  late SaleProductsProvider _readSaleProductsProvider;
  late ItemScrollController _breadcrumbScrollController;

  @override
  void initState() {
    super.initState();
    _readAppProvider = context.read<AppProvider>();
    _readSaleCategoriesProvider = context.read<SaleCategoriesProvider>();
    _readSaleProductsProvider = context.read<SaleProductsProvider>();
    _breadcrumbScrollController = ItemScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Selector<
              SaleCategoriesProvider,
              ({
                List<SaleCategoryModel> categories,
                List<SaleCategoryModel> selectedCategories,
              })>(
          selector: (context, state) => (
                categories: state.categories,
                selectedCategories: state.selectedCategories
              ),
          builder: (context, data, child) {
            final List<SaleCategoryModel> categories = data.categories;
            final List<SaleCategoryModel> selectedCategories =
                data.selectedCategories;
            return Column(
              children: [
                // Extra foods
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Selector<SaleProductsProvider, bool>(
                            selector: (context, state) => state.showExtraFood,
                            builder: (context, showExtraFood, child) =>
                                OutlinedButton.icon(
                              onPressed: () {
                                // clear search text field & state
                                _readSaleProductsProvider
                                    .clearSearchTextFieldAndState();

                                // clear product group
                                _readSaleProductsProvider.productGroupFilter(
                                    isExtraFood: true);

                                // filter products by selected extra food
                                _readSaleProductsProvider.filter(
                                    showExtraFood: !showExtraFood);
                              },
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: theme.colorScheme.primary),
                                  backgroundColor: showExtraFood
                                      ? theme.colorScheme.primary
                                      : null,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              AppStyleDefaultProperties.r)))),
                              icon: Icon(
                                RestaurantDefaultIcons.extraFoods,
                                color: showExtraFood
                                    ? theme.colorScheme.onPrimary
                                    : theme.iconTheme.color,
                              ),
                              label: Text(
                                'screens.sale.category.extraFoods',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: showExtraFood
                                      ? theme.colorScheme.onPrimary
                                      : null,
                                  fontWeight:
                                      showExtraFood ? FontWeight.bold : null,
                                ),
                              ).tr(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: AppStyleDefaultProperties.h),
                  ],
                ),
                // Breadcrumb Categories
                if (selectedCategories.length > 1)
                  SizedBox(
                    height: 48.0,
                    child: ScrollablePositionedList.builder(
                        scrollDirection: Axis.horizontal,
                        itemScrollController: _breadcrumbScrollController,
                        shrinkWrap: true,
                        itemCount: selectedCategories.length,
                        itemBuilder: (BuildContext context, int index) {
                          final SaleCategoryModel category =
                              selectedCategories[index];
                          bool isCategorySelected =
                              selectedCategories.last.id == category.id
                                  ? true
                                  : false;
                          return Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  // clear selected category
                                  _readSaleCategoriesProvider
                                      .clearSelectedCategory(index: index);

                                  // clear search text field & state
                                  _readSaleProductsProvider
                                      .clearSearchTextFieldAndState();

                                  String branchId =
                                      _readAppProvider.selectedBranch!.id;
                                  String depId =
                                      _readAppProvider.selectedDepartment!.id;
                                  _readSaleCategoriesProvider
                                      .setSelectedCategory(
                                          category: category,
                                          branchId: branchId,
                                          depId: depId);

                                  // filter product group and products by selected category
                                  _readSaleProductsProvider.productGroupFilter(
                                      categoryId: category.id);

                                  _readSaleProductsProvider.filter(
                                      categoryId: category.id);

                                  // auto scroll to index
                                  _breadcrumbScrollController.scrollTo(
                                      index: index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeOutCubic);
                                },
                                style: TextButton.styleFrom(
                                    textStyle: theme.textTheme.bodyMedium!
                                        .copyWith(
                                            fontWeight: isCategorySelected
                                                ? FontWeight.bold
                                                : null)),
                                child: Text(category.name),
                              ),
                              if (selectedCategories.length != index + 1)
                                const Icon(RestaurantDefaultIcons.next)
                            ],
                          );
                        }),
                  ),
                if (selectedCategories.length > 1)
                  const Divider(height: AppStyleDefaultProperties.h),
                // Categories
                Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final SaleCategoryModel category = categories[index];
                      return SaleCategoryItemWidget(
                        category: category,
                        onPressed: () {
                          // clear search text field & state
                          _readSaleProductsProvider
                              .clearSearchTextFieldAndState();
                          String branchId = _readAppProvider.selectedBranch!.id;
                          String depId =
                              _readAppProvider.selectedDepartment!.id;

                          // selected category
                          _readSaleCategoriesProvider.setSelectedCategory(
                              category: category,
                              branchId: branchId,
                              depId: depId);

                          // filter product group and products by selected category
                          _readSaleProductsProvider.productGroupFilter(
                              categoryId: category.id);

                          _readSaleProductsProvider.filter(
                              categoryId: category.id);

                          // auto scroll to last index
                          if (_breadcrumbScrollController.isAttached &&
                              selectedCategories.length > 1) {
                            _breadcrumbScrollController.scrollTo(
                                index: selectedCategories.length,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInCubic);
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            );
          }),
    );
  }
}
