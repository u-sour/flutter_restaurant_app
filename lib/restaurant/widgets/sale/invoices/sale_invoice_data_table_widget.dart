import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../services/global_service.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../models/data-table/data_table_column_model.dart';
import '../../../models/sale/detail/sale_detail_model.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../format_currency_widget.dart';
import '../detail/combo-items/sale_detail_combo_items_widget.dart';
import '../detail/extra-items/sale_detail_extra_items_widget.dart';

class SaleInvoiceDataTableWidget extends StatelessWidget {
  final List<SaleDetailModel> saleDetails;
  const SaleInvoiceDataTableWidget({super.key, required this.saleDetails});
  final prefixDataTableHeader = "screens.sale.invoice.dataTable.header";
  final prefixDataTableContent = "screens.sale.invoice.dataTable.content";
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
          label: "$prefixDataTableHeader.item",
          value: "item",
          headingRowAlignment: MainAxisAlignment.start),
      DataTableColumnModel(
          label: "$prefixDataTableHeader.qty", value: "qty", width: 36.0),
      DataTableColumnModel(
          label: "$prefixDataTableHeader.amount",
          value: "amount",
          headingRowAlignment: MainAxisAlignment.end),
    ];
    return DataTable(
      headingTextStyle:
          theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
      columns: [
        for (DataTableColumnModel column in columns)
          DataColumn(
            headingRowAlignment: column.headingRowAlignment,
            label: Text(
              column.label,
              overflow: TextOverflow.ellipsis,
            ).tr(),
          ),
      ],
      rows: List<DataRow>.generate(saleDetails.length, (index) {
        SaleDetailModel row = saleDetails[index];
        return DataRow(
            color: WidgetStateProperty.all(
                row.draft == true ? null : theme.focusColor),
            cells: [
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
                  // Catalog Combo Items
                  if (row.catalogType != null &&
                      row.comboDoc.isNotEmpty &&
                      row.catalogType == "Combo")
                    InkWell(
                      onTap: () => GlobalService.openDialog(
                          contentWidget: SaleDetailComboItemsWidget(
                            comboItems: row.comboDoc,
                          ),
                          context: context),
                      child: Text(
                          '${'screens.sale.category.catalog'.tr()} (${row.comboDoc.length})',
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
                      text: '$prefixDataTableContent.discountRate'.tr(),
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
              DataCell(Center(child: Text('${row.totalQty}'))),
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
            ]);
      }),
    );
  }
}
