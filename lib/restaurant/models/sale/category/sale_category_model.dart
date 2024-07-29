import 'package:json_annotation/json_annotation.dart';
part 'sale_category_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleCategoryModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String name;
  final int level;
  @JsonKey(disallowNullValue: true)
  final List<SaleCategoryModel>? children;

  const SaleCategoryModel({
    required this.id,
    required this.name,
    required this.level,
    this.children,
  });

  factory SaleCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SaleCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleCategoryModelToJson(this);
}
