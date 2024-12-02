import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../utils/constants.dart';

class NoImageWidget extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color? iconColor;
  final String description;
  final TextStyle? descriptionTextStyle;
  final double opacity;
  const NoImageWidget(
      {super.key,
      this.icon = RestaurantDefaultIcons.noImage,
      this.iconSize = AppStyleDefaultProperties.h * 3,
      this.iconColor,
      this.description = 'noImage',
      this.descriptionTextStyle,
      this.opacity = 0.4});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Opacity(
      opacity: opacity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: iconColor ?? theme.iconTheme.color, size: iconSize),
            Text(
              description.tr(),
              style: descriptionTextStyle ?? theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
