import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../utils/constants.dart';
import '../../../../models/sale/detail/sale_detail_extra_item_model.dart';
import '../../../../utils/constants.dart';
import '../../../icon_with_text_widget.dart';
import 'sale_detail_extra_items_child_widget.dart';

class SaleDetailExtraItemsWidget extends StatelessWidget {
  final IconData titleIcon;
  final String title;
  final List<SaleDetailExtraItemModel?> extraItems;
  const SaleDetailExtraItemsWidget({
    super.key,
    this.titleIcon = RestaurantDefaultIcons.extraFoods,
    this.title = 'screens.sale.category.extraFoods',
    required this.extraItems,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(
          left: AppStyleDefaultProperties.p,
          top: AppStyleDefaultProperties.p,
          right: AppStyleDefaultProperties.p),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconWithTextWidget(
            icon: titleIcon,
            text: title,
          ),
          IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(AppDefaultIcons.close))
        ],
      ),
      content: SizedBox(
        width: double.minPositive,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: extraItems.length,
            itemBuilder: (BuildContext context, int index) {
              final SaleDetailExtraItemModel extraItem = extraItems[index]!;
              return SaleDetailExtraItemsChildWidget(extraItem: extraItem);
            }),
      ),
    );
  }
}
