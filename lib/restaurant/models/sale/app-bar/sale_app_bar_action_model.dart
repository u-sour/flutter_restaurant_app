import 'package:json_annotation/json_annotation.dart';
part 'sale_app_bar_action_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleAppBarActionModel {
  final String title;
  final String? date;

  const SaleAppBarActionModel({required this.title, this.date});

  factory SaleAppBarActionModel.fromJson(Map<String, dynamic> json) =>
      _$SaleAppBarActionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleAppBarActionModelToJson(this);
}
