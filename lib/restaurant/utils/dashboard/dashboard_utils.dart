enum SaleInvoiceDTRowType {
  refNo,
  date,
  tableName,
  status,
  guestName,
  total,
  totalReceived
}

const prefixSaleInvoiceDataTableContent =
    "screens.dashboard.saleInvoiceContent.dataTable";

extension SaleInvoiceDTExtension on SaleInvoiceDTRowType {
  String get toTitle {
    switch (this) {
      case SaleInvoiceDTRowType.refNo:
        return '$prefixSaleInvoiceDataTableContent.invoice';
      case SaleInvoiceDTRowType.date:
        return '$prefixSaleInvoiceDataTableContent.date';
      case SaleInvoiceDTRowType.tableName:
        return '$prefixSaleInvoiceDataTableContent.table';
      case SaleInvoiceDTRowType.status:
        return '$prefixSaleInvoiceDataTableContent.status';
      case SaleInvoiceDTRowType.guestName:
        return '$prefixSaleInvoiceDataTableContent.customer';
      case SaleInvoiceDTRowType.total:
        return '$prefixSaleInvoiceDataTableContent.total';
      default:
        return '$prefixSaleInvoiceDataTableContent.received';
    }
  }
}
