import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../../router/route_utils.dart';
import '../../../utils/constants.dart';
import '../../providers/sale/sale_provider.dart';
import '../../services/sale_service.dart';
import '../../services/user_service.dart';
import '../../utils/constants.dart';
import 'feature_item_widget.dart';

class FeatureWidget extends StatelessWidget {
  FeatureWidget({super.key});
  final List<SelectOptionModel> features = [];
  final double height = 100.0;
  @override
  Widget build(BuildContext context) {
    bool isSkipTableModule =
        SaleService.isModuleActive(modules: ['skip-table'], context: context);
    // Button Sale បង្ហាញពេល user role == cashier || tablet-orders && module skip-table មិន active
    if (UserService.userInRole(roles: ['cashier', 'tablet-orders']) &&
        !isSkipTableModule) {
      features.add(SelectOptionModel(
          icon: RestaurantDefaultIcons.newSale,
          label: "screens.dashboard.features.newSale",
          value: () => context.goNamed(SCREENS.saleTable.toName),
          extra: AppThemeColors.success));
    }
    // Button Fast Sale បង្ហាញពេល user role == insert-invoice
    if (UserService.userInRole(roles: ['insert-invoice'])) {
      features.add(SelectOptionModel(
          icon: RestaurantDefaultIcons.fastSale,
          label: "screens.dashboard.features.fastSale",
          value: () => context
              .read<SaleProvider>()
              .handleEnterSale(fastSale: true, context: context),
          extra: AppThemeColors.failure));
    }
    return features.isNotEmpty
        ? SizedBox(
            height: height,
            child: GridView.builder(
                itemCount: features.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: AppStyleDefaultProperties.h,
                    crossAxisSpacing: AppStyleDefaultProperties.w,
                    mainAxisExtent: height,
                    crossAxisCount: features.length),
                itemBuilder: (context, index) {
                  final SelectOptionModel feature = features[index];
                  return FeatureItemWidget(
                    label: feature.label,
                    icon: feature.icon!,
                    onPressed: feature.value,
                    bgColor: feature.extra,
                  );
                }),
          )
        : const SizedBox.shrink();
  }
}
