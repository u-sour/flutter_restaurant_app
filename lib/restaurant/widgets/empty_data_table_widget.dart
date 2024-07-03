import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/utils/constants.dart';

import '../../utils/constants.dart';

class EmptyDataTableWidget extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String description;
  const EmptyDataTableWidget(
      {super.key,
      this.icon = RestaurantDefaultIcons.emptyData,
      this.iconSize = AppStyleDefaultProperties.h * 3,
      this.description = "emptyDataTable.description"});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: iconSize),
        Text(description).tr(),
      ],
    );
  }
}
