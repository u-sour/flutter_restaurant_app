import 'package:flutter_template/restaurant/models/department/department_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'table_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TableModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String name;
  final String floorId;
  final String floorName;
  final int numOfGuest;
  final String branchId;
  final DepartmentModel department;
  final String label;
  final String location;
  final String order;
  @JsonKey(disallowNullValue: true)
  int? currentGuestCount;
  @JsonKey(disallowNullValue: true)
  String? status;

  TableModel({
    required this.id,
    required this.name,
    required this.floorId,
    required this.floorName,
    required this.numOfGuest,
    required this.branchId,
    required this.department,
    required this.label,
    required this.location,
    required this.order,
    this.currentGuestCount,
    this.status,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) =>
      _$TableModelFromJson(json);
  Map<String, dynamic> toJson() => _$TableModelToJson(this);

  set setCurrentGuestCount(int value) {
    currentGuestCount = value;
  }

  set setStatus(String value) {
    status = value;
  }
}
