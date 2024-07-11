import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../models/widgets/avatar_initial_widget_model.dart';
import '../models/widgets/avatar_menu_widget_model.dart';

class AvatarWidget extends StatelessWidget {
  final AvatarInitialWidgetModel? initial;
  final double radius;
  final double borderWidth;
  final Color? borderColor;
  final List<AvatarMenuWidgetModel>? menu;

  const AvatarWidget({
    super.key,
    this.initial,
    this.radius = 24.0,
    this.borderWidth = 3,
    this.borderColor,
    this.menu,
  });

  String getInitials(String string) => string.isNotEmpty
      ? string.trim().split(RegExp(' +')).map((s) => s[0]).join().toUpperCase()
      : '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return CircularProfileAvatar(
          initial?.imageUrl ?? '',
          errorWidget: (context, url, error) => const Icon(Icons.error),
          placeHolder: (context, url) => const SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
          radius: radius,
          backgroundColor: theme.scaffoldBackgroundColor,
          borderWidth: borderWidth,
          initialsText: Text(
            getInitials(initial?.label ?? ''),
            style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
          ),
          borderColor: borderColor ?? theme.colorScheme.primary,
          imageFit: BoxFit.fitHeight,
          elevation: 0.0,
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          cacheImage: true,
          showInitialTextAbovePicture: false,
        );
      },
      menuChildren: menu != null
          ? menu!
              .map(
                (m) => MenuItemButton(
                  leadingIcon: Icon(m.icon),
                  onPressed: m.onTap,
                  child: Text(m.title),
                ),
              )
              .toList()
          : [],
    );
  }
}
