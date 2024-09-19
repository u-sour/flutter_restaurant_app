import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../utils/constants.dart';
import '../../models/sale/invoice/sale_invoice_model.dart';
import '../../providers/dashboard/dashboard_provider.dart';
import '../../services/data-table-sources/sale_data_table_source.dart';
import '../../utils/constants.dart';
import '../../utils/dashboard/dashboard_utils.dart';
import '../empty_data_widget.dart';
import '../loading_widget.dart';

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
              SaleInvoiceDataSource(sales: saleInvoice.data, context: context);
          if (saleInvoice.data.isNotEmpty) {
            return LayoutBuilder(builder: (context, constraint) {
              return Column(children: [
                SizedBox(
                  height: constraint.maxHeight - dataPagerHeight,
                  width: constraint.maxWidth,
                  child: SaleInvoiceDataTableBuildDataGridWidget(
                    source: dtSource,
                    readDashboardProvider: readDashboardProvider,
                    constraints: constraint,
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

  final SaleInvoiceDataSource source;
  final DashboardProvider readDashboardProvider;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          columnWidthMode: ColumnWidthMode.fill,
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
            return Row(
              children: [
                // Print
                SfDataGridSwipeActionButton(
                  icon: RestaurantDefaultIcons.print,
                  bgColor: AppThemeColors.info,
                  onPressed: () {},
                ),
                // Payment
                SfDataGridSwipeActionButton(
                  icon: RestaurantDefaultIcons.payment,
                  bgColor: AppThemeColors.primary,
                  onPressed: () {},
                ),
                // Edit
                SfDataGridSwipeActionButton(
                  icon: RestaurantDefaultIcons.edit,
                  bgColor: AppThemeColors.warning,
                  onPressed: () {},
                ),
                // Remove
                SfDataGridSwipeActionButton(
                  icon: RestaurantDefaultIcons.remove,
                  bgColor: AppThemeColors.failure,
                  onPressed: () {},
                ),
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
