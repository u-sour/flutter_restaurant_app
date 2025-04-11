import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/convert_date_time.dart';
import '../../../models/reports/sale-receipt/sale_receipt_data_report_model.dart';
import '../../../providers/report-template/report_template_provider.dart';
import '../../../providers/reports/sale_receipt_report_provider.dart';
import '../../../utils/report/sale_receipt_report_utils.dart';
import '../../report_template/report_template_content_table_cell_currency_widget.dart';
import '../../report_template/report_template_content_table_cell_widget.dart';

class SaleReceiptReportContentTableWidget extends StatelessWidget {
  final List<SaleReceiptReportDTRowType> fields;
  final List<SaleReceiptDataReportModel> saleReceiptDataReport;

  const SaleReceiptReportContentTableWidget({
    super.key,
    required this.fields,
    required this.saleReceiptDataReport,
  });

  @override
  Widget build(BuildContext context) {
    // Note: rows.length +1 for table header
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .4,
      child: TableView.builder(
        pinnedRowCount: 1,
        columnCount: fields.length,
        rowCount: saleReceiptDataReport.length + 1,
        columnBuilder: (index) => _buildColumnSpan(index, context),
        rowBuilder: (index) =>
            _buildRowSpan(index, context, saleReceiptDataReport),
        cellBuilder: (context, tableVicinity) =>
            _buildCell(context, tableVicinity, saleReceiptDataReport),
      ),
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity,
      List<SaleReceiptDataReportModel> rows) {
    ReportTemplateProvider readReportTemplateProvider =
        context.read<ReportTemplateProvider>();
    SaleReceiptReportProvider readSaleReceiptReportProvider =
        context.read<SaleReceiptReportProvider>();
    late TableViewCell cell;
    if (vicinity.row == 0) {
      // Note: row == 0 then show table header
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
          isHeader: true,
          text: fields[vicinity.column].toTitle,
          fontWeight: FontWeight.bold,
          alignment: fields[vicinity.column] ==
                      SaleReceiptReportDTRowType.openAmount ||
                  fields[vicinity.column] ==
                      SaleReceiptReportDTRowType.receiveAmount ||
                  fields[vicinity.column] ==
                      SaleReceiptReportDTRowType.feeAmount ||
                  fields[vicinity.column] ==
                      SaleReceiptReportDTRowType.remainingAmount
              ? Alignment.centerRight
              : fields[vicinity.column] == SaleReceiptReportDTRowType.no
                  ? Alignment.center
                  : Alignment.centerLeft,
        ),
      );
    } else if (fields[vicinity.column] == SaleReceiptReportDTRowType.no) {
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
          dynamicText: vicinity.row,
          alignment: Alignment.center,
        ),
      );
    } else if (fields[vicinity.column] == SaleReceiptReportDTRowType.invoice) {
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
            dynamicText: readSaleReceiptReportProvider.getInvoiceText(
                saleReceiptData: rows[vicinity.row - 1], context: context)),
      );
    } else if (fields[vicinity.column] == SaleReceiptReportDTRowType.date) {
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
            dynamicText: readReportTemplateProvider.formatDateReportPeriod(
                dateTime: rows[vicinity.row - 1].date)),
      );
    } else if (fields[vicinity.column] ==
            SaleReceiptReportDTRowType.openAmount ||
        fields[vicinity.column] == SaleReceiptReportDTRowType.receiveAmount ||
        fields[vicinity.column] == SaleReceiptReportDTRowType.feeAmount ||
        fields[vicinity.column] == SaleReceiptReportDTRowType.remainingAmount) {
      final field =
          rows[vicinity.row - 1].toJson()[fields[vicinity.column].name];
      cell = TableViewCell(
          child: ReportTemplateContentTableCellCurrencyWidget(value: field));
    } else {
      final field =
          rows[vicinity.row - 1].toJson()[fields[vicinity.column].name];
      cell = TableViewCell(
          child: ReportTemplateContentTableCellWidget(dynamicText: field));
    }
    return cell;
  }

  TableSpan _buildColumnSpan(int index, BuildContext context) {
    final theme = Theme.of(context);
    final tableBorderColor = theme.colorScheme.onSurface;
    TableSpanDecoration decoration = TableSpanDecoration(
      border: TableSpanBorder(
        leading:
            index == 0 ? BorderSide(color: tableBorderColor) : BorderSide.none,
        trailing: BorderSide(color: tableBorderColor),
      ),
    );

    return TableSpan(
      foregroundDecoration: decoration,
      extent: FixedSpanExtent(fields[index].columnSpanSize),
    );
  }

  TableSpan _buildRowSpan(
      index, BuildContext context, List<SaleReceiptDataReportModel> rows,
      {double rowSpanSize = 48.0}) {
    final theme = Theme.of(context);
    final tableBorderColor = theme.colorScheme.onSurface;
    Color? bgColor;

    // Table background color header
    if (index == 0) {
      bgColor = theme.highlightColor;
    }

    // check and set row background color partial and repaid
    if (index != 0 && rows[index - 1].remainingAmount > 0) {
      bgColor = AppThemeColors.warning.withOpacity(.2);
    } else if (index != 0 && !rows[index - 1].isInitial) {
      bgColor = AppThemeColors.success.withOpacity(.2);
    }

    final TableSpanDecoration decoration = TableSpanDecoration(
      color: bgColor,
      border: TableSpanBorder(
        leading:
            index == 0 ? BorderSide(color: tableBorderColor) : BorderSide.none,
        trailing: BorderSide(color: tableBorderColor),
      ),
    );

    return TableSpan(
      backgroundDecoration: decoration,
      extent: FixedSpanExtent(rowSpanSize),
    );
  }
}
