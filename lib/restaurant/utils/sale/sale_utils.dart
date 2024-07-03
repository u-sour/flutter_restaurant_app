enum SaleDetailDTRowType {
  price,
  discountRate,
  note,
  qty,
  returnQty,
}

const prefixSaleDetailDataTableContent =
    "screens.sale.detail.dataTable.content";

extension SaleScreenExtension on SaleDetailDTRowType {
  String get toTitle {
    switch (this) {
      case SaleDetailDTRowType.price:
        return '$prefixSaleDetailDataTableContent.price';
      case SaleDetailDTRowType.discountRate:
        return '$prefixSaleDetailDataTableContent.discountRateLabel';
      case SaleDetailDTRowType.note:
        return '$prefixSaleDetailDataTableContent.note';
      case SaleDetailDTRowType.qty:
        return '$prefixSaleDetailDataTableContent.qty';
      default:
        return '$prefixSaleDetailDataTableContent.returnQty';
    }
  }
}
