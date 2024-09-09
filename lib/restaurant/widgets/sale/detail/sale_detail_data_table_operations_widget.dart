import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_template/utils/responsive/responsive_layout.dart';
import 'package:provider/provider.dart';
import '../../../../services/global_service.dart';
import '../../../../utils/constants.dart';
import '../../../models/data-table/data_table_column_model.dart';
import '../../../models/sale/detail/sale_detail_model.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/sale/sale_utils.dart';
import '../../empty_data_widget.dart';
import '../../format_currency_widget.dart';
import 'edit_sale_detail_operations_data_table_row_widget.dart';
import 'extra-items/sale_detail_extra_items_widget.dart';

class SaleDetailDataTableOperationsWidget extends StatelessWidget {
  const SaleDetailDataTableOperationsWidget({super.key});
  static final GlobalKey<FormBuilderState> _fbEditRowKey =
      GlobalKey<FormBuilderState>();
  final prefixDataTableOperationsHeader =
      "screens.sale.detail.operations.dataTable.header";
  final prefixDataTableOperationsContent =
      "screens.sale.detail.operations.dataTable.content";
  final double actionsWidth = 45.0;
  final double minWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    final readProvider = context.read<SaleProvider>();
    final theme = Theme.of(context);
    final double rowHeight = ResponsiveLayout.isMobile(context) ? 160.0 : 115.0;
    final double priceFontSize =
        ResponsiveLayout.isMobile(context) ? 12.0 : 14.0;
    final double baseCurrencyFontSize =
        ResponsiveLayout.isMobile(context) ? 14 : 18.0;
    List<DataTableColumnModel> columns = [
      DataTableColumnModel(
          label: "$prefixDataTableOperationsHeader.no",
          value: "no",
          alignment: Alignment.centerLeft,
          width: 26.0),
      DataTableColumnModel(
          label: "$prefixDataTableOperationsHeader.itemName",
          value: "itemName",
          alignment: Alignment.centerLeft),
      DataTableColumnModel(
          label: "$prefixDataTableOperationsHeader.qty",
          value: "qty",
          width: 36.0),
      DataTableColumnModel(
        label: "$prefixDataTableOperationsHeader.amount",
        value: "amount",
        alignment: Alignment.centerRight,
      ),
    ];
    return Selector<SaleProvider, List<SaleDetailModel>>(
        selector: (context, state) => state.selectedSaleDetailsForOperation,
        builder: (context, selectedSaleDetailsForOperation, child) {
          return DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: minWidth,
            headingTextStyle: theme.textTheme.bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
            empty: const EmptyDataWidget(),
            columns: [
              for (DataTableColumnModel column in columns)
                DataColumn2(
                  fixedWidth: column.width,
                  label: Align(
                    alignment: column.alignment,
                    child: Text(
                      column.label,
                      overflow: TextOverflow.ellipsis,
                    ).tr(),
                  ),
                ),
              DataColumn2(
                  fixedWidth: actionsWidth,
                  label:
                      const Center(child: Icon(RestaurantDefaultIcons.actions)))
            ],
            rows: List<DataRow>.generate(selectedSaleDetailsForOperation.length,
                (index) {
              num no = 1 + index;
              SaleDetailModel row = selectedSaleDetailsForOperation[index];
              return DataRow2(specificRowHeight: rowHeight, cells: [
                // No
                DataCell(Center(child: Text('$no'))),
                DataCell(Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Item
                    Text(
                      row.itemName,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    // Extra Items
                    if (row.extraItemDoc.isNotEmpty)
                      InkWell(
                        onTap: () => GlobalService.openDialog(
                            contentWidget: SaleDetailExtraItemsWidget(
                              extraItems: row.extraItemDoc,
                            ),
                            context: context),
                        child: Text(
                            '${'screens.sale.category.extraFoods'.tr()} (${row.extraItemDoc.length})',
                            style: theme.textTheme.bodyMedium),
                      ),
                    // Price
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FormatCurrencyWidget(
                        value: row.price,
                        color: AppThemeColors.primary,
                        priceFontSize: 14.0,
                        currencySymbolFontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    // Discount Rate
                    RichText(
                      text: TextSpan(
                        style: theme.textTheme.bodyMedium,
                        text: '$prefixDataTableOperationsContent.discountRate'
                            .tr(),
                        children: [
                          TextSpan(
                              text: ' ${row.discount} %',
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: AppThemeColors.primary))
                        ],
                      ),
                    )
                  ],
                )),
                // Qty
                DataCell(
                    onTap: () => GlobalService.openDialog(
                        contentWidget:
                            EditSaleDetailOperationsDataTableRowWidget(
                                fbEditRowKey: _fbEditRowKey,
                                index: index,
                                rowType: SaleDetailDTRowType.qty,
                                item: row),
                        context: context),
                    Center(child: Text('${row.totalQty}'))),
                // Amount
                DataCell(
                  Align(
                    alignment: Alignment.centerRight,
                    child: FormatCurrencyWidget(
                      value: readProvider.getItemAmount(item: row),
                      priceFontSize: priceFontSize,
                      currencySymbolFontSize: baseCurrencyFontSize,
                      color: AppThemeColors.primary,
                    ),
                  ),
                ),
                // Remove Action
                DataCell(Center(
                  child: IconButton(
                      onPressed: selectedSaleDetailsForOperation.length <= 1
                          ? null
                          : () {
                              readProvider
                                  .removeSelectedSaleDetailsForOperation(
                                      id: row.id);
                            },
                      icon: Icon(RestaurantDefaultIcons.removeSelectedItem,
                          color: row.checkPrint ||
                                  selectedSaleDetailsForOperation.length <= 1
                              ? theme.highlightColor
                              : AppThemeColors.failure)),
                )),
              ]);
            }),
          );
        });
  }
}
