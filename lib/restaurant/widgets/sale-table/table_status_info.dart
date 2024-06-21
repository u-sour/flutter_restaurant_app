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
              iconColor: AppThemeColors.primary,
              data: '$prefixTableStatus.free'.tr()),
          const SizedBox(width: 8.0),
          IconWithTextWidget(
              icon: RestaurantDefaultIcons.tableStatus,
              iconColor: AppThemeColors.warning,
              data: '$prefixTableStatus.busy'.tr())
        ],
      ),
    );
  }
}
