import 'package:json_annotation/json_annotation.dart';
part 'company_other_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyOtherModel {
  final String dateFormat;
  final String lang;
  final int inactiveInMinute;

  const CompanyOtherModel({
    required this.dateFormat,
    required this.lang,
    required this.inactiveInMinute,
  });

  factory CompanyOtherModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyOtherModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyOtherModelToJson(this);
}
