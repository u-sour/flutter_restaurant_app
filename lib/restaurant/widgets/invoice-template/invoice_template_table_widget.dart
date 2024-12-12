import 'package:flutter/material.dart';
import '../../models/invoice-template/table/table_list_schema_model.dart';
import '../../models/invoice-template/table/table_schema_model.dart';
import '../../models/sale/invoice/print/sale_detail_for_print_model.dart';
import '../invoice/invoice_format_currency_widget.dart';

class InvoiceTemplateTableWidget extends StatelessWidget {
  final TableSchemaModel tableSchema;
  final List<SaleDetailForPrintModel> saleDetails;
  const InvoiceTemplateTableWidget({
    super.key,
    required this.tableSchema,
    required this.saleDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = MediaQuery.sizeOf(context).width;
    const Color baseColor = Colors.black;
    // filter table list
    // Note: isVisible == true
    final List<TableListSchemaModel> tables =
        tableSchema.list.where((t) => t.isVisible).toList();
    return tables.isNotEmpty
        ? Container(
            width: width,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: DataTable(
              dataRowMaxHeight: double.infinity,
              columnSpacing: 0.0,
              horizontalMargin: 0.0,
              headingRowColor: WidgetStateColor.resolveWith(
                  (states) => theme.highlightColor),
              border: tableSchema.borderMode == "Full"
                  ? TableBorder.all()
                  : const TableBorder(
                      top: BorderSide(),
                      horizontalInside: BorderSide(),
                      bottom: BorderSide()),
              // loop tables to get List<DataColumn>
              // Note: loop only table field isVisible == true
              columns: List<DataColumn>.generate(tables.length, (int i) {
                TextAlign thTextAlign = TextAlign.start;
                if (tables[i].alignClass == 'text-center') {
                  thTextAlign = TextAlign.center;
                }
                if (tables[i].alignClass == 'text-right') {
                  thTextAlign = TextAlign.end;
                }
                return DataColumn(
                  label: Expanded(
                    child: Container(
                      width: tables[i].thStyle.width,
                      padding: EdgeInsets.fromLTRB(
                        tableSchema.thStyle.paddingLeft ?? 0.0,
                        tableSchema.thStyle.paddingTop ?? 0.0,
                        tableSchema.thStyle.paddingRight ?? 0.0,
                        tableSchema.thStyle.paddingBottom ?? 0.0,
                      ),
                      child: Text(
                          tableSchema.showThSubLabel
                              ? '${tables[i].label}\n${tables[i].subLabel}'
                              : tables[i].label,
                          style: theme.textTheme.bodySmall!.copyWith(
                              color: baseColor,
                              fontSize: tableSchema.thStyle.fontSize,
                              fontWeight: FontWeight.bold),
                          textAlign: thTextAlign,
                          softWrap: true),
                    ),
                  ),
                );
              }),
              // Loop sale details for data cell
              rows: List<DataRow>.generate(saleDetails.length, (int i) {
                Map<String, dynamic> row = saleDetails[i].toJson();
                return DataRow(
                  // loop tables to get List<DataCell>
                  // Note: loop only table field isVisible == true
                  cells: List<DataCell>.generate(tables.length, (int i) {
                    MainAxisAlignment tdTextAlign = MainAxisAlignment.start;
                    if (tables[i].alignClass == 'text-center') {
                      tdTextAlign = MainAxisAlignment.center;
                    }
                    if (tables[i].alignClass == 'text-right') {
                      tdTextAlign = MainAxisAlignment.end;
                    }
                    return DataCell(
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          tableSchema.tdStyle.paddingLeft ?? 0.0,
                          tableSchema.tdStyle.paddingTop ?? 0.0,
                          tableSchema.tdStyle.paddingRight ?? 0.0,
                          tableSchema.tdStyle.paddingBottom ?? 0.0,
                        ),
                        child: Row(mainAxisAlignment: tdTextAlign, children: [
                          tables[i].field == 'itemName'
                              ? Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Item Name
                                      Text(row[tables[i].field],
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(
                                            fontSize:
                                                tableSchema.tdStyle.fontSize,
                                            fontWeight:
                                                tables[i].tdStyle.fontWeight !=
                                                            null &&
                                                        tables[i]
                                                                .tdStyle
                                                                .fontWeight ==
                                                            'bold'
                                                    ? FontWeight.bold
                                                    : null,
                                          )),
                                      // Catalog
                                      if (row['comboItems'].isNotEmpty)
                                        for (int i = 0;
                                            i < row['comboItems'].length;
                                            i++)
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: tables[i]
                                                      .subItemStyle
                                                      ?.paddingLeft ??
                                                  0.0,
                                              bottom: tables[i]
                                                      .subItemStyle
                                                      ?.paddingBottom ??
                                                  0.0,
                                            ),
                                            child: Text(
                                              '-${row['comboItems'][i]['itemName']} x${row['comboItems'][i]['qty']}',
                                              style: theme.textTheme.bodySmall!
                                                  .copyWith(
                                                color: baseColor,
                                                fontSize: tables[i]
                                                    .subItemStyle
                                                    ?.fontSize,
                                                fontWeight: tables[i]
                                                                .tdStyle
                                                                .fontWeight !=
                                                            null &&
                                                        tables[i]
                                                                .tdStyle
                                                                .fontWeight ==
                                                            'bold'
                                                    ? FontWeight.bold
                                                    : null,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                      // Extra Items
                                      if (row['extraItems'].isNotEmpty)
                                        for (int i = 0;
                                            i < row['extraItems'].length;
                                            i++)
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: tables[i]
                                                      .subItemStyle
                                                      ?.paddingLeft ??
                                                  0.0,
                                              bottom: tables[i]
                                                      .subItemStyle
                                                      ?.paddingBottom ??
                                                  0.0,
                                            ),
                                            child: Text(
                                              '-${row['extraItems'][i]['itemName']} | ${row['extraItems'][i]['price']}',
                                              style: theme.textTheme.bodySmall!
                                                  .copyWith(
                                                color: baseColor,
                                                fontSize: tables[i]
                                                    .subItemStyle
                                                    ?.fontSize,
                                                fontWeight: tables[i]
                                                                .tdStyle
                                                                .fontWeight !=
                                                            null &&
                                                        tables[i]
                                                                .tdStyle
                                                                .fontWeight ==
                                                            'bold'
                                                    ? FontWeight.bold
                                                    : null,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                    ],
                                  ),
                                )
                              :
                              // price & amount
                              tables[i].field == 'price' ||
                                      tables[i].field == 'amount'
                                  ? InvoiceFormatCurrencyWidget(
                                      value: row[tables[i].field],
                                      color: baseColor,
                                      priceFontSize:
                                          tableSchema.tdStyle.fontSize,
                                      currencySymbolFontSize:
                                          tableSchema.tdStyle.fontSize! + 2,
                                      fontWeight:
                                          tables[i].tdStyle.fontWeight == 'bold'
                                              ? FontWeight.bold
                                              : null,
                                    )
                                  :
                                  // qty & discount
                                  Text(
                                      tables[i].field == 'discount'
                                          ? '${row[tables[i].field]}%'
                                          : '${row[tables[i].field]}',
                                      style:
                                          theme.textTheme.bodySmall!.copyWith(
                                        color: baseColor,
                                        fontSize: tableSchema.tdStyle.fontSize,
                                        fontWeight:
                                            tables[i].tdStyle.fontWeight ==
                                                    'bold'
                                                ? FontWeight.bold
                                                : null,
                                      ),
                                    ),
                        ]),
                      ),
                    );
                  }),
                );
              }),
            ),
          )
        : const SizedBox.shrink();
  }
}
