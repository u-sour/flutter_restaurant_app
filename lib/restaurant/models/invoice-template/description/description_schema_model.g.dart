// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'description_schema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DescriptionSchemaModel _$DescriptionSchemaModelFromJson(
        Map<String, dynamic> json) =>
    DescriptionSchemaModel(
      showSubLabel: json['showSubLabel'] as bool,
      left: (json['left'] as List<dynamic>)
          .map((e) => DescriptionLeftRightSchemaModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      right: (json['right'] as List<dynamic>)
          .map((e) => DescriptionLeftRightSchemaModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      labelStyle:
          LabelStyleModel.fromJson(json['labelStyle'] as Map<String, dynamic>),
      subLabelStyle: LabelStyleModel.fromJson(
          json['subLabelStyle'] as Map<String, dynamic>),
      valueStyle:
          ValueStyleModel.fromJson(json['valueStyle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DescriptionSchemaModelToJson(
        DescriptionSchemaModel instance) =>
    <String, dynamic>{
      'showSubLabel': instance.showSubLabel,
      'left': instance.left.map((e) => e.toJson()).toList(),
      'right': instance.right.map((e) => e.toJson()).toList(),
      'labelStyle': instance.labelStyle.toJson(),
      'subLabelStyle': instance.subLabelStyle.toJson(),
      'valueStyle': instance.valueStyle.toJson(),
    };
