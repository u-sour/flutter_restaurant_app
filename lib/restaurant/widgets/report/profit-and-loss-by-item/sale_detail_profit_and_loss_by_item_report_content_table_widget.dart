import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';
import '../../../../utils/convert_date_time.dart';
import '../../../models/reports/profit-and-loss-by-item/sd_profit_and_loss_by_item_data_detail_report_model.dart';
import '../../../models/reports/profit-and-loss-by-item/sd_profit_and_loss_by_item_data_report_model.dart';
import '../../../providers/report-template/report_template_provider.dart';
import '../../../utils/report/sale_detail_profit_and_loss_by_item_report_utils.dart';
import '../../report_template/report_template_content_table_cell_currency_widget.dart';
import '../../report_template/report_template_content_table_cell_widget.dart';

class SaleDetailProfitAndLossByItemReportContentTableWidget
    extends StatelessWidget {
  final List<SaleDetailProfitAndLossByItemReportDTRowType> fields;
  final List<SDProfitAndLossByItemDataReportModel>
      sdProfitAndLossByItemDataReport;

  const SaleDetailProfitAndLossByItemReportContentTableWidget({
    super.key,
    required this.fields,
    required this.sdProfitAndLossByItemDataReport,
  });

  @override
  Widget build(BuildContext context) {
    List<SDProfitAndLossByItemDataDetailReportModel> rows = [];

    // Prepare data
    for (int i = 0; i < sdProfitAndLossByItemDataReport.length; i++) {
      Map<String, dynamic> data =
          sdProfitAndLossByItemDataReport[i].details[0].toJson();

      if (sdProfitAndLossByItemDataReport[i].depName.isNotEmpty) {
        data['depName'] = sdProfitAndLossByItemDataReport[i].depName;
      }
      rows.add(SDProfitAndLossByItemDataDetailReportModel.fromJson(data));

      // Looping detail
      for (int j = 0;
          j < sdProfitAndLossByItemDataReport[i].details.length;
          j++) {
        Map<String, dynamic> detailData =
            sdProfitAndLossByItemDataReport[i].details[j].toJson();
        detailData['rowType'] = 'detail';
        detailData.removeWhere((key, value) => key == 'depName');
        rows.add(
            SDProfitAndLossByItemDataDetailReportModel.fromJson(detailData));

        // Looping detail items
        for (int k = 0;
            k < sdProfitAndLossByItemDataReport[i].details[j].items.length;
            k++) {
          final item = sdProfitAndLossByItemDataReport[i].details[j].items[k];
          detailData['itemTranDate'] = item.tranDate;
          detailData['totalQty'] = item.qty;
          detailData['totalCost'] = item.cost;
          detailData['totalCostAmount'] = item.costAmount;
          detailData['totalPrice'] = item.price;
          detailData['totalPriceAmount'] = item.priceBeforeDiscount;
          detailData['totalDiscountAmount'] = item.discount;
          detailData['totalPriceBeforeDiscount'] = item.amount;
          detailData['totalProfit'] = item.profit;
          detailData['rowType'] = 'item';
          rows.add(
              SDProfitAndLossByItemDataDetailReportModel.fromJson(detailData));
        }

        // Grand Total
        if (j == sdProfitAndLossByItemDataReport[i].details.length - 1) {
          detailData['depName'] = sdProfitAndLossByItemDataReport[i].depName;
          detailData['totalQty'] =
              sdProfitAndLossByItemDataReport[i].grandTotalQty;
          detailData['totalCostAmount'] =
              sdProfitAndLossByItemDataReport[i].grandTotalCostAmount;
          detailData['totalPriceAmount'] =
              sdProfitAndLossByItemDataReport[i].grandTotalPriceAmount;
          detailData['totalDiscountAmount'] =
              sdProfitAndLossByItemDataReport[i].grandTotalDiscountAmount;
          detailData['totalPriceBeforeDiscount'] =
              sdProfitAndLossByItemDataReport[i].grandTotalPriceBeforeDiscount;
          detailData['totalProfit'] =
              sdProfitAndLossByItemDataReport[i].grandTotalProfit;
          detailData['rowType'] = 'grandTotal';
          rows.add(
              SDProfitAndLossByItemDataDetailReportModel.fromJson(detailData));
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
      List<SDProfitAndLossByItemDataDetailReportModel> rows) {
    ReportTemplateProvider readReportTemplateProvider =
        context.read<ReportTemplateProvider>();
    late TableViewCell cell;

    if (vicinity.row == 0) {
      // Note: row == 0 then show table header
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
          isHeader: true,
          text: fields[vicinity.column].toTitle,
          fontWeight: FontWeight.bold,
          alignment: fields[vicinity.column] ==
                      SaleDetailProfitAndLossByItemReportDTRowType
                          .categoryName ||
                  fields[vicinity.column] ==
                      SaleDetailProfitAndLossByItemReportDTRowType.itemName ||
                  fields[vicinity.column] ==
                      SaleDetailProfitAndLossByItemReportDTRowType.date
              ? Alignment.centerLeft
              : fields[vicinity.column] ==
                      SaleDetailProfitAndLossByItemReportDTRowType.totalQty
                  ? Alignment.center
                  : Alignment.centerRight,
        ),
      );
    } else if (rows[vicinity.row - 1].depName != null &&
        rows[vicinity.row - 1].rowType == null) {
      // Merge column if depName is exist
      cell = TableViewCell(
        columnMergeStart: 0,
        columnMergeSpan: 11,
        child: ReportTemplateContentTableCellWidget(
          dynamicText: rows[vicinity.row - 1].depName,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (rows[vicinity.row - 1].rowType != null &&
        rows[vicinity.row - 1].rowType == 'item') {
      // Merge column categoryName & itemName if rowType == item
      switch (fields[vicinity.column]) {
        case SaleDetailProfitAndLossByItemReportDTRowType.categoryName:
        case SaleDetailProfitAndLossByItemReportDTRowType.itemName:
          cell = const TableViewCell(
            columnMergeStart: 0,
            columnMergeSpan: 2,
            child: ReportTemplateContentTableCellWidget(
              dynamicText: '',
            ),
          );
          break;
        case SaleDetailProfitAndLossByItemReportDTRowType.date:
          cell = TableViewCell(
            child: ReportTemplateContentTableCellWidget(
                dynamicText: rows[vicinity.row - 1].itemTranDate != null
                    ? readReportTemplateProvider.formatDateReportPeriod(
                        dateTime: rows[vicinity.row - 1].itemTranDate!)
                    : ''),
          );
          break;
        case SaleDetailProfitAndLossByItemReportDTRowType.totalQty:
          cell = TableViewCell(
              child: ReportTemplateContentTableCellWidget(
                  dynamicText: rows[vicinity.row - 1].totalQty,
                  alignment: Alignment.center));
          break;
        case SaleDetailProfitAndLossByItemReportDTRowType.totalDiscountAmount:
          cell = TableViewCell(
              child: ReportTemplateContentTableCellWidget(
                  dynamicText: '${rows[vicinity.row - 1].totalDiscountAmount}%',
                  alignment: Alignment.centerRight));
          break;
        default:
          final field =
              rows[vicinity.row - 1].toJson()[fields[vicinity.column].name];
          cell = TableViewCell(
              child:
                  ReportTemplateContentTableCellCurrencyWidget(value: field));
      }
    } else if (rows[vicinity.row - 1].rowType != null &&
        rows[vicinity.row - 1].rowType == 'grandTotal') {
      // Merge column categoryName & itemName if rowType == item
      switch (fields[vicinity.column]) {
        case SaleDetailProfitAndLossByItemReportDTRowType.categoryName:
        case SaleDetailProfitAndLossByItemReportDTRowType.itemName:
        case SaleDetailProfitAndLossByItemReportDTRowType.date:
          cell = TableViewCell(
            columnMergeStart: 0,
            columnMergeSpan: 3,
            child: ReportTemplateContentTableCellWidget(
              dynamicText:
                  '${SaleDetailProfitAndLossByItemReportDTRowType.totalPriceBeforeDiscount.toTitle.tr()}: ${rows[vicinity.row - 1].depName}',
              fontWeight: FontWeight.bold,
            ),
          );
          break;

        case SaleDetailProfitAndLossByItemReportDTRowType.totalQty:
          cell = TableViewCell(
              child: ReportTemplateContentTableCellWidget(
            dynamicText: rows[vicinity.row - 1].totalQty,
            alignment: Alignment.center,
            fontWeight: FontWeight.bold,
          ));
          break;
        case SaleDetailProfitAndLossByItemReportDTRowType.totalCost:
        case SaleDetailProfitAndLossByItemReportDTRowType.totalPrice:
          cell = const TableViewCell(child: SizedBox.shrink());
          break;
        default:
          final field =
              rows[vicinity.row - 1].toJson()[fields[vicinity.column].name];
          cell = TableViewCell(
              child: ReportTemplateContentTableCellCurrencyWidget(
            value: field,
            fontWeight: FontWeight.bold,
          ));
      }
    } else if (fields[vicinity.column] ==
        SaleDetailProfitAndLossByItemReportDTRowType.categoryName) {
      String categoryNames = '';
      for (var i = 0; i < rows[vicinity.row - 1].categoryNames.length; i++) {
        categoryNames += i != rows[vicinity.row - 1].categoryNames.length - 1
            ? '${rows[vicinity.row - 1].categoryNames[i]} , '
            : rows[vicinity.row - 1].categoryNames[i];
      }
      cell = TableViewCell(
          child:
              ReportTemplateContentTableCellWidget(dynamicText: categoryNames));
    } else if (fields[vicinity.column] ==
        SaleDetailProfitAndLossByItemReportDTRowType.date) {
      cell = TableViewCell(
        child: ReportTemplateContentTableCellWidget(
            dynamicText: rows[vicinity.row - 1].itemTranDate != null
                ? ConvertDateTime.formatTimeStampToString(
                    rows[vicinity.row - 1].itemTranDate!, true)
                : ''),
      );
    } else if (fields[vicinity.column] ==
        SaleDetailProfitAndLossByItemReportDTRowType.totalQty) {
      cell = TableViewCell(
          child: ReportTemplateContentTableCellWidget(
              dynamicText: rows[vicinity.row - 1].totalQty,
              fontWeight: FontWeight.bold,
              alignment: Alignment.center));
    } else if (fields[vicinity.column] ==
            SaleDetailProfitAndLossByItemReportDTRowType.categoryName ||
        fields[vicinity.column] ==
            SaleDetailProfitAndLossByItemReportDTRowType.itemName) {
      final field =
          rows[vicinity.row - 1].toJson()[fields[vicinity.column].name];
      cell = TableViewCell(
          child: ReportTemplateContentTableCellWidget(dynamicText: field));
    } else {
      final field =
          rows[vicinity.row - 1].toJson()[fields[vicinity.column].name];
      cell = TableViewCell(
          child: ReportTemplateContentTableCellCurrencyWidget(
        value: field,
        fontWeight: FontWeight.bold,
      ));
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

  TableSpan _buildRowSpan(index, BuildContext context,
      List<SDProfitAndLossByItemDataDetailReportModel> rows,
      {double rowSpanSize = 48.0}) {
    final theme = Theme.of(context);
    final tableBorderColor = theme.colorScheme.onSurface;
    Color? bgColor;

    // Table background color header
    if (index == 0) {
      bgColor = theme.highlightColor;
    }

    // Table background color sub header (Department)
    if (index != 0 &&
        rows[index - 1].depName != null &&
        rows[index - 1].rowType == null) {
      bgColor = theme.highlightColor;
    }

    // Table background color sub header detail (Department)
    if (index != 0 && rows[index - 1].rowType == 'detail') {
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
