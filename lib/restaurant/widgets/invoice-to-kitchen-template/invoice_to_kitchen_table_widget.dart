import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../models/select-option/select_option_model.dart';
import '../../../utils/constants.dart';
import '../../models/sale/detail/sale_detail_model.dart';

class InvoiceToKitchenTableWidget extends StatelessWidget {
  final List<SaleDetailModel> saleDetail;
  const InvoiceToKitchenTableWidget({super.key, required this.saleDetail});
  final String prefixDataTable = 'screens.sale.invoice.dataTable.header';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = MediaQuery.sizeOf(context).width;
    const Color baseColor = Colors.black;
    List<SelectOptionModel> fields = [
      SelectOptionModel(label: '$prefixDataTable.item', value: 'itemName'),
      SelectOptionModel(label: '$prefixDataTable.qty', value: 'qty')
    ];
    TextAlign textAlign(String filedName) {
      TextAlign textAlign = TextAlign.start;
      if (filedName == 'qty') {
        textAlign = TextAlign.center;
      }
      return textAlign;
    }

    List<int> dashed = [5, 2];

    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: DottedDecoration(color: baseColor, dash: dashed),
      child: DataTable(
        dataRowMaxHeight: double.infinity,
        columnSpacing: 0.0,
        horizontalMargin: 0.0,
        headingRowColor:
            WidgetStateColor.resolveWith((states) => theme.highlightColor),
        // border: TableBorder.all(),
        columns: List<DataColumn>.generate(fields.length, (int i) {
          return DataColumn(
            label: Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                    left: AppStyleDefaultProperties.p / 4),
                child: Text(fields[i].label.tr(),
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: baseColor, fontWeight: FontWeight.bold),
                    textAlign: textAlign(fields[i].value),
                    softWrap: true),
              ),
            ),
          );
        }),
        rows: List<DataRow>.generate(saleDetail.length, (int i) {
          Map<String, dynamic> row = saleDetail[i].toJson();
          // loop sale detail for data cell
          return DataRow(
              cells: List.generate(fields.length, (int i) {
            // loop fields (itemName,qty)
            return DataCell(
              fields[i].value == "itemName"
                  ? Container(
                      padding: const EdgeInsets.only(
                          left: AppStyleDefaultProperties.p / 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Item Name
                          Text(
                            row[fields[i].value],
                            style: theme.textTheme.bodyLarge!.copyWith(
                                color: baseColor, fontWeight: FontWeight.bold),
                            textAlign: textAlign(fields[i].value),
                          ),
                          // Extra Items
                          if (row['extraItemDoc'].isNotEmpty)
                            for (int i = 0; i < row['extraItemDoc'].length; i++)
                              Text(
                                '\t-${row['extraItemDoc'][i]['itemName']}',
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: baseColor,
                                ),
                                softWrap: true,
                              ),
                          // Note
                          if (row['note'] != null)
                            SizedBox(
                              width: 100.0,
                              child: Text('\t${row['note']}'),
                            )
                        ],
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: Text(
                        '${row[fields[i].value]}',
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: baseColor, fontWeight: FontWeight.bold),
                        textAlign: textAlign(fields[i].value),
                      ),
                    ),
            );
          }));
        }),
      ),
    );
  }
}
