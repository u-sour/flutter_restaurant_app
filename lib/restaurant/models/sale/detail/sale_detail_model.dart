class SaleDetailModel {
  final String itemName;
  final num price;
  final num discountRate;
  final String? note;
  final num qty;
  final num returnQty;
  final num total;
  const SaleDetailModel({
    required this.itemName,
    required this.price,
    required this.discountRate,
    this.note,
    required this.qty,
    required this.returnQty,
    required this.total,
  });
}
