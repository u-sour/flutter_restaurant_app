import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../../widgets/custom-form-builder/form_builder_custom_touch_spin.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../models/sale/product/sale_product_model.dart';
import '../../../models/sale/product/variant/product_variant_item_model.dart';
import '../../../models/sale/product/variant/product_variant_list_model.dart';
import '../../../models/sale/product/variant/product_variant_model.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../invoice/invoice_format_currency_widget.dart';
import 'product_variant_image_widget.dart';

class ProductVariantWidget extends StatefulWidget {
  final SaleProductModel product;
  final String branchId;
  final String depId;
  const ProductVariantWidget({
    super.key,
    required this.product,
    required this.branchId,
    required this.depId,
  });

  @override
  State<ProductVariantWidget> createState() => _ProductVariantWidgetState();
}

class _ProductVariantWidgetState extends State<ProductVariantWidget> {
  late SaleProvider readSaleProvider;
  // late Future<ProductVariantModel> productVariant;
  final String prefixVariant = "screens.sale.variants";
  TextEditingController qtyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    readSaleProvider = context.read<SaleProvider>();
    readSaleProvider.fetchSaleProductVariant(
      productId: widget.product.id,
      branchId: widget.branchId,
      depId: widget.depId,
    );
    // productVariant = readSaleProductsProvider.fetchSaleProductVariant(
    //     productId: widget.product.id,
    //     branchId: widget.branchId,
    //     depId: widget.depId);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Orientation orientation = MediaQuery.orientationOf(context);
    late int crossAxisCount;
    if (ResponsiveLayout.isMobile(context)) {
      crossAxisCount = 1;
    } else if (ResponsiveLayout.isTablet(context) &&
        orientation == Orientation.portrait) {
      crossAxisCount = 1;
    } else if (ResponsiveLayout.isTablet(context) &&
        orientation == Orientation.landscape) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 3;
    }
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProductVariantImageWidget(product: widget.product),
            const SizedBox(height: AppStyleDefaultProperties.h),
            Selector<SaleProvider,
                ({bool isLoading, ProductVariantModel productVariant})>(
              selector: (_, state) => (
                isLoading: state.isLoading,
                productVariant: state.productVariant
              ),
              builder: (context, data, child) => data.isLoading
                  ? const LoadingWidget()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                          // Options
                          if (data.productVariant.optionName.isNotEmpty)
                            Text(
                                "${'$prefixVariant.options'.tr()} ${data.productVariant.optionName}"),
                          // Variant List
                          if (data.productVariant.variantList.isNotEmpty)
                            ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: data.productVariant.variantList.length,
                              itemBuilder: (context, mainIndex) {
                                final ProductVariantListModel variant =
                                    data.productVariant.variantList[mainIndex];
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical:
                                              AppStyleDefaultProperties.p),
                                      child: Text(
                                          '${variant.label}: ${variant.value}',
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold)),
                                    ),
                                    // Variant List Items
                                    Container(
                                      color: theme.highlightColor,
                                      padding: const EdgeInsets.all(
                                          AppStyleDefaultProperties.p),
                                      child: DynamicHeightGridView(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: variant.items.length,
                                        crossAxisCount: variant.items.length > 1
                                            ? crossAxisCount
                                            : 1,
                                        builder: (context, index) {
                                          final ProductVariantItemModel
                                              variantItem =
                                              variant.items[index];
                                          qtyController = TextEditingController(
                                            text: '${variantItem.qty}',
                                          );
                                          return ResponsiveLayout.isMobile(
                                                  context)
                                              ? Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          bottom:
                                                              AppStyleDefaultProperties
                                                                  .p),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          if (variantItem
                                                              .name.isNotEmpty)
                                                            Text(variantItem
                                                                .name),
                                                          InvoiceFormatCurrencyWidget(
                                                            value: variantItem
                                                                .price,
                                                            priceFontSize: 14.0,
                                                            currencySymbolFontSize:
                                                                18.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    FormBuilderCustomTouchSpin(
                                                      name: '$mainIndex.$index',
                                                      controller: qtyController,
                                                      onChanged: (num value) {
                                                        variantItem.qty = value;
                                                      },
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    if (variantItem
                                                        .name.isNotEmpty)
                                                      Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                              variantItem
                                                                  .name)),
                                                    Expanded(
                                                      child:
                                                          InvoiceFormatCurrencyWidget(
                                                        value:
                                                            variantItem.price,
                                                        priceFontSize: 14.0,
                                                        currencySymbolFontSize:
                                                            18.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child:
                                                          FormBuilderCustomTouchSpin(
                                                        name:
                                                            '$mainIndex.$index',
                                                        initialValue:
                                                            variantItem.qty,
                                                        controller:
                                                            qtyController,
                                                        onChanged: (num value) {
                                                          variantItem.qty =
                                                              value;
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                );
                                        },
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
                        ]),
            )
          ],
        ),
      ),
    );
  }
}
