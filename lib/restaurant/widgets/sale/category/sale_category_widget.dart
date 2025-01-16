import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../providers/app_provider.dart';
import '../../../../utils/constants.dart';
import '../../../models/sale/category/sale_category_model.dart';
import '../../../providers/sale/categories/sale_categories_provider.dart';
import '../../../providers/sale/products/sale_products_provider.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../utils/constants.dart';
import 'sale_category_item_widget.dart';

class SaleCategoryWidget extends StatefulWidget {
  const SaleCategoryWidget({super.key});

  @override
  State<SaleCategoryWidget> createState() => _SaleCategoryWidgetState();
}

class _SaleCategoryWidgetState extends State<SaleCategoryWidget> {
  late AppProvider _readAppProvider;
  late SaleProvider _readSaleProvider;
  late SaleCategoriesProvider _readSaleCategoriesProvider;
  late SaleProductsProvider _readSaleProductsProvider;
  late ItemScrollController _breadcrumbScrollController;

  @override
  void initState() {
    super.initState();
    _readAppProvider = context.read<AppProvider>();
    _readSaleProvider = context.read<SaleProvider>();
    _readSaleCategoriesProvider = context.read<SaleCategoriesProvider>();
    _readSaleProductsProvider = context.read<SaleProductsProvider>();
    _breadcrumbScrollController = ItemScrollController();
  }

  void handleCategorySelected(SaleCategoryModel category) {
    // clear search text field & state
    _readSaleProductsProvider.clearSearchTextFieldAndState();

    // selected category
    String branchId = _readAppProvider.selectedBranch!.id;
    String depId = _readAppProvider.selectedDepartment!.id;
    _readSaleCategoriesProvider.setSelectedCategory(
        category: category, branchId: branchId, depId: depId);

    // filter products by group
    _readSaleProductsProvider.productGroupFilter(categoryId: category.id);

    // filter products by selected category
    final String? invoiceId = _readSaleProvider.currentSale?.id;
    _readSaleProductsProvider.filter(
        categoryId: _readSaleCategoriesProvider.selectedCategoryId.isEmpty ||
                _readSaleCategoriesProvider.selectedCategoryId != category.id
            ? category.id
            : '',
        invoiceId: invoiceId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Selector<
              SaleCategoriesProvider,
              ({
                List<SaleCategoryModel> categories,
                List<SaleCategoryModel> selectedBreadcrumbCategories,
                String selectedCategoryId
              })>(
          selector: (context, state) => (
                categories: state.categories,
                selectedBreadcrumbCategories:
                    state.selectedBreadcrumbCategories,
                selectedCategoryId: state.selectedCategoryId
              ),
          builder: (context, data, child) {
            final List<SaleCategoryModel> categories = data.categories;
            final List<SaleCategoryModel> selectedBreadcrumbCategories =
                data.selectedBreadcrumbCategories;
            return Column(
              children: [
                // Extra foods
                if (_readSaleProductsProvider.isExtraFoodExist) ...[
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
                              // clear selected category
                              _readSaleCategoriesProvider
                                  .clearSelectedCategoryId();
                              // clear product group
                              _readSaleProductsProvider.productGroupFilter(
                                  isExtraFood: true);
                              // filter products by selected extra food
                              final String? invoiceId =
                                  _readSaleProvider.currentSale?.id;
                              _readSaleProductsProvider.filter(
                                  showExtraFood: !showExtraFood,
                                  invoiceId: invoiceId);
                            },
                            style: OutlinedButton.styleFrom(
                              side:
                                  BorderSide(color: theme.colorScheme.primary),
                              backgroundColor: showExtraFood
                                  ? theme.colorScheme.primary
                                  : null,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(AppStyleDefaultProperties.r),
                                ),
                              ),
                            ),
                            label: Row(
                              children: [
                                Icon(
                                  RestaurantDefaultIcons.extraFoods,
                                  color: showExtraFood
                                      ? theme.colorScheme.onPrimary
                                      : theme.iconTheme.color,
                                ),
                                const SizedBox(
                                    width: AppStyleDefaultProperties.w / 2),
                                Text(
                                  'screens.sale.category.extraFoods',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: showExtraFood
                                        ? theme.colorScheme.onPrimary
                                        : null,
                                    fontWeight:
                                        showExtraFood ? FontWeight.bold : null,
                                  ),
                                ).tr(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: AppStyleDefaultProperties.h),
                ],
                // Breadcrumb Categories
                if (selectedBreadcrumbCategories.length > 1) ...[
                  SizedBox(
                    height: 48.0,
                    child: ScrollablePositionedList.builder(
                        scrollDirection: Axis.horizontal,
                        itemScrollController: _breadcrumbScrollController,
                        shrinkWrap: true,
                        itemCount: selectedBreadcrumbCategories.length,
                        itemBuilder: (BuildContext context, int index) {
                          final SaleCategoryModel category =
                              selectedBreadcrumbCategories[index];
                          bool isBreadcrumbCategorySelected =
                              selectedBreadcrumbCategories.last.id ==
                                      category.id
                                  ? true
                                  : false;
                          return Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  // clear selected category
                                  _readSaleCategoriesProvider
                                      .clearSelectedBreadcrumbCategories(
                                          index: index);
                                  handleCategorySelected(category);
                                  // auto scroll to index
                                  _breadcrumbScrollController.scrollTo(
                                      index: index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                },
                                style: TextButton.styleFrom(
                                    textStyle: theme.textTheme.bodyMedium!
                                        .copyWith(
                                            fontWeight:
                                                isBreadcrumbCategorySelected
                                                    ? FontWeight.bold
                                                    : null)),
                                child: Text(category.name),
                              ),
                              if (selectedBreadcrumbCategories.length !=
                                  index + 1)
                                const Icon(RestaurantDefaultIcons.next)
                            ],
                          );
                        }),
                  ),
                  const Divider(height: AppStyleDefaultProperties.h),
                ],
                // Categories
                Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final SaleCategoryModel category = categories[index];
                      bool isCategorySelected =
                          data.selectedCategoryId == category.id ? true : false;
                      return SaleCategoryItemWidget(
                        ipAddress: _readSaleProvider.ipAddress,
                        isCategorySelected: isCategorySelected,
                        category: category,
                        onPressed: () {
                          handleCategorySelected(category);
                          // auto scroll to last index
                          if (_breadcrumbScrollController.isAttached &&
                              selectedBreadcrumbCategories.length > 1) {
                            _breadcrumbScrollController.scrollTo(
                                index: selectedBreadcrumbCategories.length,
                                alignment: -selectedBreadcrumbCategories.length
                                    .toDouble(),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
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
