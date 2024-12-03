import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../models/servers/response_model.dart';
import '../../../../services/global_service.dart';
import '../../../../utils/alert/alert.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive/responsive_layout.dart';
import '../../../../widgets/confirm_dialog_widget.dart';
import '../../../models/data-table/data_table_column_model.dart';
import '../../../models/sale/detail/sale_detail_model.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../services/sale_service.dart';
import '../../../services/user_service.dart';
import '../../../utils/constants.dart';
import '../../../utils/sale/sale_utils.dart';
import '../../../../widgets/empty_data_widget.dart';
import '../../format_currency_widget.dart';
import 'combo-items/sale_detail_combo_items_widget.dart';
import 'edit_sale_detail_data_table_row_widget.dart';
import 'extra-items/sale_detail_extra_items_widget.dart';

class SaleDetailDataTableWidget extends StatelessWidget {
  const SaleDetailDataTableWidget({super.key});
  static final GlobalKey<FormBuilderState> _fbEditRowKey =
      GlobalKey<FormBuilderState>();
  final prefixDataTableHeader = "screens.sale.detail.dataTable.header";
  final prefixDataTableContent = "screens.sale.detail.dataTable.content";
  final double minWidth = 0.0;
  @override
  Widget build(BuildContext context) {
    final double qtyWidth = ResponsiveLayout.isMobile(context) ? 40.0 : 50;
    final double returnQtyWidth =
        ResponsiveLayout.isMobile(context) ? 58.5 : 68;
    final double actionsWidth = ResponsiveLayout.isMobile(context) ? 30.0 : 45;
    final readProvider = context.read<SaleProvider>();
    final theme = Theme.of(context);
    final double rowHeight = ResponsiveLayout.isMobile(context) ? 160.0 : 120.0;
    List<DataTableColumnModel> columns = [
      DataTableColumnModel(
          label: "$prefixDataTableHeader.item",
          value: "item",
          alignment: Alignment.centerLeft),
      DataTableColumnModel(
          label: "$prefixDataTableHeader.qty", value: "qty", width: qtyWidth),
      DataTableColumnModel(
        label: "$prefixDataTableHeader.total",
        value: "total",
        alignment: Alignment.centerRight,
      ),
    ];
    // Note: ReturnQty បង្ហាញពេលមាន module soup & user role != tablet-orders
    bool allowReturnQty =
        SaleService.isModuleActive(modules: ['soup'], context: context) &&
            !UserService.userInRole(roles: ['tablet-orders']);
    if (allowReturnQty) {
      columns.insert(
          2,
          DataTableColumnModel(
              label: "$prefixDataTableHeader.returnQty",
              value: "returnQty",
              width: returnQtyWidth));
    }

    return Consumer<SaleProvider>(builder: (context, state, child) {
      return Theme(
        data: theme.copyWith(
            dividerTheme: DividerThemeData(color: theme.focusColor)),
        child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: minWidth,
          headingTextStyle:
              theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
          empty: const EmptyDataWidget(),
          onSelectAll: (_) {
            readProvider.selectAllRows(!state.isSelectedAllRows);
          },
          headingCheckboxTheme: theme.checkboxTheme,
          datarowCheckboxTheme: theme.checkboxTheme,
          columns: [
            for (DataTableColumnModel column in columns)
              DataColumn2(
                fixedWidth: column.width,
                label: Align(
                  alignment: column.alignment,
                  child: Text(
                    column.label,
                    overflow: TextOverflow.ellipsis,
                  ).tr(namedArgs: {"totalItem": '${state.saleDetails.length}'}),
                ),
              ),
            DataColumn2(
                fixedWidth: actionsWidth,
                label:
                    const Center(child: Icon(RestaurantDefaultIcons.actions)))
          ],
          rows: List<DataRow>.generate(state.saleDetails.length, (index) {
            SaleDetailModel previousRow =
                readProvider.previousSaleDetails[index];
            SaleDetailModel row = state.saleDetails[index];
            // Note: qty, discount rate, note មិនអាចកែបាន បើសិន print bill រួច || user role == tablet-orders ហើយ item មិនមែន draft
            bool disableItemRow = row.checkPrint ||
                (UserService.userInRole(roles: ['tablet-orders']) &&
                    (row.draft == null || row.draft == false));
            return DataRow2(
              selected: state.selectedSaleDetails.contains(row),
              onSelectChanged: disableItemRow
                  ? null
                  : (isSelectedRow) {
                      readProvider.selectRow(isSelectedRow ?? false, row);
                    },
              color: WidgetStateProperty.all(
                  disableItemRow ? theme.highlightColor : null),
              specificRowHeight: rowHeight,
              cells: [
                DataCell(Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Item
                    Text(
                      row.itemName,
                      style: ResponsiveLayout.isMobile(context)
                          ? theme.textTheme.bodySmall!
                              .copyWith(fontWeight: FontWeight.bold)
                          : theme.textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                    ),
                    // Extra items
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
                    // Price & Discount
                    RichText(
                      text: TextSpan(
                        style: theme.textTheme.bodyMedium,
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.baseline,
                            baseline: TextBaseline.alphabetic,
                            child: InkWell(
                                onTap: disableItemRow
                                    ? null
                                    : () => GlobalService.openDialog(
                                                contentWidget:
                                                    EditSaleDetailDataTableRowWidget(
                                                  fbEditRowKey:
                                                      SaleDetailDataTableWidget
                                                          ._fbEditRowKey,
                                                  rowType:
                                                      SaleDetailDTRowType.price,
                                                  item: row,
                                                  onInsertPressed: () =>
                                                      readProvider
                                                          .updateSaleDetailItem(
                                                              item: row,
                                                              context: context),
                                                ),
                                                context: context)
                                            .then((_) {
                                          // Note: reset field value to previous value if user close dialog or press on cancel button
                                          readProvider.handleItemUpdate(
                                              onChangedValue:
                                                  '${previousRow.price}',
                                              item: row,
                                              rowType:
                                                  SaleDetailDTRowType.price);
                                        }),
                                child: FormatCurrencyWidget(
                                  value: row.price,
                                  color: AppThemeColors.primary,
                                  priceFontSize: 14.0,
                                  currencySymbolFontSize: 18.0,
                                  fontWeight: FontWeight.normal,
                                )),
                          ),
                          const TextSpan(text: ' | '),
                          WidgetSpan(
                            child: InkWell(
                              onTap: disableItemRow
                                  ? null
                                  : () => GlobalService.openDialog(
                                              contentWidget:
                                                  EditSaleDetailDataTableRowWidget(
                                                      fbEditRowKey:
                                                          SaleDetailDataTableWidget
                                                              ._fbEditRowKey,
                                                      rowType:
                                                          SaleDetailDTRowType
                                                              .discountRate,
                                                      item: row,
                                                      onInsertPressed: () =>
                                                          readProvider
                                                              .updateSaleDetailItem(
                                                                  item: row,
                                                                  context:
                                                                      context)),
                                              context: context)
                                          .then((_) {
                                        // Note: reset field value to previous value if user close dialog or press on cancel button
                                        readProvider.handleItemUpdate(
                                            onChangedValue:
                                                '${previousRow.discount}',
                                            item: row,
                                            rowType: SaleDetailDTRowType
                                                .discountRate);
                                      }),
                              child: RichText(
                                text: TextSpan(
                                    style: theme.textTheme.bodyMedium,
                                    text: '$prefixDataTableContent.discountRate'
                                        .tr(),
                                    children: [
                                      TextSpan(
                                          text: ' ${row.discount} %',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                  color:
                                                      AppThemeColors.primary))
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Note
                    InkWell(
                      onTap: disableItemRow
                          ? null
                          : () => GlobalService.openDialog(
                                contentWidget: EditSaleDetailDataTableRowWidget(
                                  fbEditRowKey:
                                      SaleDetailDataTableWidget._fbEditRowKey,
                                  rowType: SaleDetailDTRowType.note,
                                  item: row,
                                  onInsertPressed: () {
                                    if (row.note != null) {
                                      readProvider.updateSaleDetailItemNote(
                                          id: row.id,
                                          note: row.note!,
                                          context: context);
                                    }
                                  },
                                ),
                                context: context,
                              ).then((_) {
                                // Note: reset field value to previous value if user close dialog or press on cancel button
                                readProvider.handleItemUpdate(
                                    onChangedValue: previousRow.note != null
                                        ? previousRow.note!
                                        : '',
                                    item: row,
                                    rowType: SaleDetailDTRowType.note);
                              }),
                      child: Row(
                        children: [
                          row.checkPrintKitchen != null &&
                                  row.checkPrintKitchen == true
                              ? const Icon(RestaurantDefaultIcons.chef,
                                  color: AppThemeColors.primary)
                              : const Icon(RestaurantDefaultIcons.editNote),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              row.note != null && row.note != ''
                                  ? row.note!
                                  : '$prefixDataTableContent.note'.tr(),
                              style: ResponsiveLayout.isMobile(context)
                                  ? theme.textTheme.bodySmall
                                  : null,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
                // Qty
                // Note: Item qty មិនអាចកែបានពេល print bill រួច || print ទៅ kitchen រួច || user role == tablet-orders ហើយ item មិនមែន draft || item status == Done
                DataCell(
                    onTap: row.checkPrint ||
                            (row.checkPrintKitchen != null &&
                                row.checkPrintKitchen == true) ||
                            (UserService.userInRole(roles: ['tablet-orders']) &&
                                (row.draft == null || row.draft == false)) ||
                            row.status == 'Done'
                        ? null
                        : () => GlobalService.openDialog(
                                    contentWidget:
                                        EditSaleDetailDataTableRowWidget(
                                      fbEditRowKey: SaleDetailDataTableWidget
                                          ._fbEditRowKey,
                                      rowType: SaleDetailDTRowType.qty,
                                      item: row,
                                      onInsertPressed: () =>
                                          readProvider.updateSaleDetailItem(
                                              item: row, context: context),
                                    ),
                                    context: context)
                                .then(
                              (_) {
                                // Note: reset field value to previous value if user close dialog or press on cancel button
                                readProvider.handleItemUpdate(
                                    onChangedValue: '${previousRow.totalQty}',
                                    item: row,
                                    rowType: SaleDetailDTRowType.qty);
                              },
                            ),
                    Center(child: Text('${row.totalQty}'))),
                // Return Qty
                // Note: បង្ហាញពេលមាន module soup & user role != tablet-orders
                if (allowReturnQty)
                  DataCell(
                      onTap: row.checkPrint ||
                              row.extraItemDoc.isNotEmpty ||
                              row.totalQty < 1 ||
                              row.checkPrintKitchen != null &&
                                  row.checkPrintKitchen == true
                          ? null
                          : () => GlobalService.openDialog(
                                      contentWidget:
                                          EditSaleDetailDataTableRowWidget(
                                        fbEditRowKey: SaleDetailDataTableWidget
                                            ._fbEditRowKey,
                                        rowType: SaleDetailDTRowType.returnQty,
                                        item: row,
                                        onInsertPressed: () =>
                                            readProvider.updateSaleDetailItem(
                                                item: row, context: context),
                                      ),
                                      context: context)
                                  .then((_) {
                                // Note: reset field value to previous value if user close dialog or press on cancel button
                                readProvider.handleItemUpdate(
                                    onChangedValue: '${previousRow.returnQty}',
                                    item: row,
                                    rowType: SaleDetailDTRowType.returnQty);
                              }),
                      Center(
                        child: Text('${row.returnQty}'),
                      )),
                // Total Amount
                DataCell(
                  Align(
                    alignment: Alignment.centerRight,
                    child: FormatCurrencyWidget(
                        value: readProvider.getItemAmount(item: row),
                        color: AppThemeColors.primary,
                        priceFontSize: 14.0,
                        currencySymbolFontSize: 18.0),
                  ),
                ),
                // Remove Action
                // Note: Item មិនអាចលុបបានពេល print bill រួច || user role == tablet-orders && item មិនមែន draft
                DataCell(Center(
                  child: IconButton(
                      onPressed: row.checkPrint ||
                              UserService.userInRole(
                                      roles: ['tablet-orders']) &&
                                  row.draft != true
                          ? null
                          : () => GlobalService.openDialog(
                                context: context,
                                contentWidget: ConfirmDialogWidget(
                                  content: Wrap(
                                    children: [
                                      Text(row.itemName,
                                          style: theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold)),
                                      Text(
                                        'dialog.confirm.remove.description'
                                            .tr(),
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                  onAgreePressed: () async {
                                    ResponseModel? result = await readProvider
                                        .removeItem(id: row.id);
                                    if (result != null) {
                                      late SnackBar snackBar;
                                      snackBar = Alert.awesomeSnackBar(
                                          message: result.message,
                                          type: result.type);
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(snackBar);
                                    }
                                    if (context.mounted) {
                                      context.pop();
                                    }
                                  },
                                ),
                              ),
                      style: IconButton.styleFrom(padding: EdgeInsets.zero),
                      icon: Icon(RestaurantDefaultIcons.remove,
                          color: row.checkPrint
                              ? theme.highlightColor
                              : AppThemeColors.failure)),
                )),
              ],
            );
          }),
        ),
      );
    });
  }
}
