enum SaleReportFilterType {
  groupBy,
  customers,
  employees,
  departments,
  status,
}

const String prefixSaleReportForm =
    'screens.reports.customer.children.sale.form';

extension SaleReportFilterTypeExtension on SaleReportFilterType {
  String get toTitle {
    switch (this) {
      case SaleReportFilterType.groupBy:
        return '$prefixSaleReportForm.groupBy.title';
      case SaleReportFilterType.customers:
        return '$prefixSaleReportForm.customers';
      case SaleReportFilterType.employees:
        return '$prefixSaleReportForm.employees';
      case SaleReportFilterType.departments:
        return '$prefixSaleReportForm.departments';
      default:
        return '$prefixSaleReportForm.status.title';
    }
  }
}

enum SaleReportDTRowType {
  no,
  location,
  invoice,
  refInvoice,
  date,
  depName,
  employeeName,
  guestName,
  status,
  subTotal,
  discountRate,
  discountValue,
  total
}

const prefixSaleReportDataTableHeader =
    "screens.reports.customer.children.sale.dataTable.header";

extension SaleReportDTRowTypeExtension on SaleReportDTRowType {
  String get toTitle {
    switch (this) {
      case SaleReportDTRowType.no:
        return '$prefixSaleReportDataTableHeader.no';
      case SaleReportDTRowType.location:
        return '$prefixSaleReportDataTableHeader.location';
      case SaleReportDTRowType.invoice:
        return '$prefixSaleReportDataTableHeader.invoice';
      case SaleReportDTRowType.refInvoice:
        return '$prefixSaleReportDataTableHeader.refInvoice';
      case SaleReportDTRowType.date:
        return '$prefixSaleReportDataTableHeader.date';
      case SaleReportDTRowType.depName:
        return '$prefixSaleReportDataTableHeader.department';
      case SaleReportDTRowType.employeeName:
        return '$prefixSaleReportDataTableHeader.employee';
      case SaleReportDTRowType.guestName:
        return '$prefixSaleReportDataTableHeader.customer';
      case SaleReportDTRowType.status:
        return '$prefixSaleReportDataTableHeader.status';
      case SaleReportDTRowType.subTotal:
        return '$prefixSaleReportDataTableHeader.subTotal';
      case SaleReportDTRowType.discountRate:
        return '$prefixSaleReportDataTableHeader.discountRate';
      case SaleReportDTRowType.discountValue:
        return '$prefixSaleReportDataTableHeader.discountAmount';
      default:
        return '$prefixSaleReportDataTableHeader.total';
    }
  }

  double get columnSpanSize {
    switch (this) {
      case SaleReportDTRowType.no:
        return 48.0;
      case SaleReportDTRowType.date:
        return 165.0;
      default:
        return 125.0;
    }
  }
}

enum SaleReportDTFooterType { subTotal, discount, totalKhr, totalUsd, totalThb }

const prefixSaleReportDataTableFooter =
    "screens.reports.customer.children.sale.dataTable.footer";

extension SaleReportDTFooterTypeExtension on SaleReportDTFooterType {
  String get toTitle {
    switch (this) {
      case SaleReportDTFooterType.subTotal:
        return '$prefixSaleReportDataTableFooter.subTotal';
      case SaleReportDTFooterType.discount:
        return '$prefixSaleReportDataTableFooter.discount';
      case SaleReportDTFooterType.totalKhr:
        return '$prefixSaleReportDataTableFooter.totalKHR';
      case SaleReportDTFooterType.totalUsd:
        return '$prefixSaleReportDataTableFooter.totalUSD';
      default:
        return '$prefixSaleReportDataTableFooter.totalTHB';
    }
  }
}

// Summary report
// DataTable Header
enum SaleSummaryReportDTHeaderType { description, total }

const prefixSaleSummaryReportDataTableHeader =
    "screens.reports.customer.children.sale.dataTable.summaryHeader";

extension SaleSummaryReportDTHeaderTypeExtension
    on SaleSummaryReportDTHeaderType {
  String get toTitle {
    switch (this) {
      case SaleSummaryReportDTHeaderType.description:
        return '$prefixSaleSummaryReportDataTableHeader.description';
      default:
        return '$prefixSaleSummaryReportDataTableHeader.total';
    }
  }
}

// DataTable Content
enum SaleSummaryReportDTRowType {
  depName,
  totalSale,
  openSale,
  partialSale,
  receivedSale,
}

const prefixSaleSummaryReportDataTableContent =
    "screens.reports.customer.children.sale.dataTable.summaryContent";

extension SaleSummaryReportDTRowTypeExtension on SaleSummaryReportDTRowType {
  String get toTitle {
    switch (this) {
      case SaleSummaryReportDTRowType.totalSale:
        return '$prefixSaleSummaryReportDataTableContent.totalSale';
      case SaleSummaryReportDTRowType.openSale:
        return '$prefixSaleSummaryReportDataTableContent.openSale';
      case SaleSummaryReportDTRowType.partialSale:
        return '$prefixSaleSummaryReportDataTableContent.partialSale';
      default:
        return '$prefixSaleSummaryReportDataTableContent.receivedSale';
    }
  }
}
