import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../../../../services/global_service.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../models/data-table/data_table_column_model.dart';
import '../../../models/sale/detail/sale_detail_model.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/sale/sale_utils.dart';
import '../../format_currency_widget.dart';
import 'edit_sale_detail_operations_data_table_row_widget.dart';

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
    final double priceFontSize =
        ResponsiveLayout.isMobile(context) ? 12.0 : 14.0;
    final double baseCurrencyFontSize =
        ResponsiveLayout.isMobile(context) ? 14 : 18.0;
    List<DataTableColumnModel> columns = [
      DataTableColumnModel(
          label: "$prefixDataTableOperationsHeader.no",
          value: "no",
          headingRowAlignment: MainAxisAlignment.start,
          width: 26.0),
      DataTableColumnModel(
          label: "$prefixDataTableOperationsHeader.itemName",
          value: "itemName",
          headingRowAlignment: MainAxisAlignment.start),
      DataTableColumnModel(
          label: "$prefixDataTableOperationsHeader.qty",
          value: "qty",
          width: 36.0),
      DataTableColumnModel(
        label: "$prefixDataTableOperationsHeader.amount",
        value: "amount",
        headingRowAlignment: MainAxisAlignment.end,
      ),
    ];
    return Selector<SaleProvider, List<SaleDetailModel>>(
        selector: (context, state) => state.selectedSaleDetailsForOperation,
        builder: (context, selectedSaleDetailsForOperation, child) {
          return SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: DataTable(
                dataRowMaxHeight: double.infinity,
                // horizontalMargin: 12,
                // minWidth: minWidth,
                headingTextStyle: theme.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
                // empty: const EmptyDataWidget(),
                columns: [
                  for (DataTableColumnModel column in columns)
                    DataColumn(
                      headingRowAlignment: column.headingRowAlignment,
                      label: Text(
                        column.label,
                        overflow: TextOverflow.ellipsis,
                      ).tr(),
                    ),
                  const DataColumn(
                      headingRowAlignment: MainAxisAlignment.center,
                      label: Icon(RestaurantDefaultIcons.actions))
                ],
                rows: List<DataRow>.generate(
                    selectedSaleDetailsForOperation.length, (index) {
                  num no = 1 + index;
                  SaleDetailModel row = selectedSaleDetailsForOperation[index];
                  return DataRow(cells: [
                    // No
                    DataCell(Text('$no')),
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
                        // Variants
                        if (row.variantName != null)
                          Text(' - ${row.variantName}'),
                        // Catalog Combo Items
                        if (row.catalogType != null &&
                            row.comboDoc.isNotEmpty &&
                            row.catalogType == "Combo")
                          for (int i = 0; i < row.comboDoc.length; i++)
                            RichText(
                                text: TextSpan(
                                    text: ' - ${row.comboDoc[i].itemName} x ',
                                    style: theme.textTheme.bodySmall,
                                    children: [
                                  TextSpan(
                                      text: '${row.comboDoc[i].qty}',
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(
                                              color: AppThemeColors.failure,
                                              fontWeight: FontWeight.bold))
                                ])),
                        // Extra Items
                        if (row.extraItemDoc.isNotEmpty)
                          for (int i = 0; i < row.extraItemDoc.length; i++)
                            RichText(
                                text: TextSpan(
                                    text:
                                        ' + ${row.extraItemDoc[i].itemName} | ',
                                    style: theme.textTheme.bodySmall,
                                    children: [
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.baseline,
                                      baseline: TextBaseline.alphabetic,
                                      child: FormatCurrencyWidget(
                                          value: row.extraItemDoc[i].amount,
                                          priceFontSize: 12.0,
                                          currencySymbolFontSize: 14.0,
                                          color: AppThemeColors.primary))
                                ])),
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
                            text:
                                '$prefixDataTableOperationsContent.discountRate'
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
                                      selectedSaleDetailsForOperation.length <=
                                          1
                                  ? theme.highlightColor
                                  : AppThemeColors.failure)),
                    )),
                  ]);
                }),
              ),
            ),
          );
        });
  }
}
