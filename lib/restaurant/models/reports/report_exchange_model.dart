import 'package:json_annotation/json_annotation.dart';
part 'report_exchange_model.g.dart';

@JsonSerializable()
class ReportExchangeModel {
  @JsonKey(name: 'KHR')
  final num khr;
  @JsonKey(name: 'USD')
  final num usd;
  @JsonKey(name: 'THB')
  final num thb;
  ReportExchangeModel({
    required this.khr,
    required this.usd,
    required this.thb,
  });

  factory ReportExchangeModel.fromJson(Map<String, dynamic> json) =>
      _$ReportExchangeModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReportExchangeModelToJson(this);
}
