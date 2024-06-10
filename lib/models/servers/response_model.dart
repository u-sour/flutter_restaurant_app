import 'package:json_annotation/json_annotation.dart';
part 'response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseModel {
  final int status;
  final String message;

  const ResponseModel({
    required this.status,
    required this.message,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
