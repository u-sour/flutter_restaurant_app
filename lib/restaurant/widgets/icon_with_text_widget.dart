import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class IconWithTextWidget extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final double width;
  final String text;
  final String dynamicText;

  /// Note: dynamicText doesn't change with easy_localization
  const IconWithTextWidget({
    super.key,
    required this.icon,
    this.iconColor,
    this.width = 8.0,
    this.text = '',
    this.dynamicText = '',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(children: [
      Icon(icon, color: iconColor),
      SizedBox(width: width),
      Text(
        dynamicText.isNotEmpty ? dynamicText : text.tr(),
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
      )
    ]);
  }
}
