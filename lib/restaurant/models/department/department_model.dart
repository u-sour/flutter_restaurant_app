import 'package:json_annotation/json_annotation.dart';
import '../../utils/model_converter/date_model_converter.dart';
part 'department_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DepartmentModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String branchId;
  final String name;
  final bool? isolateInvoice;
  @JsonKey(disallowNullValue: true)
  final List<String>? printerForBill;
  @JsonKey(disallowNullValue: true)
  final List<String>? printerForPayment;
  final String? telephone;
  @JsonKey(
      fromJson: DateModelConverter.convertDateTimeForModel,
      toJson: DateModelConverter.convertDateTimeForModel)
  final DateTime createdAt;
  @JsonKey(
    disallowNullValue: true,
    fromJson: DateModelConverter.convertDateTimeOptionalForModel,
    toJson: DateModelConverter.convertDateTimeOptionalForModel,
  )
  final DateTime? updatedAt;
  @JsonKey(disallowNullValue: true)
  final String? updatedBy;

  const DepartmentModel({
    required this.id,
    required this.branchId,
    required this.name,
    this.isolateInvoice,
    this.printerForBill,
    this.printerForPayment,
    this.telephone,
    required this.createdAt,
    this.updatedAt,
    this.updatedBy,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentModelFromJson(json);
  Map<String, dynamic> toJson() => _$DepartmentModelToJson(this);
}
