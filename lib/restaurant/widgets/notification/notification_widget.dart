import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/utils/map_index.dart';
import 'package:provider/provider.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../providers/sale/notification_provider.dart';
import 'notification_content_widget.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  late NotificationProvider readNotificationProvider;
  @override
  void initState() {
    super.initState();
    readNotificationProvider = context.read<NotificationProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await filter(
          index: readNotificationProvider.selectedTab,
          notificationType: readNotificationProvider.notificationType);
    });
  }

  Future<void> filter(
      {required int index, required String notificationType}) async {
    await readNotificationProvider.filter(
        tab: index, notificationType: notificationType);
  }

  @override
  Widget build(BuildContext context) {
    List<SelectOptionModel> tabs = readNotificationProvider.notificationTabs;
    Size deviceSize = MediaQuery.sizeOf(context);
    bool isScrollable = true;
    bool showNextIcon = true;
    bool showBackIcon = true;

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
