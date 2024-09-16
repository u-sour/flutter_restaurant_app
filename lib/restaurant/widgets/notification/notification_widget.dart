import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/utils/map_index.dart';
import 'package:provider/provider.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../providers/sale/notification_provider.dart';
import '../../utils/constants.dart';
import 'notification_content_widget.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationProvider readDashboardProvider =
        context.read<NotificationProvider>();
    Size deviceSize = MediaQuery.sizeOf(context);
    bool isScrollable = true;
    bool showNextIcon = true;
    bool showBackIcon = true;
    const List<SelectOptionModel> tabs = [
      SelectOptionModel(
          icon: RestaurantDefaultIcons.notificationInvoice,
          label: "",
          value: NotificationContentWidget()),
      SelectOptionModel(
          icon: RestaurantDefaultIcons.notificationFromKitchen,
          label: "",
          value: NotificationContentWidget()),
    ];
    return SizedBox(
      width: double.minPositive,
      height: deviceSize.height * .3,
      child: DynamicTabBarWidget(
        dynamicTabs: tabs.mapIndexed((tab, index) {
          return TabData(
              index: index,
              title: Tab(child: Icon(tab.icon)),
              content: tab.value);
        }).toList(),
        isScrollable: isScrollable,
        padding: EdgeInsets.zero,
        onTabControllerUpdated: (controller) {
          controller.index = readDashboardProvider.selectedTab;
        },
        onTabChanged: (index) {
          readDashboardProvider.filter(tab: index!);
        },
        showBackIcon: showBackIcon,
        showNextIcon: showNextIcon,
      ),
    );
  }
}
