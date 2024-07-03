import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/widgets/sale-table/sale_table_widget.dart';
import '../../router/route_utils.dart';
import '../../widgets/app_bar_widget.dart';

class SaleTableScreen extends StatefulWidget {
  const SaleTableScreen({super.key});

  @override
  State<SaleTableScreen> createState() => _SaleTableScreenState();
}

class _SaleTableScreenState extends State<SaleTableScreen> {
  bool isScrollable = true;
  bool showNextIcon = true;
  bool showBackIcon = true;

  List<TabData> tabs = [
    TabData(
      index: 1,
      title: const Tab(
        child: Text('Tab 1'),
      ),
      content: const SaleTableWidget(),
    ),
    TabData(
      index: 2,
      title: const Tab(
        child: Text('Tab 2'),
      ),
      content: const Center(child: Text('Content for Tab 2')),
    ),
    TabData(
      index: 3,
      title: const Tab(
        child: Text('Tab 3'),
      ),
      content: const Center(child: Text('Content for Tab 3')),
    ),
    // Add more tabs as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(title: SCREENS.saleTable.toTitle),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: DynamicTabBarWidget(
                  dynamicTabs: tabs,
                  isScrollable: isScrollable,
                  onTabControllerUpdated: (controller) {},
                  onTabChanged: (index) {},
                  showBackIcon: showBackIcon,
                  showNextIcon: showNextIcon,
                ),
              ),
            ],
          ),
        ));
  }
}
