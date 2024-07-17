import 'package:flutter/material.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import '../../../../utils/constants.dart';
import '../../../utils/format_currency.dart';
import '../../no_image_widget.dart';

class SaleProductItemWidget extends StatelessWidget {
  // final ItemModel product;
  final String name;
  final double? imgHeight;
  // final String ipAddress;
  final VoidCallback? onTap;
  // final bool selected;
  // final bool lastSelectedItem;
  final String baseCurrency;
  final int decimalNumber;

  const SaleProductItemWidget({
    super.key,
    required this.name,
    // this.product,
    this.imgHeight = 180.0,
    //  required this.ipAddress,
    this.onTap,
    // required this.selected,
    //  required this.lastSelectedItem,
    required this.baseCurrency,
    required this.decimalNumber,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Map<String, double> pricePosition = {"top": 8.0, "left": 8.0};
    // double lastSelectedItemOpacity = 1;
    // double normalSelectedItemOpacity = 0.45;
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: imgHeight,
          foregroundDecoration: RotatedCornerDecoration.withColor(
            textSpan: TextSpan(
                text: '0%',
                style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            badgeCornerRadius:
                const Radius.circular(AppStyleDefaultProperties.r),
            color: AppThemeColors.primary,
            badgeSize: const Size(64, 64),
            badgePosition: BadgePosition.bottomStart,
            textDirection: TextDirection.rtl,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppStyleDefaultProperties.r),
            color: theme.highlightColor,
            // image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppStyleDefaultProperties.r),
            onTap: onTap,
            child: Stack(
              children: [
                // Price
                Positioned(
                  top: pricePosition['top'],
                  left: pricePosition['left'],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2.5),
                        decoration: BoxDecoration(
                          color: AppThemeColors.primary,
                          borderRadius: BorderRadius.circular(
                              AppStyleDefaultProperties.r),
                        ),
                        child: Text(
                          '${FormatCurrency.format(value: 5000000, baseCurrency: baseCurrency, decimalNumber: decimalNumber)} ${FormatCurrency.getBaseCurrencySymbol(baseCurrency: baseCurrency)}',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // if (selected)
                      //   Icon(
                      //     CommonPosIcons.checked,
                      //     color: theme.iconTheme.color!.withOpacity(
                      //         lastSelectedItem
                      //             ? lastSelectedItemOpacity
                      //             : normalSelectedItemOpacity),
                      //   ),
                    ],
                  ),
                ),
                const NoImageWidget()
              ],
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: AppStyleDefaultProperties.h),
          child: Text(
            name,
            style: theme.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
