import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/convert_date_time.dart';
import '../../models/notification/notification_data_model.dart';
import '../../utils/constants.dart';
import '../icon_with_text_widget.dart';

class NotificationContentListWidget extends StatelessWidget {
  final NotificationDataModel notification;
  final void Function()? onTap;
  final void Function()? onRemove;
  const NotificationContentListWidget(
      {super.key, required this.notification, this.onTap, this.onRemove});
  final prefixNotificationContent = "screens.sale.notification.content";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget? leadingWidget;
    Widget? titleWidget;
    String title = '';
    String invoiceTitle =
        '${ConvertDateTime.formatTimeStampToString(notification.date ?? DateTime.now(), true)}\n${notification.department?.name} - ${notification.table?.name}';
    String description = '';
    switch (notification.type) {
      case 'IO':
        title = invoiceTitle;
        description = '$prefixNotificationContent.invoice.itemsOrdered'.tr();
        break;
      case 'RP':
        title = invoiceTitle;
        description = '$prefixNotificationContent.invoice.requestPayment'.tr();
        break;
      case 'CM':
        leadingWidget = const Icon(
          RestaurantDefaultIcons.notificationFromChefMonitorReady,
          color: AppThemeColors.success,
        );
        title =
            '${notification.floorName} - ${notification.tableName} | ${notification.itemName} | ${notification.qty}';
        if (notification.extraItemDoc != null) {
          for (int i = 0; i < notification.extraItemDoc!.length; i++) {
            description = ' -${notification.extraItemDoc![i].itemName}';
          }
        }
        break;
      default:
        leadingWidget = const Icon(
            RestaurantDefaultIcons.notificationStockWarning,
            color: AppThemeColors.warning);
        title = '${notification.itemName}';
        description = '$prefixNotificationContent.stock'
            .tr(namedArgs: {'qty': '${notification.qty}'});
    }
    titleWidget = ['IO', 'RP'].contains(notification.type)
        ? IconWithTextWidget(
            icon: notification.isRead == true
                ? RestaurantDefaultIcons.notificationInvoiceRead
                : RestaurantDefaultIcons.notificationInvoiceUnread,
            iconSize: AppStyleDefaultProperties.w,
            iconColor: AppThemeColors.primary,
            dynamicText: invoiceTitle,
          )
        : Text(
            title,
            style: theme.textTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.bold),
          );

    return ListTile(
      dense: true,
      tileColor: notification.isRead != null && notification.isRead != true
          ? theme.focusColor
          : null,
      leading: leadingWidget,
      title: titleWidget,
      subtitle: RichText(
          text: TextSpan(
              text: description,
              style: theme.textTheme.bodySmall,
              children: [
            TextSpan(
                text: notification.refNo,
                style: theme.textTheme.bodySmall!
                    .copyWith(color: AppThemeColors.primary))
          ])),
      trailing: onRemove != null
          ? IconButton(
              onPressed: onRemove,
              icon: const Icon(
                RestaurantDefaultIcons.removeNotification,
                color: AppThemeColors.failure,
              ))
          : null,
      onTap: onTap,
    );
  }
}
