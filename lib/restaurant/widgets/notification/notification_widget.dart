import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/utils/map_index.dart';
import 'package:provider/provider.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../providers/sale/notification_provider.dart';
import '../../utils/debounce.dart';
import 'notification_content_widget.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final Debounce debounce = Debounce();
    NotificationProvider readNotificationProvider =
        context.read<NotificationProvider>();
    List<SelectOptionModel> tabs = readNotificationProvider.notificationTabs;
    Size deviceSize = MediaQuery.sizeOf(context);
    bool isScrollable = true;
    bool showNextIcon = true;
    bool showBackIcon = true;

    void filter({required int index, required String notificationType}) {
      debounce.run(() async {
        await readNotificationProvider.filter(
            tab: index, notificationType: notificationType);
      });
    }

    return SizedBox(
      width: double.minPositive,
      height: deviceSize.height * .34,
      child: DynamicTabBarWidget(
        dynamicTabs: tabs.mapIndexed((tab, index) {
          return TabData(
              index: index,
              title: Tab(
                  child: Column(
                children: [Icon(tab.icon), Text(tab.label.tr())],
              )),
              content: NotificationContentWidget(notificationType: tab.value));
        }).toList(),
        isScrollable: isScrollable,
        padding: EdgeInsets.zero,
        onTabControllerUpdated: (controller) {
          controller.index = readNotificationProvider.selectedTab;
          // run when user swipe
          controller.addListener(() {
            final String notificationType = tabs[controller.index].value;
            filter(index: controller.index, notificationType: notificationType);
          });
        },
        onTabChanged: (index) {
          if (index != null) {
            String notificationType = tabs[index].value;
            filter(index: index, notificationType: notificationType);
          }
        },
        showBackIcon: showBackIcon,
        showNextIcon: showNextIcon,
      ),
    );
  }
}
