import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/constants.dart';
import 'icon_with_text_widget.dart';

class ConfirmDialogWidget extends StatelessWidget {
  final IconData titleIcon;
  final String title;
  final Widget content;
  final String cancelLabel;
  final void Function()? onCancelPressed;
  final String agreeLabel;
  final void Function()? onAgreePressed;
  const ConfirmDialogWidget(
      {super.key,
      this.titleIcon = AppDefaultIcons.confirmation,
      this.title = 'dialog.confirm.title',
      required this.content,
      this.cancelLabel = 'dialog.confirm.actions.cancel',
      this.onCancelPressed,
      this.onAgreePressed,
      this.agreeLabel = 'dialog.confirm.actions.agree'});

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
      content: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppStyleDefaultProperties.p),
        child: content,
      ),
      actionsPadding: const EdgeInsets.all(AppStyleDefaultProperties.p),
      actions: [
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: onCancelPressed ?? () => context.pop(),
                style: theme.filledButtonTheme.style!.copyWith(
                    backgroundColor:
                        WidgetStateProperty.all(AppThemeColors.failure)),
                child: Text(cancelLabel.tr(),
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: AppStyleDefaultProperties.w),
            Expanded(
              child: FilledButton(
                onPressed: onAgreePressed,
                child: Text(agreeLabel.tr(),
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.bold)),
              ),
            )
          ],
        )
      ],
    );
  }
}
