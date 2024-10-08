import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../models/servers/response_model.dart';
import '../../../../utils/alert/alert.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../models/sale/add-product/sale_add_product_model.dart';
import '../../../models/sale/product/sale_product_model.dart';
import '../../../providers/sale/categories/sale_categories_provider.dart';
import '../../../providers/sale/products/sale_products_provider.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../utils/debounce.dart';
import '../../empty_data_widget.dart';
import '../../loading_widget.dart';
import '../product-group/sale_product_group_widget.dart';
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
  final Debounce _debounce = Debounce();
  @override
  void initState() {
    super.initState();
    _productScrollController = ScrollController();
    _readSaleProvider = context.read<SaleProvider>();
    _readSaleCategoriesProvider = context.read<SaleCategoriesProvider>();
    _readSaleProductsProvider = context.read<SaleProductsProvider>();

    // listen user scrolling to the bottom then load more products
    _productScrollController.addListener(() {
      if (_productScrollController.offset ==
          _productScrollController.position.maxScrollExtent) {
        _debounce.run(() async {
          String categoryId =
              _readSaleCategoriesProvider.selectedCategories.last.id;
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
      crossAxisCount = 3;
      imageHeight = 180.0;
    }
    //Tablet landscape mode
    if (ResponsiveLayout.isTablet(context) &&
        orientation == Orientation.landscape) {
      crossAxisCount = 3;
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
                                          ipAddress: _readSaleProductsProvider
                                              .ipAddress,
                                          imgHeight: imageHeight,
                                          onTap: () async {
                                            ResponseModel? result =
                                                await _readSaleProvider
                                                    .handleItemClick(
                                                        item: SaleAddProductModel
                                                            .fromJson(product
                                                                .toJson()));
                                            if (result != null) {
                                              late SnackBar snackBar;
                                              snackBar = Alert.awesomeSnackBar(
                                                  message: result.message,
                                                  type: result.type);
                                              if (!context.mounted) return;
                                              ScaffoldMessenger.of(context)
                                                ..hideCurrentSnackBar()
                                                ..showSnackBar(snackBar);
                                            }
                                          },
                                        ),
                                      );
                                    }),
                              ),
                              if (data.isLoadMore)
                                const CircularProgressIndicator()
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
