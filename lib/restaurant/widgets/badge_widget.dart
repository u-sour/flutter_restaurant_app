import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../../utils/constants.dart';

class BadgeWidget extends StatelessWidget {
  final int count;
  final bool showBadge;
  final Color badgeColor;
  final Widget child;
  const BadgeWidget({
    super.key,
    this.count = 0,
    this.showBadge = true,
    this.badgeColor = AppThemeColors.failure,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double top = -8;
    double end = -10;
    if ('$count'.length > 1) top = -6;
    if ('$count'.length > 2) {
      top = -4;
      end = -22;
    }

    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: top, end: end),
      showBadge: showBadge,
      badgeContent: Text('$count',
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white)),
      badgeStyle: badges.BadgeStyle(
        elevation: 0.0,
        badgeColor: badgeColor,
        padding: const EdgeInsets.all(AppStyleDefaultProperties.p / 2),
      ),
      badgeAnimation: const badges.BadgeAnimation.scale(),
      child: child,
    );
  }
}
