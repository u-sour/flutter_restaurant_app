import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../../utils/constants.dart';
import '../../utils/constants.dart';

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
    // final ThemeData theme = Theme.of(context);
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Expanded(
      child: GridView.builder(
          itemCount: features.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: AppStyleDefaultProperties.h,
              crossAxisSpacing: AppStyleDefaultProperties.w,
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4),
          itemBuilder: (context, index) {
            final SelectOptionModel feature = features[index];
            return FilledButton(
                onPressed: () {
                  context.pushNamed(feature.value);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      feature.label,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.0),
                    ).tr(),
                    const SizedBox(height: AppStyleDefaultProperties.h),
                    Icon(feature.icon, size: 32.0),
                  ],
                ));
          }),
    );
  }
}
