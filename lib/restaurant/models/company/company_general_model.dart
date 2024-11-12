import 'package:json_annotation/json_annotation.dart';
part 'company_general_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyGeneralModel {
  final String name;
  final String address;
  final String? telephone;
  final String? email;
  final String? website;
  final String industry;

  const CompanyGeneralModel({
    required this.name,
    required this.address,
    this.telephone,
    this.email,
    this.website,
    required this.industry,
  });

  factory CompanyGeneralModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyGeneralModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyGeneralModelToJson(this);
}
