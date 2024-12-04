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
  final bool isScrollable = true;
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
    final theme = Theme.of(context);
    List<SelectOptionModel> tabs = readNotificationProvider.notificationTabs;
    Size deviceSize = MediaQuery.sizeOf(context);
    return SizedBox(
      width: double.minPositive,
      height: deviceSize.height * .4,
      child: DefaultTabController(
        length: tabs.length,
        child: Builder(builder: (context) {
          final TabController controller = DefaultTabController.of(context);
          controller.addListener(() {
            if (!controller.indexIsChanging) {
              final String notificationType = tabs[controller.index].value;
              filter(
                  index: controller.index, notificationType: notificationType);
            }
          });
          return Column(
            children: <Widget>[
              TabBar(
                isScrollable: isScrollable,
                labelStyle: theme.textTheme.bodySmall,
                tabs: tabs.mapIndexed((tab, index) {
                  return Tab(icon: Icon(tab.icon), text: tab.label.tr());
                }).toList(),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: tabs.mapIndexed((tab, index) {
                    return NotificationContentWidget(
                        notificationType: tab.value);
                  }).toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
