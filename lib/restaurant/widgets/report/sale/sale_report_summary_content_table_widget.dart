import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
import '../../../models/reports/sale/sale_summary_report_model.dart';
import '../../../models/reports/sale/sale_summary_status_report_model.dart';
import '../../../utils/report/sale_report_utils.dart';
import '../../report_template/report_template_content_table_cell_currency_widget.dart';
import '../../report_template/report_template_content_table_cell_widget.dart';

class SaleReportSummaryContentTableWidget extends StatelessWidget {
  final List<SaleSummaryReportModel> saleSummaryDataReport;
  final List<SaleSummaryReportDTRowType> fields =
      SaleSummaryReportDTRowType.values;
  const SaleReportSummaryContentTableWidget(
      {super.key, required this.saleSummaryDataReport});

  @override
  Widget build(BuildContext context) {
    List<SaleSummaryReportModel> rows = [];

    // prepare data
    for (int i = 0; i < saleSummaryDataReport.length; i++) {
      Map<String, dynamic> data = saleSummaryDataReport[i].toJson();
      for (int j = 0; j < fields.length; j++) {
        if (data[fields[j].name] != null) {
          if (j == 0) {
            rows.add(SaleSummaryReportModel(depName: data[fields[j].name]));
          } else {
            switch (fields[j]) {
              case SaleSummaryReportDTRowType.totalSale:
                rows.add(
                  SaleSummaryReportModel(
                    totalSale: SaleSummaryStatusReportModel.fromJson(
                        data[fields[j].name]),
                  ),
                );
                break;
              case SaleSummaryReportDTRowType.openSale:
                rows.add(SaleSummaryReportModel(
                    openSale: SaleSummaryStatusReportModel.fromJson(
                        data[fields[j].name])));
                break;
              case SaleSummaryReportDTRowType.partialSale:
                rows.add(SaleSummaryReportModel(
                    partialSale: SaleSummaryStatusReportModel.fromJson(
                        data[fields[j].name])));
                break;
              default:
                rows.add(SaleSummaryReportModel(
                    receivedSale: SaleSummaryStatusReportModel.fromJson(
                        data[fields[j].name])));
            }
          }
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
      List<SaleSummaryReportModel> rows) {
    late TableViewCell cell;
    if (vicinity.row == 0) {
      // Note: row == 0 then show table header
      int colMergeStart = 0;
      int colMergeSpan = 2;
      String text = SaleSummaryReportDTHeaderType.description.toTitle;

      if (vicinity.column == 3) {
        colMergeStart = 2;
        colMergeSpan = 3;
        text = SaleSummaryReportDTHeaderType.total.toTitle;
      }

      cell = TableViewCell(
        columnMergeStart: colMergeStart,
        columnMergeSpan: colMergeSpan,
        child: ReportTemplateContentTableCellWidget(
          isHeader: true,
          text: text,
          fontWeight: FontWeight.bold,
          alignment: Alignment.center,
        ),
      );
    } else if (rows[vicinity.row - 1].depName != null) {
      // Merge column by department
      cell = TableViewCell(
          columnMergeStart: 0,
          columnMergeSpan: 5,
          child: ReportTemplateContentTableCellWidget(
            isHeader: true,
            dynamicText: rows[vicinity.row - 1].depName!,
            fontWeight: FontWeight.bold,
            alignment: Alignment.center,
          ));
    } else {
      final SaleSummaryReportModel saleSummaryData = rows[vicinity.row - 1];
      String text = '';
      num totalKhr = 0;
      num totalUsd = 0;
      num totalThb = 0;

      if (saleSummaryData.totalSale != null) {
        text =
            '${SaleSummaryReportDTRowType.totalSale.toTitle.tr()}(${saleSummaryData.totalSale?.count})';
        totalKhr = saleSummaryData.totalSale!.totalDoc.khr;
        totalUsd = saleSummaryData.totalSale!.totalDoc.usd;
        totalThb = saleSummaryData.totalSale!.totalDoc.thb;
      } else if (saleSummaryData.openSale != null) {
        text =
            '${SaleSummaryReportDTRowType.openSale.toTitle.tr()}(${saleSummaryData.openSale?.count})';
        if (saleSummaryData.openSale?.invoiceIds != null) {
          text += ' ${saleSummaryData.openSale?.invoiceIds}';
        }
        totalKhr = saleSummaryData.openSale!.totalDoc.khr;
        totalUsd = saleSummaryData.openSale!.totalDoc.usd;
        totalThb = saleSummaryData.openSale!.totalDoc.thb;
      } else if (saleSummaryData.partialSale != null) {
        text =
            '${SaleSummaryReportDTRowType.partialSale.toTitle.tr()}(${saleSummaryData.partialSale?.count})';
        if (saleSummaryData.partialSale?.invoiceIds != null) {
          text += ' ${saleSummaryData.partialSale?.invoiceIds}';
        }
        totalKhr = saleSummaryData.partialSale!.totalDoc.khr;
        totalUsd = saleSummaryData.partialSale!.totalDoc.usd;
        totalThb = saleSummaryData.partialSale!.totalDoc.thb;
      } else {
        text =
            '${SaleSummaryReportDTRowType.receivedSale.toTitle.tr()}(${saleSummaryData.receivedSale?.count})';
        totalKhr = saleSummaryData.receivedSale!.totalDoc.khr;
        totalUsd = saleSummaryData.receivedSale!.totalDoc.usd;
        totalThb = saleSummaryData.receivedSale!.totalDoc.thb;
      }

      switch (vicinity.column) {
        case 0:
        case 1:
          cell = TableViewCell(
              columnMergeStart: vicinity.column == 0 ? 0 : null,
              columnMergeSpan: vicinity.column == 0 ? 2 : null,
              child: ReportTemplateContentTableCellWidget(dynamicText: text));
          break;
        case 2:
          cell = TableViewCell(
              child: ReportTemplateContentTableCellCurrencyWidget(
            value: totalKhr,
            baseCurrency: 'KHR',
          ));
          break;
        case 3:
          cell = TableViewCell(
              child: ReportTemplateContentTableCellCurrencyWidget(
            value: totalUsd,
            baseCurrency: 'USD',
          ));
          break;
        default:
          cell = TableViewCell(
              child: ReportTemplateContentTableCellCurrencyWidget(
            value: totalThb,
            baseCurrency: 'THB',
          ));
      }
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
      index, BuildContext context, List<SaleSummaryReportModel> rows,
      {double rowSpanSize = 40.0}) {
    final theme = Theme.of(context);
    final tableBorderColor = theme.colorScheme.onSurface;
    Color? bgColor;

    // Table background color header
    if (index == 0) {
      bgColor = theme.highlightColor;
    }

    // Table background color sub header (Department)
    if (index != 0 && rows[index - 1].depName != null) {
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
