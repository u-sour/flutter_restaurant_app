enum SaleDetailReportFilterType {
  groupBy,
  departments,
  employees,
  categories,
  groups,
  products,
}

const String prefixSaleDetailReportForm =
    'screens.reports.customer.children.saleDetail.form';

extension SaleReportFilterTypeExtension on SaleDetailReportFilterType {
  String get toTitle {
    switch (this) {
      case SaleDetailReportFilterType.groupBy:
        return '$prefixSaleDetailReportForm.groupBy.title';
      case SaleDetailReportFilterType.departments:
        return '$prefixSaleDetailReportForm.departments';
      case SaleDetailReportFilterType.employees:
        return '$prefixSaleDetailReportForm.employees';
      case SaleDetailReportFilterType.categories:
        return '$prefixSaleDetailReportForm.categories';
      case SaleDetailReportFilterType.groups:
        return '$prefixSaleDetailReportForm.groups';
      default:
        return '$prefixSaleDetailReportForm.products';
    }
  }
}

enum SaleDetailReportDTRowType {
  no,
  itemName,
  invoice,
  date,
  departmentName,
  employeeName,
  price,
  qty,
  discountRate,
  amount
}

const prefixSaleDetailReportDataTableHeader =
    "screens.reports.customer.children.saleDetail.dataTable.header";

extension SaleDetailReportDTRowTypeExtension on SaleDetailReportDTRowType {
  String get toTitle {
    switch (this) {
      case SaleDetailReportDTRowType.no:
        return '$prefixSaleDetailReportDataTableHeader.no';
      case SaleDetailReportDTRowType.itemName:
        return '$prefixSaleDetailReportDataTableHeader.item';
      case SaleDetailReportDTRowType.invoice:
        return '$prefixSaleDetailReportDataTableHeader.invoice';
      case SaleDetailReportDTRowType.date:
        return '$prefixSaleDetailReportDataTableHeader.date';
      case SaleDetailReportDTRowType.departmentName:
        return '$prefixSaleDetailReportDataTableHeader.department';
      case SaleDetailReportDTRowType.employeeName:
        return '$prefixSaleDetailReportDataTableHeader.employee';
      case SaleDetailReportDTRowType.price:
        return '$prefixSaleDetailReportDataTableHeader.price';
      case SaleDetailReportDTRowType.qty:
        return '$prefixSaleDetailReportDataTableHeader.qty';
      case SaleDetailReportDTRowType.discountRate:
        return '$prefixSaleDetailReportDataTableHeader.discount';
      default:
        return '$prefixSaleDetailReportDataTableHeader.amount';
    }
  }

  double get columnSpanSize {
    switch (this) {
      case SaleDetailReportDTRowType.no:
        return 48.0;
      case SaleDetailReportDTRowType.itemName:
        return 200.0;
      case SaleDetailReportDTRowType.date:
        return 165.0;
      case SaleDetailReportDTRowType.qty:
      case SaleDetailReportDTRowType.discountRate:
        return 80.0;
      default:
        return 125.0;
    }
  }
}

enum SaleDetailReportDTFooterType {
  qty,
  discount,
  totalKhr,
  totalUsd,
  totalThb
}

const prefixSaleDetailReportDataTableFooter =
    "screens.reports.customer.children.saleDetail.dataTable.footer";

extension SaleReportDTFooterTypeExtension on SaleDetailReportDTFooterType {
  String get toTitle {
    switch (this) {
      case SaleDetailReportDTFooterType.qty:
        return '$prefixSaleDetailReportDataTableFooter.qty';
      case SaleDetailReportDTFooterType.discount:
        return '$prefixSaleDetailReportDataTableFooter.discount';
      case SaleDetailReportDTFooterType.totalKhr:
        return '$prefixSaleDetailReportDataTableFooter.totalKHR';
      case SaleDetailReportDTFooterType.totalUsd:
        return '$prefixSaleDetailReportDataTableFooter.totalUSD';
      default:
        return '$prefixSaleDetailReportDataTableFooter.totalTHB';
    }
  }
}
