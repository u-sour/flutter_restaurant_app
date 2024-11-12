import 'package:json_annotation/json_annotation.dart';
part 'branch_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BranchModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String code;
  final String localName;
  final String? localAddress;
  final String? telephone;
  final String status;

  const BranchModel({
    required this.id,
    required this.code,
    required this.localName,
    required this.localAddress,
    required this.telephone,
    required this.status,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);
  Map<String, dynamic> toJson() => _$BranchModelToJson(this);
}
