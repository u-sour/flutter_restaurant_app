import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/models/select-option/select_option_model.dart';
import 'package:flutter_template/restaurant/utils/map_index.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_provider.dart';
import '../../providers/dashboard/dashboard_provider.dart';
import '../loading_widget.dart';
import 'sale_invoice_content_widget.dart';

class SaleInvoiceWidget extends StatelessWidget {
  const SaleInvoiceWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    DashboardProvider readDashboardProvider = context.read<DashboardProvider>();
    String branchId = context
        .select<AppProvider, String>((ap) => ap.selectedBranch?.id ?? '');
    String depId = context
        .select<AppProvider, String>((ap) => ap.selectedDepartment?.id ?? '');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      readDashboardProvider.initData(branchId: branchId, depId: depId);
    });
    const String prefixSaleInvoiceTab = 'screens.dashboard.saleInvoiceTabs';
    bool isScrollable = true;
    bool showNextIcon = true;
    bool showBackIcon = true;

    const List<SelectOptionModel> tabs = [
      SelectOptionModel(
          label: "$prefixSaleInvoiceTab.printed",
          value: SaleInvoiceContentWidget()),
      SelectOptionModel(
          label: "$prefixSaleInvoiceTab.open",
          value: SaleInvoiceContentWidget()),
      SelectOptionModel(
          label: "$prefixSaleInvoiceTab.partial",
          value:
              SaleInvoiceContentWidget(type: SaleInvoiceContentType.dataTable)),
      SelectOptionModel(
          label: "$prefixSaleInvoiceTab.closed",
          value:
              SaleInvoiceContentWidget(type: SaleInvoiceContentType.dataTable)),
      SelectOptionModel(
          label: "$prefixSaleInvoiceTab.canceled",
          value:
              SaleInvoiceContentWidget(type: SaleInvoiceContentType.dataTable))
    ];

    return Selector<DashboardProvider, bool>(
      selector: (context, state) => state.isLoading,
      builder: (context, isLoading, child) => isLoading
          ? const LoadingWidget()
          : DynamicTabBarWidget(
              dynamicTabs: tabs.mapIndexed((tab, index) {
                return TabData(
                    index: index,
                    title: Tab(
                        child: Text(tab.label, style: theme.textTheme.bodyLarge)
                            .tr()),
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
