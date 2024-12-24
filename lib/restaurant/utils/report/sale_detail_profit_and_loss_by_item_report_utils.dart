enum SaleDetailProfitAndLossByItemReportFilterType {
  categories,
  employees,
  departments,
}

const String prefixSDProfitAndLossByItemReportForm =
    'screens.reports.customer.children.profitAndLossByItem.form';

extension SaleReportFilterTypeExtension
    on SaleDetailProfitAndLossByItemReportFilterType {
  String get toTitle {
    switch (this) {
      case SaleDetailProfitAndLossByItemReportFilterType.categories:
        return '$prefixSDProfitAndLossByItemReportForm.categories';
      case SaleDetailProfitAndLossByItemReportFilterType.employees:
        return '$prefixSDProfitAndLossByItemReportForm.employees';
      default:
        return '$prefixSDProfitAndLossByItemReportForm.departments';
    }
  }
}

enum SaleDetailProfitAndLossByItemReportDTRowType {
  categoryName,
  itemName,
  date,
  totalQty,
  totalCost,
  totalCostAmount,
  totalPrice,
  totalPriceAmount,
  totalDiscountAmount,
  totalPriceBeforeDiscount,
  totalProfit
}

const prefixSDProfitAndLossByItemReportDataTableHeader =
    "screens.reports.customer.children.profitAndLossByItem.dataTable.header";

extension SaleDetailProfitAndLossByItemReportDTRowTypeExtension
    on SaleDetailProfitAndLossByItemReportDTRowType {
  String get toTitle {
    switch (this) {
      case SaleDetailProfitAndLossByItemReportDTRowType.categoryName:
        return '$prefixSDProfitAndLossByItemReportDataTableHeader.category';
      case SaleDetailProfitAndLossByItemReportDTRowType.itemName:
        return '$prefixSDProfitAndLossByItemReportDataTableHeader.name';
      case SaleDetailProfitAndLossByItemReportDTRowType.date:
        return '$prefixSDProfitAndLossByItemReportDataTableHeader.date';
      case SaleDetailProfitAndLossByItemReportDTRowType.totalQty:
        return '$prefixSDProfitAndLossByItemReportDataTableHeader.qty';
      case SaleDetailProfitAndLossByItemReportDTRowType.totalCost:
        return '$prefixSDProfitAndLossByItemReportDataTableHeader.cost';
      case SaleDetailProfitAndLossByItemReportDTRowType.totalCostAmount:
        return '$prefixSDProfitAndLossByItemReportDataTableHeader.totalCost';
      case SaleDetailProfitAndLossByItemReportDTRowType.totalPrice:
        return '$prefixSDProfitAndLossByItemReportDataTableHeader.price';
      case SaleDetailProfitAndLossByItemReportDTRowType.totalPriceAmount:
        return '$prefixSDProfitAndLossByItemReportDataTableHeader.totalPrice';
      case SaleDetailProfitAndLossByItemReportDTRowType.totalDiscountAmount:
        return '$prefixSDProfitAndLossByItemReportDataTableHeader.discount';
      case SaleDetailProfitAndLossByItemReportDTRowType
            .totalPriceBeforeDiscount:
        return '$prefixSDProfitAndLossByItemReportDataTableHeader.total';
      default:
        return '$prefixSDProfitAndLossByItemReportDataTableHeader.profit';
    }
  }

  double get columnSpanSize {
    switch (this) {
      case SaleDetailProfitAndLossByItemReportDTRowType.categoryName:
      case SaleDetailProfitAndLossByItemReportDTRowType.itemName:
        return 200.0;
      case SaleDetailProfitAndLossByItemReportDTRowType.date:
        return 180.0;
      case SaleDetailProfitAndLossByItemReportDTRowType.totalQty:
        return 80.0;
      default:
        return 125.0;
    }
  }
}

enum SaleDetailProfitAndLossByItemReportDTFooterType {
  totalQty,
  totalCost,
  totalPrice,
  totalDiscount,
  totalProfitKHR,
  totalProfitUSD,
  totalProfitTHB
}

const prefixSDProfitAndLossByItemReportDataTableFooter =
    "screens.reports.customer.children.profitAndLossByItem.dataTable.footer";

extension SaleDetailProfitAndLossByItemReportDTFooterTypeExtension
    on SaleDetailProfitAndLossByItemReportDTFooterType {
  String get toTitle {
    switch (this) {
      case SaleDetailProfitAndLossByItemReportDTFooterType.totalQty:
        return '$prefixSDProfitAndLossByItemReportDataTableFooter.totalQty';
      case SaleDetailProfitAndLossByItemReportDTFooterType.totalCost:
        return '$prefixSDProfitAndLossByItemReportDataTableFooter.totalCost';
      case SaleDetailProfitAndLossByItemReportDTFooterType.totalPrice:
        return '$prefixSDProfitAndLossByItemReportDataTableFooter.totalPrice';
      case SaleDetailProfitAndLossByItemReportDTFooterType.totalDiscount:
        return '$prefixSDProfitAndLossByItemReportDataTableFooter.totalDiscount';
      case SaleDetailProfitAndLossByItemReportDTFooterType.totalProfitKHR:
        return '$prefixSDProfitAndLossByItemReportDataTableFooter.totalProfitKHR';
      case SaleDetailProfitAndLossByItemReportDTFooterType.totalProfitUSD:
        return '$prefixSDProfitAndLossByItemReportDataTableFooter.totalProfitUSD';
      default:
        return '$prefixSDProfitAndLossByItemReportDataTableFooter.totalProfitTHB';
    }
  }
}
