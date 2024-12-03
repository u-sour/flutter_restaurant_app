import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class IconWithTextWidget extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  final double width;
  final String text;
  final String dynamicText;
  final FontWeight? fontWeight;

  /// Note: dynamicText doesn't change with easy_localization
  const IconWithTextWidget(
      {super.key,
      required this.icon,
      this.iconColor,
      this.iconSize,
      this.width = AppStyleDefaultProperties.w / 2,
      this.text = '',
      this.dynamicText = '',
      this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(children: [
      Icon(icon, size: iconSize, color: iconColor),
      SizedBox(width: width),
      Text(
        dynamicText.isNotEmpty ? dynamicText : text.tr(),
        style: theme.textTheme.bodySmall!.copyWith(fontWeight: fontWeight),
        overflow: TextOverflow.ellipsis,
      )
    ]);
  }
}
