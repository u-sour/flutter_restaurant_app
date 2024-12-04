import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/restaurant/utils/map_index.dart';
import 'package:provider/provider.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../../providers/app_provider.dart';
import '../../../utils/responsive/responsive_layout.dart';
import '../../providers/dashboard/dashboard_provider.dart';
import '../../providers/sale/notification_provider.dart';
import '../../../widgets/loading_widget.dart';
import 'sale_invoice_content_widget.dart';

class SaleInvoiceWidget extends StatelessWidget {
  const SaleInvoiceWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    NotificationProvider readNotificationProvider =
        context.read<NotificationProvider>();
    DashboardProvider readDashboardProvider = context.read<DashboardProvider>();
    String branchId = context
        .select<AppProvider, String>((ap) => ap.selectedBranch?.id ?? '');
    String depId = context
        .select<AppProvider, String>((ap) => ap.selectedDepartment?.id ?? '');
    // init data notification & dashboard
    WidgetsBinding.instance.addPostFrameCallback((_) {
      readNotificationProvider.initData(context: context);
      readDashboardProvider.initData(branchId: branchId, depId: depId);
    });
    const String prefixSaleInvoiceTab = 'screens.dashboard.saleInvoiceTabs';

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

    final bool isScrollable =
        ResponsiveLayout.isMobile(context) && tabs.length > 2 ? true : false;

    void tabChanged(int index) => readDashboardProvider.filter(tab: index);

    return Selector<DashboardProvider, bool>(
      selector: (context, state) => state.isLoading,
      builder: (context, isLoading, child) => isLoading
          ? const LoadingWidget()
          : DefaultTabController(
              length: tabs.length,
              child: Builder(builder: (context) {
                final TabController controller =
                    DefaultTabController.of(context);
                controller.addListener(() {
                  if (!controller.indexIsChanging) {
                    tabChanged(controller.index);
                  }
                });
                return Column(
                  children: <Widget>[
                    TabBar(
                      isScrollable: isScrollable,
                      labelStyle: theme.textTheme.bodyLarge,
                      tabs: tabs.mapIndexed((tab, index) {
                        return Tab(text: tab.label.tr());
                      }).toList(),
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: tabs.mapIndexed((tab, index) {
                          return tab.value as Widget;
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
