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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            IconWithTextWidget(
                icon: RestaurantDefaultIcons.tableStatus,
                iconColor: RestaurantTableStatusColors.open,
                text: '$prefixTableStatus.free'),
            const SizedBox(width: AppStyleDefaultProperties.w),
            IconWithTextWidget(
              icon: RestaurantDefaultIcons.tableStatus,
              iconColor: RestaurantTableStatusColors.busy,
              text: '$prefixTableStatus.busy',
            ),
            const SizedBox(width: AppStyleDefaultProperties.w),
            IconWithTextWidget(
              icon: RestaurantDefaultIcons.tableStatus,
              iconColor: RestaurantTableStatusColors.isPrintBill,
              text: '$prefixTableStatus.isPrintBill',
            ),
            const SizedBox(width: AppStyleDefaultProperties.w),
            IconWithTextWidget(
              icon: RestaurantDefaultIcons.tableStatus,
              iconColor: RestaurantTableStatusColors.closed,
              text: '$prefixTableStatus.closed',
            )
          ],
        ),
      ),
    );
  }
}
