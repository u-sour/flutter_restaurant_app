import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../utils/constants.dart';

class EmptyDataWidget extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String description;
  final MainAxisAlignment mainAxisAlignment;
  const EmptyDataWidget(
      {super.key,
      this.icon = RestaurantDefaultIcons.emptyData,
      this.iconSize = AppStyleDefaultProperties.h * 3,
      this.description = "emptyData.description",
      this.mainAxisAlignment = MainAxisAlignment.center});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(icon, size: iconSize),
        Text(description).tr(),
      ],
    );
  }
}
