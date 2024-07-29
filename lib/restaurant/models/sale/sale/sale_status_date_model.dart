import 'package:json_annotation/json_annotation.dart';
import '../../../utils/model_converter/date_model_converter.dart';
part 'sale_status_date_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleStatusDateModel {
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime open;
  const SaleStatusDateModel({required this.open});

  factory SaleStatusDateModel.fromJson(Map<String, dynamic> json) =>
      _$SaleStatusDateModelFromJson(json);
  Map<String, dynamic> toJson() => _$SaleStatusDateModelToJson(this);
}
