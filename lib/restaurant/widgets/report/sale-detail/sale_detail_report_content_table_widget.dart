import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
import '../../../../utils/convert_date_time.dart';
import '../../../models/reports/sale-detail/sale_detail_data_detail_report_model.dart';
import '../../../models/reports/sale-detail/sale_detail_data_report_model.dart';
import '../../../providers/reports/sale_detail_report_provider.dart';
import '../../../utils/report/sale_detail_report_utils.dart';
import '../../report_template/report_template_content_table_cell_currency_widget.dart';
import '../../report_template/report_template_content_table_cell_widget.dart';

class SaleDetailReportContentTableWidget extends StatelessWidget {
  final List<SaleDetailReportDTRowType> fields;
  final List<SaleDetailDataReportModel> saleDetailDataReport;
  final String groupBy;
  const SaleDetailReportContentTableWidget(
      {super.key,
      required this.fields,
      required this.saleDetailDataReport,
      required this.groupBy});

  @override
  Widget build(BuildContext context) {
    List<SaleDetailDataDetailReportModel> rows = [];

    // Prepare data
    for (int i = 0; i < saleDetailDataReport.length; i++) {
      Map<String, dynamic> data = saleDetailDataReport[i].details[0].toJson();
      data['no'] = i + 1;
      if (groupBy.isNotEmpty && saleDetailDataReport[i].groupLabel.isNotEmpty) {
        data['groupLabel'] = saleDetailDataReport[i].groupLabel;
        data['qty'] = saleDetailDataReport[i].qty;
        data['amount'] = saleDetailDataReport[i].amount;
      }
      rows.add(SaleDetailDataDetailReportModel.fromJson(data));

      if (groupBy.isNotEmpty) {
        for (int j = 0; j < saleDetailDataReport[i].details.length; j++) {
          Map<String, dynamic> data =
              saleDetailDataReport[i].details[j].toJson();
          data['no'] = j + 1;
          rows.add(SaleDetailDataDetailReportModel.fromJson(data));
        }
      }
    }

    // Note: rows.length +1 for table header
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .4,
      child: TableView.builder(
        pinnedRowCount: 1,
        columnCount: fields.length,
        rowCount: rows.length + 1,
        columnBuilder: (index) => _buildColumnSpan(index, context),
        rowBuilder: (index) => _buildRowSpan(index, context, rows),
        cellBuilder: (context, tableVicinity) =>
            _buildCell(context, tableVicinity, rows),
      ),
    );
  }

  TableViewCell _buildCell(BuildContext context, TableVicinity vicinity,
      List<SaleDetailDataDetailReportModel> rows) {
    SaleDetailReportProvider readSaleDetailReportProvider =
        context.read<SaleDetailReportProvider>();
    final theme = Theme.of(context);
    final tableBorderColor = theme.colorScheme.onSurface;
    late TableViewCell cell;

    if (vicinity.row == 0) {
      // Note: row == 0 then show table header
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
          isHeader: true,
          text: fields[vicinity.column].toTitle,
          fontWeight: FontWeight.bold,
          alignment: fields[vicinity.column] ==
                      SaleDetailReportDTRowType.price ||
                  fields[vicinity.column] == SaleDetailReportDTRowType.qty ||
                  fields[vicinity.column] ==
                      SaleDetailReportDTRowType.discountRate ||
                  fields[vicinity.column] == SaleDetailReportDTRowType.amount
              ? Alignment.centerRight
              : fields[vicinity.column] == SaleDetailReportDTRowType.no
                  ? Alignment.center
                  : Alignment.centerLeft,
        ),
      );
    } else if (rows[vicinity.row - 1].groupLabel != null) {
      // Merge column if group by item, date or employee
      switch (fields[vicinity.column]) {
        case SaleDetailReportDTRowType.qty:
          cell = TableViewCell(
            child: ReportTemplateContentTableCellWidget(
              border: Border(bottom: BorderSide(color: tableBorderColor)),
              fontWeight: FontWeight.bold,
              dynamicText: rows[vicinity.row - 1].qty,
              alignment: Alignment.centerRight,
            ),
          );
          break;
        case SaleDetailReportDTRowType.amount:
          cell = TableViewCell(
            child: ReportTemplateContentTableCellCurrencyWidget(
                border: Border(bottom: BorderSide(color: tableBorderColor)),
                fontWeight: FontWeight.bold,
                value: rows[vicinity.row - 1].amount),
          );
          break;
        default:
          cell = TableViewCell(
            columnMergeStart: 0,
            columnMergeSpan: groupBy == 'item' ? 6 : 7,
            child: ReportTemplateContentTableCellWidget(
              dynamicText: rows[vicinity.row - 1].groupLabel,
              fontWeight: FontWeight.bold,
            ),
          );
      }
    } else if (fields[vicinity.column] == SaleDetailReportDTRowType.no) {
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
          dynamicText: rows[vicinity.row - 1].no,
          alignment: Alignment.center,
        ),
      );
    } else if (fields[vicinity.column] == SaleDetailReportDTRowType.invoice) {
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
            dynamicText: readSaleDetailReportProvider.getInvoiceText(
                saleDetailDataDetail: rows[vicinity.row - 1],
                context: context)),
      );
    } else if (fields[vicinity.column] == SaleDetailReportDTRowType.date) {
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
            dynamicText: ConvertDateTime.formatTimeStampToString(
                rows[vicinity.row - 1].date, true)),
      );
    } else if (fields[vicinity.column] == SaleDetailReportDTRowType.qty) {
      cell = TableViewCell(
          child: ReportTemplateContentTableCellWidget(
              dynamicText: rows[vicinity.row - 1].qty,
              alignment: Alignment.centerRight));
    } else if (fields[vicinity.column] ==
        SaleDetailReportDTRowType.discountRate) {
      cell = TableViewCell(
          child: ReportTemplateContentTableCellWidget(
              dynamicText: '${rows[vicinity.row - 1].discount}%',
              alignment: Alignment.centerRight));
    } else if (fields[vicinity.column] == SaleDetailReportDTRowType.price ||
        // fields[vicinity.column] == SaleDetailReportDTRowType.discountAmount ||
        fields[vicinity.column] == SaleDetailReportDTRowType.amount) {
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
      index, BuildContext context, List<SaleDetailDataDetailReportModel> rows,
      {double rowSpanSize = 48.0}) {
    final theme = Theme.of(context);
    final tableBorderColor = theme.colorScheme.onSurface;
    Color? bgColor;

    // Table background color header
    if (index == 0) {
      bgColor = theme.highlightColor;
    }

    // Table background color sub header (Group)
    if (index != 0 && rows[index - 1].groupLabel != null) {
      bgColor = theme.highlightColor.withOpacity(.2);
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
