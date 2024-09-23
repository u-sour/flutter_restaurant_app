import 'package:json_annotation/json_annotation.dart';
part 'convert_to_multi_exchange_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ConvertToMultiExchangeModel {
  @JsonKey(name: 'KHR')
  final num khr;
  @JsonKey(name: 'USD')
  final num usd;
  @JsonKey(name: 'THB')
  final num thb;

  const ConvertToMultiExchangeModel({
    required this.khr,
    required this.usd,
    required this.thb,
  });

  factory ConvertToMultiExchangeModel.fromJson(Map<String, dynamic> json) =>
      _$ConvertToMultiExchangeModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConvertToMultiExchangeModelToJson(this);
}
