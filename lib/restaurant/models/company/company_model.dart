import 'package:json_annotation/json_annotation.dart';
import 'company_accounting_model.dart';
import 'company_general_model.dart';
import 'company_other_model.dart';
part 'company_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final CompanyGeneralModel general;
  final CompanyAccountingModel accounting;
  final CompanyOtherModel other;

  const CompanyModel({
    required this.id,
    required this.general,
    required this.accounting,
    required this.other,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}
