import 'package:json_annotation/json_annotation.dart';
import '../product/product_model.dart';
part 'insert_item_input_catalog_type_set_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InsertItemInputCatalogTypeSetModel {
  final String invoiceId;
  final String status;
  final List<ProductModel> products;
  final String branchId;

  const InsertItemInputCatalogTypeSetModel({
    required this.invoiceId,
    required this.status,
    required this.products,
    required this.branchId,
  });

  factory InsertItemInputCatalogTypeSetModel.fromJson(
          Map<String, dynamic> json) =>
      _$InsertItemInputCatalogTypeSetModelFromJson(json);
  Map<String, dynamic> toJson() =>
      _$InsertItemInputCatalogTypeSetModelToJson(this);
}
