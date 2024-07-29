import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../utils/constants.dart';
import '../icon_with_text_widget.dart';

class TableStatusInfo extends StatelessWidget {
  const TableStatusInfo({super.key});
  final prefixTableStatus = "screens.saleTable.tableStatus";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppStyleDefaultProperties.p),
      child: Row(
        children: [
          IconWithTextWidget(
              icon: RestaurantDefaultIcons.tableStatus,
              iconColor: RestaurantTableStatusColors.open,
              data: context.tr('$prefixTableStatus.free')),
          const SizedBox(width: AppStyleDefaultProperties.w),
          IconWithTextWidget(
            icon: RestaurantDefaultIcons.tableStatus,
            iconColor: RestaurantTableStatusColors.busy,
            data: context.tr('$prefixTableStatus.busy'),
          ),
          const SizedBox(width: AppStyleDefaultProperties.w),
          IconWithTextWidget(
            icon: RestaurantDefaultIcons.tableStatus,
            iconColor: RestaurantTableStatusColors.isPrintBill,
            data: context.tr('$prefixTableStatus.isPrintBill'),
          ),
          const SizedBox(width: AppStyleDefaultProperties.w),
          IconWithTextWidget(
            icon: RestaurantDefaultIcons.tableStatus,
            iconColor: RestaurantTableStatusColors.closed,
            data: context.tr('$prefixTableStatus.closed'),
          )
        ],
      ),
    );
  }
}
