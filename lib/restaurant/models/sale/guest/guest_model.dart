import 'package:json_annotation/json_annotation.dart';
import '../../../../utils/model_converter/date_model_converter.dart';
part 'guest_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GuestModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String name;
  final String branchId;
  final String? telephone;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeOptionalForModel,
      toJson: DateModelConverter.convertDateTimeOptionalForModel)
  final DateTime? createdAt;

  const GuestModel({
    required this.id,
    required this.name,
    required this.branchId,
    this.telephone,
    this.createdAt,
  });

  factory GuestModel.fromJson(Map<String, dynamic> json) =>
      _$GuestModelFromJson(json);
  Map<String, dynamic> toJson() => _$GuestModelToJson(this);
}
