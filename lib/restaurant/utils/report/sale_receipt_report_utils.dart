enum SaleReceiptReportFilterType {
  customers,
  employees,
  departments,
  paymentBy,
  status
}

const String prefixSaleReceiptReportForm =
    'screens.reports.customer.children.saleReceipt.form';

extension SaleReportFilterTypeExtension on SaleReceiptReportFilterType {
  String get toTitle {
    switch (this) {
      case SaleReceiptReportFilterType.customers:
        return '$prefixSaleReceiptReportForm.customers';
      case SaleReceiptReportFilterType.employees:
        return '$prefixSaleReceiptReportForm.employees';
      case SaleReceiptReportFilterType.departments:
        return '$prefixSaleReceiptReportForm.departments';
      case SaleReceiptReportFilterType.paymentBy:
        return '$prefixSaleReceiptReportForm.paymentBy';
      default:
        return '$prefixSaleReceiptReportForm.status';
    }
  }
}

enum SaleReceiptReportDTRowType {
  no,
  invoice,
  date,
  depName,
  employeeName,
  guestName,
  status,
  paymentBy,
  memo,
  openAmount,
  receiveAmount,
  feeAmount,
  remainingAmount,
}

const prefixSaleReceiptReportDataTableHeader =
    "screens.reports.customer.children.saleReceipt.dataTable.header";

extension SaleReceiptReportDTRowTypeExtension on SaleReceiptReportDTRowType {
  String get toTitle {
    switch (this) {
      case SaleReceiptReportDTRowType.no:
        return '$prefixSaleReceiptReportDataTableHeader.no';
      case SaleReceiptReportDTRowType.invoice:
        return '$prefixSaleReceiptReportDataTableHeader.invoice';
      case SaleReceiptReportDTRowType.date:
        return '$prefixSaleReceiptReportDataTableHeader.date';
      case SaleReceiptReportDTRowType.depName:
        return '$prefixSaleReceiptReportDataTableHeader.department';
      case SaleReceiptReportDTRowType.employeeName:
        return '$prefixSaleReceiptReportDataTableHeader.employee';
      case SaleReceiptReportDTRowType.guestName:
        return '$prefixSaleReceiptReportDataTableHeader.customer';
      case SaleReceiptReportDTRowType.status:
        return '$prefixSaleReceiptReportDataTableHeader.status';
      case SaleReceiptReportDTRowType.paymentBy:
        return '$prefixSaleReceiptReportDataTableHeader.paymentBy';
      case SaleReceiptReportDTRowType.memo:
        return '$prefixSaleReceiptReportDataTableHeader.memo';
      case SaleReceiptReportDTRowType.openAmount:
        return '$prefixSaleReceiptReportDataTableHeader.openAmount';
      case SaleReceiptReportDTRowType.receiveAmount:
        return '$prefixSaleReceiptReportDataTableHeader.receivedAmount';
      case SaleReceiptReportDTRowType.feeAmount:
        return '$prefixSaleReceiptReportDataTableHeader.fee';
      default:
        return '$prefixSaleReceiptReportDataTableHeader.balance';
    }
  }

  double get columnSpanSize {
    switch (this) {
      case SaleReceiptReportDTRowType.no:
        return 48.0;
      case SaleReceiptReportDTRowType.date:
        return 165.0;
      case SaleReceiptReportDTRowType.status:
        return 65.0;
      case SaleReceiptReportDTRowType.paymentBy:
        return 100.0;
      default:
        return 125.0;
    }
  }
}

enum SaleReceiptReportDTFooterType {
  openAmount,
  receivedAmount,
  fee,
  balance,
}

const prefixSaleReceiptReportDataTableFooter =
    "screens.reports.customer.children.saleReceipt.dataTable.footer";

extension SaleReportDTFooterTypeExtension on SaleReceiptReportDTFooterType {
  String get toTitle {
    switch (this) {
      case SaleReceiptReportDTFooterType.openAmount:
        return '$prefixSaleReceiptReportDataTableFooter.openAmount';
      case SaleReceiptReportDTFooterType.receivedAmount:
        return '$prefixSaleReceiptReportDataTableFooter.receivedAmount';
      case SaleReceiptReportDTFooterType.fee:
        return '$prefixSaleReceiptReportDataTableFooter.fee';
      default:
        return '$prefixSaleReceiptReportDataTableFooter.balance';
    }
  }
}
