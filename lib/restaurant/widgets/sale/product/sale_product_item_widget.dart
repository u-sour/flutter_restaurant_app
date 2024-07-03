import 'package:flutter/material.dart';
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
    // double lastSelectedItemOpacity = 1;
    // double normalSelectedItemOpacity = 0.45;

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: imgHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppStyleDefaultProperties.r),
            color: theme.highlightColor,
            // image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppStyleDefaultProperties.r),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppStyleDefaultProperties.r),
              onTap: onTap,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              color: AppThemeColors.primary,
                              borderRadius: BorderRadius.circular(
                                  AppStyleDefaultProperties.r),
                            ),
                            child: Text(
                                '${FormatCurrency().format(value: 5, baseCurrency: baseCurrency, decimalNumber: decimalNumber)} ${FormatCurrency().getBaseCurrencySymbol(baseCurrency: baseCurrency)}',
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: Colors.white))),
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
        ),
        const SizedBox(height: AppStyleDefaultProperties.h),
        Text(
          name,
          style:
              theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
