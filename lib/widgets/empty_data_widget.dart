import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class EmptyDataWidget extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String title;
  final String description;
  final MainAxisAlignment mainAxisAlignment;
  const EmptyDataWidget(
      {super.key,
      this.icon = AppDefaultIcons.emptyData,
      this.iconSize = AppStyleDefaultProperties.h * 3,
      this.title = 'emptyData.title',
      this.description = "emptyData.description",
      this.mainAxisAlignment = MainAxisAlignment.center});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(icon, size: iconSize),
        Text(title.tr(),
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge!
                .copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: AppStyleDefaultProperties.h),
        Text(description.tr(),
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium!
                .copyWith(fontWeight: FontWeight.normal))
      ],
    );
  }
}
