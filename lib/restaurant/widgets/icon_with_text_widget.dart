import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/constants.dart';

class IconWithTextWidget extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final double width;
  final String text;
  final String dynamicText;
  final FontWeight? fontWeight;

  /// Note: dynamicText doesn't change with easy_localization
  const IconWithTextWidget(
      {super.key,
      required this.icon,
      this.iconColor,
      this.width = AppStyleDefaultProperties.w / 2,
      this.text = '',
      this.dynamicText = '',
      this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(children: [
      Icon(icon, color: iconColor),
      SizedBox(width: width),
      Text(
        dynamicText.isNotEmpty ? dynamicText : text.tr(),
        style: theme.textTheme.bodyMedium!.copyWith(fontWeight: fontWeight),
        overflow: TextOverflow.ellipsis,
      )
    ]);
  }
}
