import 'package:flutter/material.dart';

class IconWithTextWidget extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final double width;
  final String data;
  const IconWithTextWidget({
    super.key,
    required this.icon,
    this.iconColor,
    this.width = 8.0,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: iconColor),
      SizedBox(width: width),
      Text(data,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w600,
          ))
    ]);
  }
}
