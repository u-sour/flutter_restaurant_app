import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../../../../models/select-option/select_option_model.dart';
import '../../../../services/global_service.dart';
import '../../../../utils/constants.dart';
import '../../../models/sale/detail/sale_detail_model.dart';
import '../../../providers/sale/sale_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/sale/sale_utils.dart';
import '../../empty_data_table_widget.dart';
import 'edit_sale_detail_data_table_row_widget.dart';

class SaleDetailDataTableWidget extends StatelessWidget {
  const SaleDetailDataTableWidget({super.key});
  static final GlobalKey<FormBuilderState> _fbEditRowKey =
      GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final readProvider = context.read<SaleProvider>();
    final theme = Theme.of(context);
    const prefixDataTableHeader = "screens.sale.detail.dataTable.header";
    const prefixDataTableContent = "screens.sale.detail.dataTable.content";
    List<SelectOptionModel> columns = const [
      SelectOptionModel(
          label: "$prefixDataTableHeader.item", value: "item", extra: 170.0),
      SelectOptionModel(
          label: "$prefixDataTableHeader.qty", value: "qty", extra: 45.0),
      SelectOptionModel(
          label: "$prefixDataTableHeader.returnQty",
          value: "returnQty",
          extra: 70.0),
      SelectOptionModel(label: "$prefixDataTableHeader.total", value: "total"),
    ];
    double rowHeight = 100.0;
    double actionsWidth = 35.0;
    double minWidth = 0.0;
    return Consumer<SaleProvider>(builder: (context, state, child) {
      return DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: minWidth,
        headingTextStyle:
            theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        empty: const EmptyDataTableWidget(),
        onSelectAll: (isSelectAllRows) {
          readProvider.selectAllRows(isSelectAllRows ?? false);
        },
        headingCheckboxTheme: theme.checkboxTheme,
        datarowCheckboxTheme: theme.checkboxTheme,
        columns: [
          for (SelectOptionModel column in columns)
            DataColumn2(
              fixedWidth: column.extra,
              label: Text(
                column.label,
                overflow: TextOverflow.ellipsis,
              ).tr(namedArgs: {"totalItem": "20"}),
            ),
          DataColumn2(
              fixedWidth: actionsWidth,
              label: const Center(child: Icon(RestaurantDefaultIcons.actions)))
        ],
        rows: List<DataRow>.generate(state.rows.length, (index) {
          SaleDetailModel row = state.rows[index];
          return DataRow2(
            selected: state.selectedRows.contains(row),
            onSelectChanged: (isSelectedRow) {
              readProvider.selectRow(isSelectedRow ?? false, row);
            },
            specificRowHeight: rowHeight,
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
                  // Price & Discount
                  RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodyLarge,
                      children: [
                        WidgetSpan(
                          child: InkWell(
                            onTap: () => GlobalService.openDialog(
                                contentWidget: EditSaleDetailDataTableRowWidget(
                                    fbEditRowKey: _fbEditRowKey,
                                    rowType: SaleDetailDTRowType.price,
                                    index: index,
                                    item: row),
                                context: context),
                            child: Text(
                              '${row.price} \$',
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: AppThemeColors.primary),
                            ),
                          ),
                        ),
                        const TextSpan(text: ' | '),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () => GlobalService.openDialog(
                                contentWidget: EditSaleDetailDataTableRowWidget(
                                    fbEditRowKey: _fbEditRowKey,
                                    rowType: SaleDetailDTRowType.discountRate,
                                    index: index,
                                    item: row),
                                context: context),
                            child: RichText(
                              text: TextSpan(
                                  style: theme.textTheme.bodyMedium,
                                  text: '$prefixDataTableContent.discountRate'
                                      .tr(),
                                  children: [
                                    TextSpan(
                                        text: ' ${row.discountRate} %',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                color: AppThemeColors.primary))
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Note
                  RichText(
                      text: TextSpan(
                    style: theme.textTheme.bodySmall,
                    children: [
                      WidgetSpan(
                        child: InkWell(
                          onTap: () => GlobalService.openDialog(
                              contentWidget: EditSaleDetailDataTableRowWidget(
                                  fbEditRowKey: _fbEditRowKey,
                                  rowType: SaleDetailDTRowType.note,
                                  index: index,
                                  item: row),
                              context: context),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(RestaurantDefaultIcons.editNote),
                              const SizedBox(width: 4.0),
                              const Text('$prefixDataTableContent.note').tr()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              )),
              DataCell(Center(
                  child: InkWell(
                      onTap: () => GlobalService.openDialog(
                          contentWidget: EditSaleDetailDataTableRowWidget(
                              fbEditRowKey: _fbEditRowKey,
                              rowType: SaleDetailDTRowType.qty,
                              index: index,
                              item: row),
                          context: context),
                      child: Text('${row.qty}')))),
              DataCell(Center(
                child: InkWell(
                  onTap: () => GlobalService.openDialog(
                      contentWidget: EditSaleDetailDataTableRowWidget(
                          fbEditRowKey: _fbEditRowKey,
                          rowType: SaleDetailDTRowType.returnQty,
                          index: index,
                          item: row),
                      context: context),
                  child: Text(
                    '${row.returnQty}',
                  ),
                ),
              )),
              DataCell(Text('${row.total} \$',
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppThemeColors.primary,
                      fontWeight: FontWeight.bold))),
              DataCell(Center(
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(RestaurantDefaultIcons.remove,
                        color: AppThemeColors.failure)),
              )),
            ],
          );
        }),
      );
    });
  }
}
