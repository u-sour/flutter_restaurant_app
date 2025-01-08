// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'container_style_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContainerStyleModel _$ContainerStyleModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['top'],
  );
  return ContainerStyleModel(
    marginTop: (json['top'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$ContainerStyleModelToJson(
        ContainerStyleModel instance) =>
    <String, dynamic>{
      if (instance.marginTop case final value?) 'top': value,
    };
