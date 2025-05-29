import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_template/widgets/loading_widget.dart';
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
import '../../format_currency_widget.dart';
import '../../scrollable_widget.dart';
import 'edit_sale_detail_data_table_row_widget.dart';

class SaleDetailDataTableWidget extends StatelessWidget {
  const SaleDetailDataTableWidget({super.key});
  static final GlobalKey<FormBuilderState> _fbEditRowKey =
      GlobalKey<FormBuilderState>();
  final prefixDataTableHeader = "screens.sale.detail.dataTable.header";
  final prefixDataTableContent = "screens.sale.detail.dataTable.content";
  final double minWidth = 0.0;
  @override
  Widget build(BuildContext context) {
    final readProvider = context.read<SaleProvider>();
    final theme = Theme.of(context);
    List<DataTableColumnModel> columns = [
      DataTableColumnModel(
        label: "$prefixDataTableHeader.item",
        value: "item",
        headingRowAlignment: MainAxisAlignment.start,
      ),
      DataTableColumnModel(label: "$prefixDataTableHeader.qty", value: "qty"),
      DataTableColumnModel(
          label: "$prefixDataTableHeader.total",
          value: "total",
          headingRowAlignment: MainAxisAlignment.end),
    ];
    // Note: ReturnQty បង្ហាញពេលមាន module soup & user role != tablet-orders
    bool allowReturnQty =
        SaleService.isModuleActive(modules: ['soup'], context: context) &&
            !UserService.userInRole(roles: ['tablet-orders']);
    if (allowReturnQty) {
      columns.insert(
          2,
          DataTableColumnModel(
              label: "$prefixDataTableHeader.returnQty", value: "returnQty"));
    }

    void resetFieldValue(
        {required SaleDetailDTRowType rowType,
        required int index,
        required SaleDetailModel item}) async {
      // Note: reset field value to previous value if user close dialog or press on cancel button
      final previousRow = await readProvider.fetchSaleDetails();
      String onChangedValue = '';
      switch (rowType) {
        case SaleDetailDTRowType.price:
          onChangedValue = '${previousRow[index].price}';
          break;
        case SaleDetailDTRowType.discountRate:
          onChangedValue = '${previousRow[index].discount}';
          break;
        case SaleDetailDTRowType.note:
          if (previousRow[index].note != null) {
            onChangedValue = previousRow[index].note!;
          }
          break;
        case SaleDetailDTRowType.qty:
          onChangedValue = '${previousRow[index].totalQty}';
          break;
        default:
          onChangedValue = '${previousRow[index].returnQty}';
      }
      readProvider.handleItemUpdate(
          onChangedValue: onChangedValue, item: item, rowType: rowType);
    }

    return Consumer<SaleProvider>(builder: (context, state, child) {
      return state.isSaleDetailLoading
          ? const LoadingWidget()
          : Theme(
              data: theme.copyWith(
                  dividerTheme: DividerThemeData(color: theme.focusColor)),
              child: ScrollableWidget(
                controller: readProvider.saleDetailScrollController,
                // headerChild: DataTable(
                //   headingTextStyle: theme.textTheme.bodySmall
                //       ?.copyWith(fontWeight: FontWeight.bold),
                //   columns: [
                //     for (DataTableColumnModel column in columns)
                //       DataColumn(
                //         headingRowAlignment: column.headingRowAlignment,
                //         label: Row(
                //           children: [
                //             if (column.value == 'item')
                //               Checkbox(
                //                 value: state.selectedSaleDetails.length ==
                //                     state.saleDetails
                //                         .where((sd) =>
                //                             sd.checkPrint == false ||
                //                             (UserService.userInRole(
                //                                     roles: ['tablet-orders']) &&
                //                                 (sd.draft == null ||
                //                                     sd.draft == false)))
                //                         .length,
                //                 onChanged: (value) {
                //                   readProvider
                //                       .selectAllRows(!state.isSelectedAllRows);
                //                 },
                //               ),
                //             Text(
                //               column.label,
                //               overflow: TextOverflow.ellipsis,
                //             ).tr(namedArgs: {
                //               "totalItem": '${state.saleDetails.length}'
                //             }),
                //           ],
                //         ),
                //       ),
                //     const DataColumn(
                //         headingRowAlignment: MainAxisAlignment.center,
                //         label: Icon(RestaurantDefaultIcons.actions))
                //   ],
                //   rows: const [],
                // ),
                bodyChild: DataTable(
                  columnSpacing: 0.0,
                  dataRowMaxHeight: double.infinity,
                  headingTextStyle: theme.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                  onSelectAll: (_) {
                    readProvider.selectAllRows(!state.isSelectedAllRows);
                  },
                  columns: [
                    for (DataTableColumnModel column in columns)
                      DataColumn(
                        headingRowAlignment: column.headingRowAlignment,
                        label: Text(
                          column.label,
                          overflow: TextOverflow.ellipsis,
                        ).tr(namedArgs: {
                          "totalItem": '${state.saleDetails.length}'
                        }),
                      ),
                    const DataColumn(
                        headingRowAlignment: MainAxisAlignment.center,
                        label: Icon(RestaurantDefaultIcons.actions))
                  ],
                  rows:
                      List<DataRow>.generate(state.saleDetails.length, (index) {
                    SaleDetailModel row = state.saleDetails[index];
                    // Note: qty, discount rate, note មិនអាចកែបាន បើសិន print bill រួច || user role == tablet-orders ហើយ item មិនមែន draft
                    bool disableItemRow = row.checkPrint ||
                        (UserService.userInRole(roles: ['tablet-orders']) &&
                            (row.draft == null || row.draft == false));
                    return DataRow(
                      selected: state.selectedSaleDetails.contains(row),
                      onSelectChanged: disableItemRow
                          ? null
                          : (isSelectedRow) {
                              readProvider.selectRow(
                                  isSelectedRow ?? false, row);
                            },
                      color: WidgetStateProperty.all(
                          disableItemRow ? theme.highlightColor : null),
                      cells: [
                        DataCell(Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppStyleDefaultProperties.p / 2),
                          child: Column(
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
                              // Variant Item
                              if (row.variantId != null &&
                                  row.variantName != null) ...[
                                Text(
                                  ' - ${row.variantName}',
                                  style: theme.textTheme.bodyMedium,
                                ),
                                const Divider(
                                    height: AppStyleDefaultProperties.h / 4)
                              ],
                              // Extra items
                              if (row.extraItemDoc.isNotEmpty)
                                for (int i = 0;
                                    i < row.extraItemDoc.length;
                                    i++)
                                  RichText(
                                      text: TextSpan(
                                          text:
                                              ' + ${row.extraItemDoc[i].itemName} | ',
                                          style: theme.textTheme.bodySmall,
                                          children: [
                                        WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.baseline,
                                            baseline: TextBaseline.alphabetic,
                                            child: FormatCurrencyWidget(
                                                value:
                                                    row.extraItemDoc[i].amount,
                                                priceFontSize: 12.0,
                                                currencySymbolFontSize: 14.0,
                                                color: AppThemeColors.primary))
                                      ])),
                              // InkWell(
                              //   onTap: () => GlobalService.openDialog(
                              //       contentWidget:
                              //           SaleDetailExtraItemsWidget(
                              //         extraItems: row.extraItemDoc,
                              //       ),
                              //       context: context),
                              //   child: Text(
                              //       '${'screens.sale.category.extraFoods'.tr()} (${row.extraItemDoc.length})',
                              //       style: theme.textTheme.bodyMedium),
                              // ),
                              // Catalog Combo Items
                              if (row.catalogType != null &&
                                  row.comboDoc.isNotEmpty &&
                                  row.catalogType == "Combo")
                                for (int i = 0; i < row.comboDoc.length; i++)
                                  RichText(
                                      text: TextSpan(
                                          text:
                                              ' ${row.comboDoc[i].itemName} x ',
                                          style: theme.textTheme.bodySmall,
                                          children: [
                                        TextSpan(
                                            text: '${row.comboDoc[i].qty}',
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(
                                                    color:
                                                        AppThemeColors.failure,
                                                    fontWeight:
                                                        FontWeight.bold))
                                      ])),
                              // InkWell(
                              //   onTap: () => GlobalService.openDialog(
                              //       contentWidget:
                              //           SaleDetailComboItemsWidget(
                              //         comboItems: row.comboDoc,
                              //       ),
                              //       context: context),
                              //   child: Text(
                              //       '${'screens.sale.category.catalog'.tr()} (${row.comboDoc.length})',
                              //       style: theme.textTheme.bodyMedium),
                              // ),
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
                                                                SaleDetailDTRowType
                                                                    .price,
                                                            item: row,
                                                            onInsertPressed: () =>
                                                                readProvider
                                                                    .updateSaleDetailItem(
                                                                        item:
                                                                            row,
                                                                        context:
                                                                            context),
                                                          ),
                                                          context: context)
                                                      .then(
                                                    (_) => resetFieldValue(
                                                        rowType:
                                                            SaleDetailDTRowType
                                                                .price,
                                                        index: index,
                                                        item: row),
                                                  ),
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
                                                        contentWidget: EditSaleDetailDataTableRowWidget(
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
                                                                        item:
                                                                            row,
                                                                        context:
                                                                            context)),
                                                        context: context)
                                                    .then(
                                                  (_) => resetFieldValue(
                                                      rowType:
                                                          SaleDetailDTRowType
                                                              .discountRate,
                                                      index: index,
                                                      item: row),
                                                ),
                                        child: RichText(
                                          text: TextSpan(
                                              style: theme.textTheme.bodyMedium,
                                              text:
                                                  '$prefixDataTableContent.discountRate'
                                                      .tr(),
                                              children: [
                                                TextSpan(
                                                    text: ' ${row.discount} %',
                                                    style: theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                AppThemeColors
                                                                    .primary))
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
                                          contentWidget:
                                              EditSaleDetailDataTableRowWidget(
                                            fbEditRowKey:
                                                SaleDetailDataTableWidget
                                                    ._fbEditRowKey,
                                            rowType: SaleDetailDTRowType.note,
                                            item: row,
                                            onInsertPressed: () {
                                              if (row.note != null) {
                                                readProvider
                                                    .updateSaleDetailItemNote(
                                                        id: row.id,
                                                        note: row.note!,
                                                        context: context);
                                              }
                                            },
                                          ),
                                          context: context,
                                        ).then(
                                          (_) => resetFieldValue(
                                              rowType: SaleDetailDTRowType.note,
                                              index: index,
                                              item: row),
                                        ),
                                child: Row(
                                  children: [
                                    row.checkPrintKitchen != null &&
                                            row.checkPrintKitchen == true
                                        ? const Icon(
                                            RestaurantDefaultIcons.chef,
                                            color: AppThemeColors.primary)
                                        : const Icon(
                                            RestaurantDefaultIcons.editNote),
                                    const SizedBox(width: 4.0),
                                    Expanded(
                                      child: Text(
                                        row.note != null && row.note != ''
                                            ? row.note!
                                            : '$prefixDataTableContent.note'
                                                .tr(),
                                        style:
                                            ResponsiveLayout.isMobile(context)
                                                ? theme.textTheme.bodySmall
                                                : null,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                        // Qty
                        // Note: Item qty មិនអាចកែបានពេល print bill រួច || print ទៅ kitchen រួច || user role == tablet-orders ហើយ item មិនមែន draft || item status == Done
                        DataCell(
                            onTap: row.checkPrint ||
                                    (row.checkPrintKitchen != null &&
                                        row.checkPrintKitchen == true) ||
                                    (UserService.userInRole(
                                            roles: ['tablet-orders']) &&
                                        (row.draft == null ||
                                            row.draft == false)) ||
                                    row.status == 'Done'
                                ? null
                                : () => GlobalService.openDialog(
                                            contentWidget:
                                                EditSaleDetailDataTableRowWidget(
                                              fbEditRowKey:
                                                  SaleDetailDataTableWidget
                                                      ._fbEditRowKey,
                                              rowType: SaleDetailDTRowType.qty,
                                              item: row,
                                              onInsertPressed: () =>
                                                  readProvider
                                                      .updateSaleDetailItem(
                                                          item: row,
                                                          context: context),
                                            ),
                                            context: context)
                                        .then(
                                      (_) => resetFieldValue(
                                          rowType: SaleDetailDTRowType.qty,
                                          index: index,
                                          item: row),
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
                                                fbEditRowKey:
                                                    SaleDetailDataTableWidget
                                                        ._fbEditRowKey,
                                                rowType: SaleDetailDTRowType
                                                    .returnQty,
                                                item: row,
                                                onInsertPressed: () =>
                                                    readProvider
                                                        .updateSaleDetailItem(
                                                            item: row,
                                                            context: context),
                                              ),
                                              context: context)
                                          .then(
                                        (_) => resetFieldValue(
                                            rowType:
                                                SaleDetailDTRowType.returnQty,
                                            index: index,
                                            item: row),
                                      ),
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
                        DataCell(Align(
                          alignment: Alignment.center,
                          child: IconButton(
                              onPressed: row.checkPrint ||
                                      UserService.userInRole(
                                              roles: ['tablet-orders']) &&
                                          row.draft != true
                                  ? null
                                  : () async {
                                      // Remove Sale Detail Extra Item
                                      if (row.extraItemDoc.isNotEmpty) {
                                        final String extraItemId =
                                            row.extraItemDoc.last.id;
                                        ResponseModel? result =
                                            await readProvider.removeExtraItem(
                                                extraItemid: extraItemId);
                                        if (result != null) {
                                          Alert.show(
                                              description: result.description,
                                              type: result.type);
                                        }
                                      } else {
                                        // Remove Sale Detail Item
                                        GlobalService.openDialog(
                                          context: context,
                                          contentWidget: ConfirmDialogWidget(
                                            content: Wrap(
                                              children: [
                                                Text(row.itemName,
                                                    style: theme
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                Text(
                                                  'dialog.confirm.remove.description'
                                                      .tr(),
                                                  style: theme
                                                      .textTheme.bodyMedium,
                                                ),
                                              ],
                                            ),
                                            onAgreePressed: () async {
                                              ResponseModel? result =
                                                  await readProvider.removeItem(
                                                      id: row.id);
                                              if (result != null) {
                                                Alert.show(
                                                    description:
                                                        result.description,
                                                    type: result.type);
                                              }
                                              if (context.mounted) {
                                                context.pop();
                                              }
                                            },
                                          ),
                                        );
                                      }
                                    },
                              style: IconButton.styleFrom(
                                  padding: EdgeInsets.zero),
                              icon: Icon(RestaurantDefaultIcons.remove,
                                  color: row.checkPrint
                                      ? theme.highlightColor
                                      : AppThemeColors.failure)),
                        )),
                      ],
                    );
                  }),
                ),
              ),
            );
    });
  }
}
