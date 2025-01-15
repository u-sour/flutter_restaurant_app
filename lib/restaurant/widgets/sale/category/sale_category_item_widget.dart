import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../utils/constants.dart';
import '../../../models/sale/category/sale_category_model.dart';
import '../../../utils/sale/sale_utils.dart';

class SaleCategoryItemWidget extends StatelessWidget {
  final String ipAddress;
  final bool isCategorySelected;
  final SaleCategoryModel category;
  final void Function()? onPressed;
  const SaleCategoryItemWidget({
    super.key,
    required this.ipAddress,
    required this.isCategorySelected,
    required this.category,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const double iconSize = 24.0;
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          backgroundColor:
              isCategorySelected ? theme.colorScheme.primary : null,
          side: BorderSide(color: theme.colorScheme.primary),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppStyleDefaultProperties.r)))),
      label: Row(
        children: [
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: category.icon != null
                ? SvgPicture.network(
                    getImgSrc(ipAddress: ipAddress, imgUrl: category.icon!),
                    colorFilter: ColorFilter.mode(
                        isCategorySelected
                            ? theme.colorScheme.onPrimary
                            : theme.iconTheme.color!,
                        BlendMode.srcIn),
                    placeholderBuilder: (context) =>
                        const CircularProgressIndicator(),
                  )
                : null,
          ),
          const SizedBox(width: AppStyleDefaultProperties.w / 2),
          Expanded(
            child: Text(
              category.name,
              style: theme.textTheme.bodyLarge!.copyWith(
                  color:
                      isCategorySelected ? theme.colorScheme.onPrimary : null),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
