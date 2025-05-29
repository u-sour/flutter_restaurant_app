import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import '../../../../utils/constants.dart';
import '../../../models/sale/add-product/sale_add_product_model.dart';
import '../../../models/sale/detail/sale_detail_model.dart';
import '../../../models/sale/product/sale_product_model.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../utils/constants.dart';
import '../../no_image_widget.dart';
import '../../format_currency_widget.dart';

class SaleProductItemWidget extends StatelessWidget {
  final SaleProductModel product;
  final double? imgHeight;
  final String ipAddress;
  final VoidCallback? onTap;

  const SaleProductItemWidget({
    super.key,
    required this.product,
    this.imgHeight = 180.0,
    required this.ipAddress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double discountBgColorOpacity = 0.8;
    // discount
    Decoration? discountDecoration;
    if (product.discount > 0) {
      discountDecoration = RotatedCornerDecoration.withColor(
        textSpan: TextSpan(
            text: '${product.discount}%',
            style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold)),
        badgeCornerRadius: const Radius.circular(AppStyleDefaultProperties.r),
        color: AppThemeColors.primary.withOpacity(discountBgColorOpacity),
        badgeSize: const Size(64, 64),
        badgePosition: BadgePosition.bottomStart,
        textDirection: TextDirection.rtl,
      );
    }
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppStyleDefaultProperties.r),
          child: CachedNetworkImage(
            width: imgHeight,
            height: imgHeight,
            imageUrl: product.photoUrl ?? '',
            maxHeightDiskCache: imgHeight?.toInt(), // resize image
            placeholder: (context, url) {
              return Container(
                width: double.infinity,
                height: imgHeight,
                foregroundDecoration: discountDecoration,
                child: Material(
                  color: theme.highlightColor,
                  child: InkWell(
                    onTap: onTap,
                    child: Padding(
                      padding: const EdgeInsets.all(
                          AppStyleDefaultProperties.p / 1.5),
                      child: Stack(
                        children: [
                          // Price
                          SaleProductItemPriceWidget(product: product),
                          // Image
                          const NoImageWidget(),
                          // Item Selected
                          SaleProductItemSelectedWidget(product: product)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                width: double.infinity,
                height: imgHeight,
                foregroundDecoration: discountDecoration,
                child: Material(
                  color: theme.highlightColor,
                  child: InkWell(
                    onTap: onTap,
                    child: Padding(
                      padding: const EdgeInsets.all(
                          AppStyleDefaultProperties.p / 1.5),
                      child: Stack(
                        children: [
                          // Price
                          SaleProductItemPriceWidget(product: product),
                          // Image
                          const NoImageWidget(),
                          // Item Selected
                          SaleProductItemSelectedWidget(product: product)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            imageBuilder: (context, imageProvider) => Container(
              width: double.infinity,
              height: imgHeight,
              foregroundDecoration: discountDecoration,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding:
                        const EdgeInsets.all(AppStyleDefaultProperties.p / 1.5),
                    child: Stack(
                      children: [
                        // Price
                        SaleProductItemPriceWidget(product: product),
                        // Item Selected
                        SaleProductItemSelectedWidget(product: product)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: AppStyleDefaultProperties.h),
          child: Column(
            children: [
              if (product.code != null && product.code!.isNotEmpty)
                Text(
                  product.code!,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (product.category != null && product.showCategory == true)
                Text(product.category!,
                    style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppThemeColors.primary)),
              Text(
                product.name,
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppStyleDefaultProperties.h * 2)
            ],
          ),
        ),
      ],
    );
  }
}

class SaleProductItemSelectedWidget extends StatelessWidget {
  final SaleProductModel product;
  final double selectedItemOpacity = 0.5;
  final double lastSelectedItemOpacity = 1;
  const SaleProductItemSelectedWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Selector<
            SaleProvider,
            ({
              List<SaleDetailModel> saleDetails,
              SaleAddProductModel? lastItemAdded
            })>(
        selector: (context, state) => (
              saleDetails: state.saleDetails,
              lastItemAdded: state.lastItemAdded
            ),
        builder: (context, data, child) {
          bool isSelected = data.saleDetails.isNotEmpty &&
              data.saleDetails
                  .where((sd) => sd.itemId == product.id)
                  .isNotEmpty;
          bool isLastSelectedItem = data.lastItemAdded != null &&
              data.lastItemAdded!.id == product.id;
          return isSelected
              ? Align(
                  alignment: Alignment.bottomLeft,
                  child: Icon(
                    RestaurantDefaultIcons.selectedItem,
                    color: AppThemeColors.primary.withOpacity(isLastSelectedItem
                        ? lastSelectedItemOpacity
                        : selectedItemOpacity),
                  ),
                )
              : const SizedBox.shrink();
        });
  }
}

class SaleProductItemPriceWidget extends StatelessWidget {
  const SaleProductItemPriceWidget({
    super.key,
    this.priceBgColorOpacity = 0.8,
    required this.product,
  });

  final double priceBgColorOpacity;
  final SaleProductModel product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const prefixVariantTitle = 'screens.sale.variants.title';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: const EdgeInsets.all(AppStyleDefaultProperties.p / 2.4),
            decoration: BoxDecoration(
              color: AppThemeColors.primary.withOpacity(priceBgColorOpacity),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: product.variantCount > 0
                ? Text(
                    '${product.variantCount} ${prefixVariantTitle.tr()}',
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormatCurrencyWidget(
                        value: product.price,
                        color: product.discountPrice != null &&
                                product.discountPrice! > 0
                            ? theme.colorScheme.onPrimary.withOpacity(.35)
                            : null,
                      ),
                      if (product.discountPrice != null &&
                          product.discountPrice! > 0)
                        FormatCurrencyWidget(value: product.discountPrice!),
                    ],
                  )),
      ],
    );
  }
}
