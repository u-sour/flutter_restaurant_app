import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants.dart';
import '../../../widgets/icon_with_text_widget.dart';
import '../../providers/sale/notification_provider.dart';
import '../../services/user_service.dart';
import '../../utils/notification/notification_utils.dart';

class NotificationDialogWidget extends StatelessWidget {
  final IconData titleIcon;
  final String title;
  final Widget content;
  final String removeAllLabel;
  final void Function()? onRemoveAllPressed;
  const NotificationDialogWidget(
      {super.key,
      required this.titleIcon,
      required this.title,
      required this.content,
      this.removeAllLabel = 'screens.sale.notification.btn.removeAll',
      this.onRemoveAllPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.all(AppStyleDefaultProperties.p),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconWithTextWidget(
            icon: titleIcon,
            text: title,
          ),
          IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(AppDefaultIcons.close))
        ],
      ),
      content: content,
      actionsPadding: EdgeInsets.zero,
      actions: [
        Selector<NotificationProvider, String>(
          selector: (context, state) => state.notificationType,
          builder: (context, notificationType, child) => notificationType !=
                      NotificationType.stockAlert.toValue &&
                  UserService.userInRole(roles: ['cashier'])
              ? Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: onRemoveAllPressed ?? () => context.pop(),
                        style: theme.filledButtonTheme.style!.copyWith(
                            shape: const WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(
                                          AppStyleDefaultProperties.r + 8))),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                                AppThemeColors.failure)),
                        child: Text(removeAllLabel.tr(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
