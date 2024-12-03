import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utils/constants.dart';
import '../../utils/responsive/responsive_layout.dart';
import '../../widgets/icon_with_text_widget.dart';

enum DialogType { insert, update }

class DialogWidget extends StatelessWidget {
  final DialogType type;
  final IconData titleIcon;
  final String title;
  final Widget content;
  final bool enableActions;
  final bool enableInsertAndPrintAction;
  final String cancelLabel;
  final void Function()? onCancelPressed;
  final String insertLabel;
  final void Function()? onInsertPressed;
  final String insertAndPrintLabel;
  final void Function()? onInsertAndPrintPressed;
  final String updateLabel;
  final void Function()? onUpdatePressed;
  const DialogWidget(
      {super.key,
      this.type = DialogType.insert,
      required this.titleIcon,
      required this.title,
      required this.content,
      this.enableActions = true,
      this.enableInsertAndPrintAction = false,
      this.cancelLabel = 'dialog.actions.cancel',
      this.onCancelPressed,
      this.insertLabel = 'dialog.actions.insert',
      this.onInsertPressed,
      this.insertAndPrintLabel = 'dialog.actions.insertAndPrint',
      this.onInsertAndPrintPressed,
      this.updateLabel = "dialog.actions.update",
      this.onUpdatePressed});

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
        padding: enableActions
            ? const EdgeInsets.symmetric(
                horizontal: AppStyleDefaultProperties.p)
            : const EdgeInsets.only(
                left: AppStyleDefaultProperties.p,
                right: AppStyleDefaultProperties.p,
                bottom: AppStyleDefaultProperties.p),
        child: content,
      ),
      actionsPadding: const EdgeInsets.all(AppStyleDefaultProperties.p),
      actions: enableActions
          ? [
              Row(
                children: [
                  // visible cancel button on tablet or desktop mode
                  // or enableInsertAndPrintAction == false
                  if (!ResponsiveLayout.isMobile(context) ||
                      !enableInsertAndPrintAction) ...[
                    Expanded(
                      child: FilledButton(
                        onPressed: onCancelPressed ?? () => context.pop(),
                        style: theme.filledButtonTheme.style!.copyWith(
                            backgroundColor: WidgetStateProperty.all(
                                AppThemeColors.failure)),
                        child: Text(cancelLabel.tr(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: AppStyleDefaultProperties.w)
                  ],
                  Expanded(
                    child: FilledButton(
                      onPressed: type.name == 'insert'
                          ? onInsertPressed
                          : onUpdatePressed,
                      child: Text(
                          type.name == 'insert'
                              ? insertLabel.tr()
                              : updateLabel.tr(),
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  if (enableInsertAndPrintAction) ...[
                    const SizedBox(width: AppStyleDefaultProperties.w),
                    Expanded(
                      child: FilledButton(
                        onPressed: onInsertAndPrintPressed,
                        style: theme.filledButtonTheme.style!.copyWith(
                            backgroundColor:
                                WidgetStateProperty.all(AppThemeColors.info)),
                        child: Text(insertAndPrintLabel.tr(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  ]
                ],
              ),
              // visible cancel button on mobile mode
              if (ResponsiveLayout.isMobile(context) &&
                  enableInsertAndPrintAction) ...[
                const SizedBox(height: AppStyleDefaultProperties.h),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: onCancelPressed ?? () => context.pop(),
                        style: theme.filledButtonTheme.style!.copyWith(
                            backgroundColor: WidgetStateProperty.all(
                                AppThemeColors.failure)),
                        child: Text(cancelLabel.tr(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              ],
            ]
          : null,
    );
  }
}
