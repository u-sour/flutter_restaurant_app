import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../models/servers/response_model.dart';
import '../../../../services/global_service.dart';
import '../../../../utils/alert/alert.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../models/sale/add-product/sale_add_product_model.dart';
import '../../../models/sale/product/sale_product_model.dart';
import '../../../providers/sale/categories/sale_categories_provider.dart';
import '../../../providers/sale/products/sale_products_provider.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/debounce.dart';
import '../../../../widgets/empty_data_widget.dart';
import '../../../../widgets/loading_widget.dart';
import '../../dialog_widget.dart';
import '../product-group/sale_product_group_widget.dart';
import '../product-variant/product_variant_widget.dart';
import 'sale_product_item_widget.dart';

class SaleProductWidget extends StatefulWidget {
  final double? slidingUpPanelMinHeight;
  const SaleProductWidget({super.key, this.slidingUpPanelMinHeight});

  @override
  State<SaleProductWidget> createState() => _SaleProductWidgetState();
}

class _SaleProductWidgetState extends State<SaleProductWidget> {
  late ScrollController _productScrollController;
  late SaleProvider _readSaleProvider;
  late SaleCategoriesProvider _readSaleCategoriesProvider;
  late SaleProductsProvider _readSaleProductsProvider;
  final Debounce _debounce = Debounce(delay: const Duration(milliseconds: 100));
  @override
  void initState() {
    super.initState();
    _productScrollController = ScrollController();
    _readSaleProvider = context.read<SaleProvider>();
    _readSaleCategoriesProvider = context.read<SaleCategoriesProvider>();
    _readSaleProductsProvider = context.read<SaleProductsProvider>();

    // listen user scrolling to the bottom then load more products
    _productScrollController.addListener(() {
      if (_productScrollController.offset >=
              _productScrollController.position.maxScrollExtent &&
          !_productScrollController.position.outOfRange) {
        _debounce.run(() async {
          String categoryId = _readSaleCategoriesProvider
                  .selectedBreadcrumbCategories.last.id.isEmpty
              ? _readSaleCategoriesProvider.selectedCategoryId
              : _readSaleCategoriesProvider
                  .selectedBreadcrumbCategories.last.id;
          await _readSaleProductsProvider.loadMore(categoryId: categoryId);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _productScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.orientationOf(context);
    // Desktop mode
    int crossAxisCount = 3;
    double imageHeight = 150.0;
    // Tablet portrait mode
    if (ResponsiveLayout.isTablet(context)) {
      imageHeight = 180.0;
    }
    //Tablet landscape mode
    if (ResponsiveLayout.isTablet(context) &&
        orientation == Orientation.landscape) {
      imageHeight = 170.0;
    }

    //Mobile portrait mode
    if (ResponsiveLayout.isMobile(context)) {
      crossAxisCount = 2;
      imageHeight = 180.0;
    }

    return Padding(
      padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
      child: Column(
        children: [
          if (ResponsiveLayout.isMobile(context)) ...[
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  style: FilledButton.styleFrom(padding: EdgeInsets.zero),
                  icon: const Icon(RestaurantDefaultIcons.categories),
                  label: Text('screens.sale.navigation.categories'.tr())),
            ),
            const SizedBox(height: AppStyleDefaultProperties.h)
          ],
          const SaleProductGroupWidget(),
          Expanded(
            child: Selector<
                    SaleProductsProvider,
                    ({
                      List<SaleProductModel> products,
                      bool isLoading,
                      bool isLoadMore
                    })>(
                selector: (context, state) => (
                      products: state.products,
                      isLoading: state.isLoading,
                      isLoadMore: state.isLoadMore
                    ),
                builder: (context, data, child) {
                  if (data.isLoading) {
                    return const LoadingWidget();
                  } else {
                    return data.products.isEmpty
                        ? const EmptyDataWidget()
                        : Column(
                            children: [
                              Expanded(
                                child: DynamicHeightGridView(
                                    itemCount: data.products.length,
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing:
                                        AppStyleDefaultProperties.w,
                                    mainAxisSpacing: 0.0,
                                    controller: _productScrollController,
                                    builder: (context, index) {
                                      final SaleProductModel product =
                                          data.products[index];
                                      return VisibilityDetector(
                                        key: Key(index.toString()),
                                        onVisibilityChanged: (info) {
                                          //listen & set current product item index when user scrolling
                                          if (info.visibleFraction == 1) {
                                            _debounce.run(() {
                                              _readSaleProductsProvider
                                                  .setCurrentProductIndex(
                                                      index: index);
                                            });
                                          }
                                        },
                                        child: SaleProductItemWidget(
                                          product: product,
                                          ipAddress:
                                              _readSaleProvider.ipAddress,
                                          imgHeight: imageHeight,
                                          onTap: () async {
                                            if (product.variantCount > 0) {
                                              GlobalService.openDialog(
                                                  contentWidget: DialogWidget(
                                                    titleIcon:
                                                        RestaurantDefaultIcons
                                                            .variant,
                                                    title:
                                                        'screens.sale.variants.title',
                                                    content:
                                                        ProductVariantWidget(
                                                      product: product,
                                                      branchId:
                                                          _readSaleProductsProvider
                                                              .branchId,
                                                      depId:
                                                          _readSaleProductsProvider
                                                              .depId,
                                                    ),
                                                    onInsertPressed: () async {
                                                      final result =
                                                          await _readSaleProvider
                                                              .addProductVariant(
                                                                  productId:
                                                                      product
                                                                          .id);
                                                      if (result != null) {
                                                        Alert.show(
                                                            description: result
                                                                .description,
                                                            type: result.type);
                                                      }
                                                    },
                                                  ),
                                                  context: context);
                                            } else {
                                              ResponseModel? result =
                                                  await _readSaleProvider
                                                      .handleItemClick(
                                                          item: SaleAddProductModel
                                                              .fromJson(product
                                                                  .toJson()));
                                              if (result != null) {
                                                Alert.show(
                                                    description:
                                                        result.description,
                                                    type: result.type);
                                              }
                                            }
                                          },
                                        ),
                                      );
                                    }),
                              ),
                              if (data.isLoadMore)
                                const CircularProgressIndicator.adaptive()
                            ],
                          );
                  }
                }),
          ),
          SizedBox(height: widget.slidingUpPanelMinHeight)
        ],
      ),
    );
  }
}
