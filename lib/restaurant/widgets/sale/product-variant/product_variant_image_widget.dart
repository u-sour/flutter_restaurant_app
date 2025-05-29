import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants.dart';
import '../../../models/sale/product/sale_product_model.dart';
import '../../no_image_widget.dart';

class ProductVariantImageWidget extends StatelessWidget {
  final SaleProductModel product;
  final String? imgUrl;
  final double height;
  const ProductVariantImageWidget(
      {super.key, required this.product, this.imgUrl, this.height = 180.0});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: product.photoUrl ?? '',
          maxHeightDiskCache: height.toInt(),
          placeholder: (context, url) {
            return ProductVariantNoImageWidget(height: height);
          },
          errorWidget: (context, url, error) {
            return ProductVariantNoImageWidget(height: height);
          },
          imageBuilder: (context, imageProvider) {
            return Container(
              width: height,
              height: height,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppStyleDefaultProperties.r),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: imageProvider,
                ),
              ),
            );
          },
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
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ProductVariantNoImageWidget extends StatelessWidget {
  final double height;
  const ProductVariantNoImageWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: height,
      height: height,
      decoration: BoxDecoration(
        color: theme.highlightColor,
        borderRadius: BorderRadius.circular(AppStyleDefaultProperties.r),
      ),
      child: const NoImageWidget(),
    );
  }
}
