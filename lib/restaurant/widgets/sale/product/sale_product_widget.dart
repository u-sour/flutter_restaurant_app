import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../models/sale/product/sale_product_model.dart';
import '../../../providers/sale/categories/sale_categories_provider.dart';
import '../../../providers/sale/products/sale_products_provider.dart';
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
  final ScrollController _productScrollController = ScrollController();
  late SaleCategoriesProvider _readSaleCategoriesProvider;
  late SaleProductsProvider _readSaleProductsProvider;
  final Debounce _debounce = Debounce();
  @override
  void initState() {
    super.initState();
    _readSaleCategoriesProvider = context.read<SaleCategoriesProvider>();
    _readSaleProductsProvider = context.read<SaleProductsProvider>();
    // listen user scrolling to the bottom then load more products
    _productScrollController.addListener(() {
      if (_productScrollController.position.pixels ==
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
      crossAxisCount = 4;
      imageHeight = 180.0;
    }
    //Tablet landscape mode
    if (ResponsiveLayout.isTablet(context) &&
        orientation == Orientation.landscape) {
      crossAxisCount = 3;
      imageHeight = 145.0;
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
                                      return SaleProductItemWidget(
                                        product: product,
                                        ipAddress:
                                            _readSaleProductsProvider.ipAddress,
                                        imgHeight: imageHeight,
                                        onTap: () {},
                                      );
                                    }),
                              ),
                              if (data.isLoadMore)
                                const CircularProgressIndicator()
                            ],
                          );
                  }
                }),
            // StreamBuilder<List<SaleProductModel>>(
            //     stream: _readSaleProductsProvider.productsStream,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasError) {
            //         return Text('${snapshot.error}');
            //       } else {
            //         if (snapshot.hasData) {
            //           if (snapshot.connectionState == ConnectionState.waiting) {
            //             return const LoadingWidget();
            //           }
            //           return DynamicHeightGridView(
            //               key: const PageStorageKey<String>('products'),
            //               itemCount: snapshot.data!.length,
            //               crossAxisCount: crossAxisCount,
            //               crossAxisSpacing: AppStyleDefaultProperties.w,
            //               mainAxisSpacing: 0.0,
            //               controller: _productScrollController,
            //               builder: (context, index) {
            //                 final SaleProductModel product =
            //                     snapshot.data![index];
            //                 return SaleProductItemWidget(
            //                   product: product,
            //                   ipAddress: _readSaleProductsProvider.ipAddress,
            //                   imgHeight: imageHeight,
            //                   onTap: () {},
            //                 );
            //               });
            //         } else {
            //           return const Text('no data');
            //         }
            //       }
            //     }),
          ),
          SizedBox(height: widget.slidingUpPanelMinHeight)
        ],
      ),
    );
  }
}
