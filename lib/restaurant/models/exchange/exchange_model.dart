import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
part 'exchange_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ExchangeModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String base;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime exDate;
  final int khr;
  final int thb;
  final int usd;

  const ExchangeModel({
    required this.id,
    required this.base,
    required this.exDate,
    required this.khr,
    required this.thb,
    required this.usd,
  });

  factory ExchangeModel.fromJson(Map<String, dynamic> json) =>
      _$ExchangeModelFromJson(json);
  Map<String, dynamic> toJson() => _$ExchangeModelToJson(this);
}
