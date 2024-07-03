import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../../utils/constants.dart';
import '../../utils/constants.dart';
import 'feature_item_widget.dart';

class FeatureWidget extends StatelessWidget {
  const FeatureWidget({super.key});
  final List<SelectOptionModel> features = const [
    SelectOptionModel(
      icon: RestaurantDefaultIcons.newSale,
      label: "screens.dashboard.features.newSale",
      value: "saleTable",
    ),
    SelectOptionModel(
      icon: RestaurantDefaultIcons.fastSale,
      label: "screens.dashboard.features.fastSale",
      value: "sale",
    )
  ];
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.orientationOf(context);
    return Expanded(
      child: GridView.builder(
          itemCount: features.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: AppStyleDefaultProperties.h,
              crossAxisSpacing: AppStyleDefaultProperties.w,
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4),
          itemBuilder: (context, index) {
            final SelectOptionModel feature = features[index];
            return FeatureItemWidget(
              label: feature.label,
              icon: feature.icon!,
              onPressed: () {
                context.pushNamed(feature.value);
              },
            );
          }),
    );
  }
}
