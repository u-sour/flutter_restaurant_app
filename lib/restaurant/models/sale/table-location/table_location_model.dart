import 'package:json_annotation/json_annotation.dart';
part 'table_location_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TableLocationModel {
  @JsonKey(name: '_id', disallowNullValue: true)
  final String id;
  final String table;
  final String floor;
  const TableLocationModel(
      {required this.id, required this.table, required this.floor});

  factory TableLocationModel.fromJson(Map<String, dynamic> json) =>
      _$TableLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$TableLocationModelToJson(this);
}
