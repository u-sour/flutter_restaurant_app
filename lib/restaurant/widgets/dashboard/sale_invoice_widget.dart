import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/app_provider.dart';
import '../../providers/dashboard/dashboard_provider.dart';
import 'sale_invoice_content_widget.dart';

class SaleInvoiceWidget extends StatelessWidget {
  const SaleInvoiceWidget({super.key});
  @override
  Widget build(BuildContext context) {
    AppProvider readAppProvider = context.read<AppProvider>();
    DashboardProvider readDashboardProvider = context.read<DashboardProvider>();
    String branchId = context
        .select<AppProvider, String>((ap) => ap.selectedBranch?.id ?? '');
    String depId = context
        .select<AppProvider, String>((ap) => ap.selectedDepartment?.id ?? '');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      readDashboardProvider.getSaleForDataTable(
          tab: readDashboardProvider.selectedTab,
          branchId: branchId,
          depId: depId);
    });

    String prefixSaleInvoiceTab = 'screens.dashboard.saleInvoiceTabs';
    bool isScrollable = true;
    bool showNextIcon = true;
    bool showBackIcon = true;

    List<TabData> tabs = [
      TabData(
        index: 0,
        title: Tab(
          child: Text(context.tr("$prefixSaleInvoiceTab.printed")),
        ),
        content: const SaleInvoiceContentWidget(),
      ),
      TabData(
        index: 1,
        title: Tab(
          child: Text(context.tr("$prefixSaleInvoiceTab.open")),
        ),
        content: const SaleInvoiceContentWidget(),
      ),
      TabData(
        index: 2,
        title: Tab(
          child: Text(context.tr("$prefixSaleInvoiceTab.partial")),
        ),
        content: const SaleInvoiceContentWidget(
            type: SaleInvoiceContentType.dataTable),
      ),
      TabData(
        index: 3,
        title: Tab(
          child: Text(context.tr("$prefixSaleInvoiceTab.closed")),
        ),
        content: const SaleInvoiceContentWidget(
            type: SaleInvoiceContentType.dataTable),
      ),
      TabData(
        index: 4,
        title: Tab(
          child: Text(context.tr("$prefixSaleInvoiceTab.canceled")),
        ),
        content: const SaleInvoiceContentWidget(
            type: SaleInvoiceContentType.dataTable),
      ),
      // Add more tabs as needed
    ];
    return DynamicTabBarWidget(
      dynamicTabs: tabs,
      isScrollable: isScrollable,
      onTabControllerUpdated: (controller) {
        controller.index = readDashboardProvider.selectedTab;
      },
      onTabChanged: (index) {
        final String branchId = readAppProvider.selectedBranch?.id ?? '';
        final String depId = readAppProvider.selectedDepartment?.id ?? '';
        readDashboardProvider.getSaleForDataTable(
            tab: index!, branchId: branchId, depId: depId);
      },
      showBackIcon: showBackIcon,
      showNextIcon: showNextIcon,
    );
  }
}
