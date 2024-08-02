import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../../providers/app_provider.dart';
import '../../../utils/constants.dart';
import '../../providers/dashboard/dashboard_provider.dart';
import '../../utils/constants.dart';
import 'feature_item_widget.dart';

class FeatureWidget extends StatelessWidget {
  FeatureWidget({super.key});
  final List<SelectOptionModel> features = [
    const SelectOptionModel(
        icon: RestaurantDefaultIcons.newSale,
        label: "screens.dashboard.features.newSale",
        value: "saleTable",
        extra: AppThemeColors.primary),
    const SelectOptionModel(
        icon: RestaurantDefaultIcons.fastSale,
        label: "screens.dashboard.features.fastSale",
        value: "sale",
        extra: AppThemeColors.failure)
  ];
  final double height = 100.0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: GridView.builder(
          itemCount: features.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: AppStyleDefaultProperties.h,
              crossAxisSpacing: AppStyleDefaultProperties.w,
              mainAxisExtent: height,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            final SelectOptionModel feature = features[index];
            return FeatureItemWidget(
              label: feature.label,
              icon: feature.icon!,
              onPressed: () async {
                final String branchId =
                    context.read<AppProvider>().selectedBranch!.id;
                Map<String, dynamic> table = await context
                    .read<DashboardProvider>()
                    .fetchOneTable(branchId: branchId);
                if (table.isNotEmpty && context.mounted) {
                  context.goNamed(feature.value, queryParameters: {
                    'table': table['_id'],
                    'fastSale': 'true'
                  });
                }
              },
              bgColor: feature.extra,
            );
          }),
    );
  }
}
