import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/servers/response_model.dart';
import '../../../providers/app_provider.dart';
import '../../../services/global_service.dart';
import '../../../utils/alert/alert.dart';
import '../../providers/sale/notification_provider.dart';
import '../../utils/constants.dart';
import '../../utils/notification/notification_utils.dart';
import '../badge_widget.dart';
import 'notification_dialog_widget.dart';
import 'notification_widget.dart';

class NotificationCenterWidget extends StatelessWidget {
  const NotificationCenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider readAppProvider = context.read<AppProvider>();
    NotificationProvider readNotificationProvider =
        context.read<NotificationProvider>();
    return Selector<NotificationProvider, int>(
      selector: (context, state) => state.newNotification.unreadCount,
      builder: (context, totalCount, child) => BadgeWidget(
        count: totalCount,
        child: SizedBox(
          width: 48.0,
          height: 48.0,
          child: FilledButton(
            onPressed: () {
              GlobalService.openDialog(
                contentWidget: NotificationDialogWidget(
                  titleIcon: RestaurantDefaultIcons.notification,
                  title: 'screens.sale.notification.title',
                  content: const NotificationWidget(),
                  onRemoveAllPressed: () async {
                    String branchId = readAppProvider.selectedBranch!.id;
                    List<String> notificationTypes =
                        readNotificationProvider.notificationType ==
                                NotificationType.invoice.toValue
                            ? ['RP', 'IO']
                            : [readNotificationProvider.notificationType];
                    final ResponseModel? result =
                        await readNotificationProvider.removeAllNotification(
                            notificationTypes: notificationTypes,
                            branchId: branchId);
                    if (result != null) {
                      late SnackBar snackBar;
                      snackBar = Alert.awesomeSnackBar(
                          message: result.message, type: result.type);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                  },
                ),
                context: context,
              );
            },
            style: FilledButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: const Icon(RestaurantDefaultIcons.notification),
          ),
        ),
      ),
    );
  }
}
