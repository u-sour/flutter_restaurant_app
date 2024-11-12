import 'package:flutter/material.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
import '../../../models/reports/sale/sale_summary_report_model.dart';
import '../../../utils/report/sale_report_utils.dart';
import '../../report_template/report_template_content_table_cell_widget.dart';

class SaleReportSummaryContentTableWidget extends StatelessWidget {
  final List<SaleSummaryReportModel> saleSummaryDataReport;
  final List<SaleSummaryReportDTRowType> fields =
      SaleSummaryReportDTRowType.values;
  const SaleReportSummaryContentTableWidget(
      {super.key, required this.saleSummaryDataReport});

  @override
  Widget build(BuildContext context) {
    List<SaleSummaryReportModel> rows = saleSummaryDataReport;
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
    cell = const TableViewCell(
        child: ReportTemplateContentTableCellWidget(dynamicText: 'hi'));
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
      extent: const FixedSpanExtent(200.0),
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
