import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../utils/constants.dart';

class NotificationContentListWidget extends StatelessWidget {
  final Widget title;
  final void Function()? onTap;
  const NotificationContentListWidget(
      {super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      trailing: IconButton(
          onPressed: () {},
          icon: const Icon(
            RestaurantDefaultIcons.removeNotification,
            color: AppThemeColors.failure,
          )),
      onTap: onTap,
    );
  }
}
