import 'package:flutter/material.dart';
import '../../models/invoice-template/table/table_list_schema_model.dart';
import '../../models/invoice-template/table/table_schema_model.dart';
import '../../models/sale/detail/sale_detail_model.dart';
import '../invoice/invoice_format_currency_widget.dart';

class InvoiceTemplateTableWidget extends StatelessWidget {
  final TableSchemaModel tableSchema;
  final List<SaleDetailModel> saleDetails;
  const InvoiceTemplateTableWidget({
    super.key,
    required this.tableSchema,
    required this.saleDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const Color baseColor = Colors.black;
    // filter table list
    // Note: isVisible == true
    final List<TableListSchemaModel> tables =
        tableSchema.list.where((t) => t.isVisible).toList();
    double columnSpacing;
    switch (tables.length) {
      case 5:
        columnSpacing = 18.0;
        break;
      case 4:
        columnSpacing = 42.0;
        break;
      case 3:
        columnSpacing = 80.0;
        break;
      case 2:
        columnSpacing = 220.0;
        break;
      default:
        columnSpacing = 0.0;
    }
    return tables.isNotEmpty
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: DataTable(
              dataRowMaxHeight: double.infinity,
              columnSpacing: columnSpacing,
              horizontalMargin: 0.0,
              headingRowColor: WidgetStateColor.resolveWith(
                  (states) => theme.highlightColor),
              border: TableBorder.all(),
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
                  label: Container(
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
                                      if (row['comboDoc'].isNotEmpty)
                                        for (int i = 0;
                                            i < row['comboDoc'].length;
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
                                              '-${row['comboDoc'][i]['itemName']} x${row['comboDoc'][i]['qty']}',
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
                                      if (row['extraItemDoc'].isNotEmpty)
                                        for (int i = 0;
                                            i < row['extraItemDoc'].length;
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
                                              '-${row['extraItemDoc'][i]['itemName']} | ${row['extraItemDoc'][i]['price']}',
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