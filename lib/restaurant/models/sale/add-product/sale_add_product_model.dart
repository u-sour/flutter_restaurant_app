import 'package:json_annotation/json_annotation.dart';
import '../product/product_model.dart';
part 'sale_add_product_model.g.dart';

/*
  Note: this model for insert or update items (products) into sale detail
*/
@JsonSerializable(explicitToJson: true)
class SaleAddProductModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String name;
  final String category;
  final String status;
  final num? cost;
  final num price;
  final String? type;
  final String? photoUrl;
  final String? catalogType;
  final bool? addOwnItem;
  final List<ProductModel>? products;
  final String? code;
  final String? barcode;
  final bool? showCategory;
  final bool? favorite;
  final num discount;
  final num? discountAmount;
  final bool? checkPrintKitchen;
  final String branchId;

  const SaleAddProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.status,
    this.cost,
    required this.price,
    this.type,
    this.photoUrl,
    this.catalogType,
    this.addOwnItem,
    this.products,
    this.code,
    this.barcode,
    this.showCategory,
    this.favorite,
    required this.discount,
    this.discountAmount,
    this.checkPrintKitchen,
    required this.branchId,
  });
  factory SaleAddProductModel.fromJson(Map<String, dynamic> json) =>
      _$SaleAddProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleAddProductModelToJson(this);
}
