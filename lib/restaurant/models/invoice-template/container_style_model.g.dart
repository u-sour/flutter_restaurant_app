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

Map<String, dynamic> _$ContainerStyleModelToJson(ContainerStyleModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('top', instance.marginTop);
  return val;
}
