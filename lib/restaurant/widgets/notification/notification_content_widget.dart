import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/servers/response_model.dart';
import '../../../utils/alert/alert.dart';
import '../../models/notification/notification_data_model.dart';
import '../../models/notification/notification_model.dart';
import '../../providers/sale/notification_provider.dart';
import '../../services/user_service.dart';
import '../../utils/notification/notification_utils.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/loading_widget.dart';
import 'notification_content_list_widget.dart';

class NotificationContentWidget extends StatelessWidget {
  final String notificationType;
  const NotificationContentWidget({
    super.key,
    required this.notificationType,
  });

  @override
  Widget build(BuildContext context) {
    NotificationProvider readNotificationProvider =
        context.read<NotificationProvider>();
    return Selector<NotificationProvider,
        ({NotificationModel notifications, bool isLoading, bool isFiltering})>(
      selector: (context, state) => (
        notifications: state.notifications,
        isLoading: state.isLoading,
        isFiltering: state.isFiltering
      ),
      builder: (context, data, child) {
        bool isLoading = data.isLoading;
        bool isFiltering = data.isFiltering;
        List<NotificationDataModel> notificationList = data.notifications.data;
        if (isLoading || isFiltering) {
          return const LoadingWidget();
        } else {
          return notificationList.isNotEmpty
              ? ListView.builder(
                  itemCount: notificationList.length,
                  itemBuilder: (context, index) {
                    NotificationDataModel notification =
                        data.notifications.data[index];
                    return NotificationContentListWidget(
                      notification: notification,
                      onTap:
                          notificationType == NotificationType.invoice.toValue
                              ? () async {
                                  final ResponseModel? result =
                                      await readNotificationProvider.enterSale(
                                          notification: notification,
                                          context: context);
                                  if (result != null) {
                                    late SnackBar snackBar;
                                    snackBar = Alert.awesomeSnackBar(
                                        message: result.message,
                                        type: result.type);
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar);
                                  }
                                }
                              : null,
                      onRemove: notificationType !=
                                  NotificationType.stockAlert.toValue &&
                              UserService.userInRole(roles: ['cashier'])
                          ? () async {
                              final ResponseModel? result =
                                  await readNotificationProvider
                                      .removeNotificationById(
                                          id: notification.id);
                              if (result != null) {
                                late SnackBar snackBar;
                                snackBar = Alert.awesomeSnackBar(
                                    message: result.message, type: result.type);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                              }
                            }
                          : null,
                    );
                  },
                )
              : const EmptyDataWidget();
        }
      },
    );
  }
}
