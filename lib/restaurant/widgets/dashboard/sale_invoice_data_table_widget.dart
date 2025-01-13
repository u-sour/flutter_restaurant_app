import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../utils/alert/awesome_snack_bar_utils.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive/responsive_layout.dart';
import '../../models/sale/invoice/sale_invoice_data_model.dart';
import '../../models/sale/invoice/sale_invoice_model.dart';
import '../../providers/dashboard/dashboard_provider.dart';
import '../../providers/sale/sale_provider.dart';
import '../../services/data-table-sources/sale_invoice_dt_source.dart';
import '../../services/user_service.dart';
import '../../utils/constants.dart';
import '../../utils/dashboard/dashboard_utils.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/loading_widget.dart';

class SaleInvoiceDataTableWidget extends StatelessWidget {
  const SaleInvoiceDataTableWidget({super.key});
  final prefix = 'screens.dashboard.saleInvoiceContent.dataTable';
  final double dataPagerHeight = 60.0;
  @override
  Widget build(BuildContext context) {
    DashboardProvider readDashboardProvider = context.read<DashboardProvider>();
    return Selector<DashboardProvider, SaleInvoiceModel>(
        selector: (context, state) => state.saleInvoice,
        builder: (context, saleInvoice, child) {
          final dtSource =
              SaleInvoiceDTSource(sales: saleInvoice.data, context: context);
          if (saleInvoice.data.isNotEmpty) {
            return LayoutBuilder(builder: (context, constraints) {
              return Column(children: [
                SizedBox(
                  height: constraints.maxHeight - dataPagerHeight,
                  width: constraints.maxWidth,
                  child: SaleInvoiceDataTableBuildDataGridWidget(
                    source: dtSource,
                    readDashboardProvider: readDashboardProvider,
                    constraints: constraints,
                  ),
                ),
                SizedBox(
                    height: dataPagerHeight,
                    child: SfDataPager(
                      pageCount: (saleInvoice.totalRecords /
                              readDashboardProvider.pageSize)
                          .ceil()
                          .toDouble(),
                      direction: Axis.horizontal,
                      onPageNavigationStart: (int pageIndex) async {
                        await readDashboardProvider.pageNavigationChange(
                            page: pageIndex);
                      },
                      delegate: dtSource,
                      onPageNavigationEnd: (int pageIndex) async {
                        await readDashboardProvider.pageNavigationChange(
                            page: pageIndex);
                      },
                    ))
              ]);
            });
          } else {
            return const EmptyDataWidget();
          }
        });
  }
}

// build data grid and show loading widget when user filter
class SaleInvoiceDataTableBuildDataGridWidget extends StatelessWidget {
  const SaleInvoiceDataTableBuildDataGridWidget({
    super.key,
    required this.source,
    required this.readDashboardProvider,
    required this.constraints,
  });

  final SaleInvoiceDTSource source;
  final DashboardProvider readDashboardProvider;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    SaleProvider readSaleProvider = context.read<SaleProvider>();
    DashboardProvider readDashboardProvider = context.read<DashboardProvider>();
    List<GridColumn> buildGridColumns() {
      List<GridColumn> columns = [];
      for (var i = 0; i < SaleInvoiceDTRowType.values.length; i++) {
        SaleInvoiceDTRowType field = SaleInvoiceDTRowType.values[i];
        columns.add(
          GridColumn(
            columnName: field.name,
            label: Container(
              alignment: Alignment.center,
              child: Text(
                field.toTitle.tr(),
                style: theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        );
      }
      return columns;
    }

    return Stack(
      children: [
        SfDataGrid(
          source: source,
          columnWidthMode: ResponsiveLayout.isMobile(context)
              ? ColumnWidthMode.none
              : ColumnWidthMode.fill,
          rowHeight: 80.0,
          columns: buildGridColumns(),
          rowsPerPage: readDashboardProvider.pageSize,
          allowSwiping: true,
          onSwipeStart: (details) {
            // check enable swipe action end only
            if (details.swipeDirection ==
                DataGridRowSwipeDirection.startToEnd) {
              return false;
            } else if (details.swipeDirection ==
                DataGridRowSwipeDirection.endToStart) {
              details.setSwipeMaxOffset(250.0);
            }
            return true;
          },
          endSwipeActionsBuilder:
              (BuildContext context, DataGridRow row, int rowIndex) {
            SaleInvoiceDataModel saleInvoice = row.getCells().first.value;
            return Row(
              children: [
                // Print
                SfDataGridSwipeActionButton(
                    icon: RestaurantDefaultIcons.print,
                    bgColor: AppThemeColors.info,
                    onPressed: () async {
                      await readDashboardProvider.printInvoice(
                          saleInvoice: saleInvoice, context: context);
                    }),
                // Payment
                if (saleInvoice.status == 'Partial' &&
                    UserService.userInRole(roles: ['cashier']))
                  SfDataGridSwipeActionButton(
                    icon: RestaurantDefaultIcons.payment,
                    bgColor: AppThemeColors.success,
                    onPressed: () async {
                      final result = await readSaleProvider.payment(
                          context: context,
                          invoiceId: saleInvoice.id,
                          makeRepaid: true,
                          fromDashboard: true);
                      // reload sale invoice on dashboard if payment success
                      if (result != null &&
                          result.type == AWESOMESNACKBARTYPE.success &&
                          result.data.isNotEmpty) {
                        await readDashboardProvider.filter(
                            tab: readDashboardProvider.selectedTab,
                            filterText: readDashboardProvider.filterText);
                      }
                    },
                  ),
                // Edit
                if ((saleInvoice.status == 'Partial' ||
                        saleInvoice.status == 'Closed') &&
                    '${saleInvoice.receiptId}'.isNotEmpty &&
                    '${saleInvoice.receiptId}' != 'false')
                  SfDataGridSwipeActionButton(
                    icon: RestaurantDefaultIcons.edit,
                    bgColor: AppThemeColors.warning,
                    onPressed: () async {
                      await readDashboardProvider.editSaleReceipt(
                          receiptId: '${saleInvoice.receiptId}',
                          context: context);
                    },
                  ),
                // Remove
                // SfDataGridSwipeActionButton(
                //   icon: RestaurantDefaultIcons.remove,
                //   bgColor: AppThemeColors.failure,
                //   onPressed: () => GlobalService.openDialog(
                //       context: context,
                //       contentWidget: ConfirmDialogWidget(
                //         content: Row(
                //           children: [
                //             Text(saleInvoice.refNo,
                //                 style: theme.textTheme.bodyMedium!
                //                     .copyWith(fontWeight: FontWeight.bold)),
                //             Text(
                //               'dialog.confirm.remove.description'.tr(),
                //               style: theme.textTheme.bodyMedium,
                //             ),
                //           ],
                //         ),
                //         onAgreePressed: () async {
                //           ResponseModel? result = await readDashboardProvider
                //               .removeSale(id: saleInvoice.id);
                //           if (result != null) {
                //             // reload sale invoice on dashboard if remove success
                //             if (result.type.name == 'success') {
                //               await readDashboardProvider.filter(
                //                   tab: readDashboardProvider.selectedTab,
                //                   filterText: readDashboardProvider.filterText);
                //             }
                //             late SnackBar snackBar;
                //             snackBar = Alert.awesomeSnackBar(
                //                 message: result.message, type: result.type);
                //             if (!context.mounted) return;
                //             ScaffoldMessenger.of(context)
                //               ..hideCurrentSnackBar()
                //               ..showSnackBar(snackBar);
                //           }
                //           if (context.mounted) {
                //             context.pop();
                //           }
                //         },
                //       )),
                // ),
              ],
            );
          },
        ),
        Selector<DashboardProvider, bool>(
          selector: (context, state) => state.isFiltering,
          builder: (context, isFiltering, child) {
            return isFiltering
                ? Container(
                    color: theme.colorScheme.onPrimary.withOpacity(.8),
                    child: const LoadingWidget())
                : const SizedBox.shrink();
          },
        )
      ],
    );
  }
}

// swipe actions
class SfDataGridSwipeActionButton extends StatelessWidget {
  final IconData icon;
  final Color? bgColor;
  final void Function()? onPressed;
  const SfDataGridSwipeActionButton(
      {super.key, required this.icon, this.bgColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: SizedBox(
        height: double.infinity,
        child: FilledButton(
            onPressed: onPressed,
            style: theme.filledButtonTheme.style!.copyWith(
                backgroundColor: WidgetStatePropertyAll(bgColor),
                shape: const WidgetStatePropertyAll(
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                padding: const WidgetStatePropertyAll(EdgeInsets.zero)),
            child: Icon(icon)),
      ),
    );
  }
}
