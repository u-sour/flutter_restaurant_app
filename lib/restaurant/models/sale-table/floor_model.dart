import 'package:json_annotation/json_annotation.dart';
part 'floor_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FloorModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String branchId;
  final String depId;
  final String name;
  final String status;

  const FloorModel({
    required this.id,
    required this.branchId,
    required this.depId,
    required this.name,
    required this.status,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) =>
      _$FloorModelFromJson(json);
  Map<String, dynamic> toJson() => _$FloorModelToJson(this);
}
