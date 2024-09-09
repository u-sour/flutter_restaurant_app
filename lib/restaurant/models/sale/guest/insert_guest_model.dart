import 'package:json_annotation/json_annotation.dart';
part 'insert_guest_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class InsertGuestModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String? id;
  final String name;
  final String? telephone;
  final String? address;
  final String branchId;

  const InsertGuestModel({
    this.id,
    required this.name,
    this.telephone,
    this.address,
    required this.branchId,
  });

  factory InsertGuestModel.fromJson(Map<String, dynamic> json) =>
      _$InsertGuestModelFromJson(json);
  Map<String, dynamic> toJson() => _$InsertGuestModelToJson(this);
}
