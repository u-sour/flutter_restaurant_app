import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import '../../../../utils/constants.dart';
import '../../../models/sale/product/sale_product_model.dart';
import '../../../utils/sale/sale_utils.dart';
import '../../no_image_widget.dart';
import '../../format_currency_widget.dart';

class SaleProductItemWidget extends StatelessWidget {
  final SaleProductModel product;
  final double? imgHeight;
  final String ipAddress;
  final VoidCallback? onTap;
  // final bool selected;
  // final bool lastSelectedItem;

  const SaleProductItemWidget({
    super.key,
    required this.product,
    // this.product,
    this.imgHeight = 180.0,
    required this.ipAddress,
    this.onTap,
    // required this.selected,
    //  required this.lastSelectedItem,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double priceBgColorOpacity = 0.8;
    double discountBgColorOpacity = 0.8;
    // double lastSelectedItemOpacity = 1;
    // double normalSelectedItemOpacity = 0.45;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppStyleDefaultProperties.r),
          child: product.photoUrl != null
              ? CachedNetworkImage(
                  imageUrl: getImgSrc(
                      ipAddress: ipAddress, imgUrl: product.photoUrl!),
                  errorWidget: (context, url, error) {
                    return Container(
                      width: double.infinity,
                      height: imgHeight,
                      foregroundDecoration: RotatedCornerDecoration.withColor(
                        textSpan: TextSpan(
                            text: '0%',
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold)),
                        badgeCornerRadius:
                            const Radius.circular(AppStyleDefaultProperties.r),
                        color: AppThemeColors.primary
                            .withOpacity(discountBgColorOpacity),
                        badgeSize: const Size(64, 64),
                        badgePosition: BadgePosition.bottomStart,
                        textDirection: TextDirection.rtl,
                      ),
                      child: Material(
                        color: theme.highlightColor,
                        child: InkWell(
                          onTap: onTap,
                          child: Column(
                            children: [
                              // Price
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          color: AppThemeColors.primary
                                              .withOpacity(priceBgColorOpacity),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: FormatCurrencyWidget(
                                            value: product.price)),
                                  ],
                                ),
                              ),
                              // Image
                              const NoImageWidget()
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  imageBuilder: (context, imageProvider) => Container(
                    width: double.infinity,
                    height: imgHeight,
                    foregroundDecoration: RotatedCornerDecoration.withColor(
                      textSpan: TextSpan(
                          text: '0%',
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold)),
                      badgeCornerRadius:
                          const Radius.circular(AppStyleDefaultProperties.r),
                      color: AppThemeColors.primary
                          .withOpacity(discountBgColorOpacity),
                      badgeSize: const Size(64, 64),
                      badgePosition: BadgePosition.bottomStart,
                      textDirection: TextDirection.rtl,
                    ),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      image: DecorationImage(
                          fit: BoxFit.cover, image: imageProvider),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onTap,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color: AppThemeColors.primary
                                            .withOpacity(priceBgColorOpacity),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: FormatCurrencyWidget(
                                          value: product.price)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: imgHeight,
                  foregroundDecoration: RotatedCornerDecoration.withColor(
                    textSpan: TextSpan(
                        text: '0%',
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.bold)),
                    badgeCornerRadius:
                        const Radius.circular(AppStyleDefaultProperties.r),
                    color: AppThemeColors.primary
                        .withOpacity(discountBgColorOpacity),
                    badgeSize: const Size(64, 64),
                    badgePosition: BadgePosition.bottomStart,
                    textDirection: TextDirection.rtl,
                  ),
                  child: Material(
                    color: theme.highlightColor,
                    child: InkWell(
                      onTap: onTap,
                      child: Column(
                        children: [
                          // Price
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: AppThemeColors.primary
                                          .withOpacity(priceBgColorOpacity),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: FormatCurrencyWidget(
                                        value: product.price)),
                              ],
                            ),
                          ),
                          // Image
                          const NoImageWidget()
                        ],
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
              if (product.code != null)
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
            ],
          ),
        ),
      ],
    );
  }
}
