import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';

class FeatureItemWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function()? onPressed;
  final Color bgColor;
  const FeatureItemWidget({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FilledButton(
      onPressed: onPressed,
      style: theme.filledButtonTheme.style
          ?.copyWith(backgroundColor: WidgetStateProperty.all(bgColor)),
      child: Column(
        children: [
          Expanded(
            child: Text(
              context.tr(label),
              style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Icon(icon)),
        ],
      ),
    );
  }
}
