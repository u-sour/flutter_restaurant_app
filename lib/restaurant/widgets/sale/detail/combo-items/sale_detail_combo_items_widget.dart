import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../utils/constants.dart';
import '../../../../models/sale/detail/sale_detail_combo_item_model.dart';
import '../../../../utils/constants.dart';
import '../../../icon_with_text_widget.dart';
import 'sale_detail_combo_items_child_widget.dart';

class SaleDetailComboItemsWidget extends StatelessWidget {
  final IconData titleIcon;
  final String title;
  final List<SaleDetailComboItemModel?> comboItems;
  const SaleDetailComboItemsWidget({
    super.key,
    this.titleIcon = RestaurantDefaultIcons.catalogCombo,
    this.title = 'screens.sale.category.catalog',
    required this.comboItems,
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
            itemCount: comboItems.length,
            itemBuilder: (BuildContext context, int index) {
              final SaleDetailComboItemModel comboItem = comboItems[index]!;
              return SaleDetailComboItemsChildWidget(comboItem: comboItem);
            }),
      ),
    );
  }
}
