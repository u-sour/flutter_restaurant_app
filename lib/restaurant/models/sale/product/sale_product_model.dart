import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
import 'product_model.dart';
part 'sale_product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleProductModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String name;
  final String? code;
  final String? category;
  final String? groupId;
  final String? group;
  final num price;
  final String type;
  final String? photo;
  final String? photoUrl;
  final String? catalogType;
  final bool? addOwnItem;
  final List<ProductModel>? products;
  final String? barcode;
  final bool? showCategory;
  final bool? favorite;
  final int discount;
  final String branchId;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime createdAt;
  final num? discountPrice;
  final num variantCount;

  const SaleProductModel({
    required this.id,
    required this.name,
    this.code,
    required this.category,
    this.groupId,
    this.group,
    required this.price,
    required this.type,
    this.photo,
    this.photoUrl,
    this.catalogType,
    this.addOwnItem,
    this.products,
    this.barcode,
    this.showCategory,
    this.favorite,
    required this.discount,
    required this.branchId,
    required this.createdAt,
    this.discountPrice,
    required this.variantCount,
  });
  factory SaleProductModel.fromJson(Map<String, dynamic> json) =>
      _$SaleProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleProductModelToJson(this);
}
