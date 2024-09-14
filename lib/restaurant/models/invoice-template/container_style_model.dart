import 'package:json_annotation/json_annotation.dart';
part 'container_style_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ContainerStyleModel {
  @JsonKey(name: 'top', disallowNullValue: true)
  final double? marginTop;

  const ContainerStyleModel({this.marginTop});

  factory ContainerStyleModel.fromJson(Map<String, dynamic> json) =>
      _$ContainerStyleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContainerStyleModelToJson(this);
}
