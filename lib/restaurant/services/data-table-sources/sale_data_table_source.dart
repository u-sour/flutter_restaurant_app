import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../utils/constants.dart';
import '../../../utils/convert_date_time.dart';
import '../../models/sale/invoice/sale_invoice_data_model.dart';
import '../../utils/dashboard/dashboard_utils.dart';
import '../../widgets/invoice/invoice_format_currency_widget.dart';

class SaleInvoiceDataSource extends DataGridSource {
  List<SaleInvoiceDataModel> _paginatedSales = [];
  List<DataGridRow> dataGridRows = [];
  late ThemeData theme;

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      final SaleInvoiceDataModel sale = dataGridCell.value;
      final column = SaleInvoiceDTRowType.values
          .firstWhere((value) => value.name == dataGridCell.columnName);
      late Widget cell;
      switch (column.name) {
        case 'date':
          cell = Container(
            alignment: Alignment.center,
            child: Text(
                ConvertDateTime.formatTimeStampToString(
                    sale.toJson()[column.name], true),
                style: theme.textTheme.bodySmall),
          );
          break;
        case 'status':
          Color color = AppThemeColors.warning;
          if (sale.toJson()[column.name] == 'Closed') {
            color = AppThemeColors.failure;
          }
          if (sale.toJson()[column.name] == 'Cancel') {
            color = Colors.grey;
          }
          cell = Container(
            alignment: Alignment.center,
            color: color.withOpacity(.1),
            child: Text(sale.toJson()[column.name],
                style: theme.textTheme.bodySmall!.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                )),
          );
          break;
        case 'total' || 'totalReceived':
          cell = InvoiceFormatCurrencyWidget(
            value: sale.toJson()[column.name],
            enableRoundNumber: false,
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.normal,
            priceFontSize: theme.textTheme.bodySmall!.fontSize,
            currencySymbolFontSize: theme.textTheme.bodySmall!.fontSize! + 2,
            mainAxisAlignment: MainAxisAlignment.center,
          );
          break;
        default:
          cell = Container(
            alignment: Alignment.center,
            child: Text('${sale.toJson()[column.name]}',
                style: theme.textTheme.bodySmall),
          );
      }
      return cell;
    }).toList());
  }

  SaleInvoiceDataSource({
    required List<SaleInvoiceDataModel> sales,
    required BuildContext context,
  }) {
    theme = Theme.of(context);
    _paginatedSales = sales;
    buildPaginatedDataGridRows();
  }

  void buildPaginatedDataGridRows() {
    dataGridRows = _paginatedSales.map<DataGridRow>((dataGridRow) {
      return DataGridRow(
          cells: SaleInvoiceDTRowType.values
              .map((column) =>
                  DataGridCell(columnName: column.name, value: dataGridRow))
              .toList());
    }).toList(growable: false);
  }
}
