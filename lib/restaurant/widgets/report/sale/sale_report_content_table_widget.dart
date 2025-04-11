import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
import '../../../../utils/constants.dart';
import '../../../models/reports/sale/sale_data_detail_report_model.dart';
import '../../../models/reports/sale/sale_data_report_model.dart';
import '../../../providers/report-template/report_template_provider.dart';
import '../../../providers/reports/sale_report_provider.dart';
import '../../../utils/report/sale_report_utils.dart';
import '../../report_template/report_template_content_table_cell_currency_widget.dart';
import '../../report_template/report_template_content_table_cell_widget.dart';

class SaleReportContentTableWidget extends StatelessWidget {
  final List<SaleReportDTRowType> fields;
  final List<SaleDataReportModel> saleDataReport;
  final String groupBy;

  const SaleReportContentTableWidget(
      {super.key,
      required this.fields,
      required this.saleDataReport,
      required this.groupBy});

  @override
  Widget build(BuildContext context) {
    List<SaleDataDetailReportModel> rows = [];
    // Prepare data
    for (int i = 0; i < saleDataReport.length; i++) {
      Map<String, dynamic> data = saleDataReport[i].details[0].toJson();
      data['no'] = i + 1;
      if (groupBy != 'refNo' && saleDataReport[i].groupLabel.isNotEmpty) {
        data['groupLabel'] = saleDataReport[i].groupLabel;
        data['subTotal'] = saleDataReport[i].subTotal;
        data['discountValue'] = saleDataReport[i].discountValue;
        data['total'] = saleDataReport[i].total;
      }
      rows.add(SaleDataDetailReportModel.fromJson(data));

      if (groupBy != 'refNo') {
        for (int j = 0; j < saleDataReport[i].details.length; j++) {
          Map<String, dynamic> data = saleDataReport[i].details[j].toJson();
          data['no'] = j + 1;
          rows.add(SaleDataDetailReportModel.fromJson(data));
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
      List<SaleDataDetailReportModel> rows) {
    ReportTemplateProvider readReportTemplateProvider =
        context.read<ReportTemplateProvider>();
    SaleReportProvider readSaleReportProvider =
        context.read<SaleReportProvider>();
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
          alignment: fields[vicinity.column] == SaleReportDTRowType.subTotal ||
                  fields[vicinity.column] == SaleReportDTRowType.discountRate ||
                  fields[vicinity.column] ==
                      SaleReportDTRowType.discountValue ||
                  fields[vicinity.column] == SaleReportDTRowType.total
              ? Alignment.centerRight
              : fields[vicinity.column] == SaleReportDTRowType.no
                  ? Alignment.center
                  : Alignment.centerLeft,
        ),
      );
    } else if (rows[vicinity.row - 1].groupLabel != null) {
      // Merge column if group by date or employee
      switch (fields[vicinity.column]) {
        case SaleReportDTRowType.subTotal:
          cell = TableViewCell(
            child: ReportTemplateContentTableCellCurrencyWidget(
                border: Border(bottom: BorderSide(color: tableBorderColor)),
                fontWeight: FontWeight.bold,
                value: rows[vicinity.row - 1].subTotal),
          );
          break;
        case SaleReportDTRowType.discountValue:
          cell = TableViewCell(
            child: ReportTemplateContentTableCellCurrencyWidget(
                border: Border(bottom: BorderSide(color: tableBorderColor)),
                fontWeight: FontWeight.bold,
                value: rows[vicinity.row - 1].discountValue),
          );
          break;
        case SaleReportDTRowType.total:
          cell = TableViewCell(
            child: ReportTemplateContentTableCellCurrencyWidget(
                border: Border(bottom: BorderSide(color: tableBorderColor)),
                fontWeight: FontWeight.bold,
                value: rows[vicinity.row - 1].total),
          );
          break;
        default:
          cell = TableViewCell(
            columnMergeStart: 0,
            columnMergeSpan: 9,
            child: ReportTemplateContentTableCellWidget(
              dynamicText: rows[vicinity.row - 1].groupLabel,
              fontWeight: FontWeight.bold,
            ),
          );
      }
    } else if (fields[vicinity.column] == SaleReportDTRowType.no) {
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
          dynamicText: rows[vicinity.row - 1].no,
          alignment: Alignment.center,
        ),
      );
    } else if (fields[vicinity.column] == SaleReportDTRowType.location) {
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
            dynamicText: readSaleReportProvider.getLocationText(
                saleDataDetail: rows[vicinity.row - 1])),
      );
    } else if (fields[vicinity.column] == SaleReportDTRowType.invoice) {
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
            dynamicText: readSaleReportProvider.getInvoiceText(
                saleDataDetail: rows[vicinity.row - 1], context: context)),
      );
    } else if (fields[vicinity.column] == SaleReportDTRowType.refInvoice) {
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
          dynamicText: readSaleReportProvider.getInvoiceRefText(
              saleDataDetail: rows[vicinity.row - 1], context: context),
          alignment: Alignment.center,
        ),
      );
    } else if (fields[vicinity.column] == SaleReportDTRowType.date) {
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
            dynamicText: readReportTemplateProvider.formatDateReportPeriod(
                dateTime: rows[vicinity.row - 1].date)),
      );
    } else if (fields[vicinity.column] == SaleReportDTRowType.discountRate) {
      cell = TableViewCell(
          child: ReportTemplateContentTableCellWidget(
              dynamicText: '${rows[vicinity.row - 1].discountRate}%',
              alignment: Alignment.centerRight));
    } else if (fields[vicinity.column] == SaleReportDTRowType.subTotal ||
        fields[vicinity.column] == SaleReportDTRowType.discountValue ||
        fields[vicinity.column] == SaleReportDTRowType.total) {
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
      index, BuildContext context, List<SaleDataDetailReportModel> rows,
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
    // Check and set table row background color by status partial or cancel
    else if (index != 0 && rows[index - 1].status == 'Partial') {
      bgColor = AppThemeColors.warning.withOpacity(.2);
    } else if (index != 0 && rows[index - 1].isCancel) {
      bgColor = AppThemeColors.failure.withOpacity(.2);
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
