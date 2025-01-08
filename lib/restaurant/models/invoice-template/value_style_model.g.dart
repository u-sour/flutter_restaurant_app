// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'value_style_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValueStyleModel _$ValueStyleModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const [
      'font-size',
      'font-weight',
      'margin-top',
      'margin-bottom',
      'width',
      'border-radius'
    ],
  );
  return ValueStyleModel(
    fontSize: (json['font-size'] as num?)?.toDouble(),
    fontWeight: json['font-weight'] as String?,
    marginTop: (json['margin-top'] as num?)?.toDouble(),
    marginBottom: (json['margin-bottom'] as num?)?.toDouble(),
    width: (json['width'] as num?)?.toDouble(),
    borderRadius: json['border-radius'] as String?,
  );
}

Map<String, dynamic> _$ValueStyleModelToJson(ValueStyleModel instance) =>
    <String, dynamic>{
      if (instance.fontSize case final value?) 'font-size': value,
      if (instance.fontWeight case final value?) 'font-weight': value,
      if (instance.marginTop case final value?) 'margin-top': value,
      if (instance.marginBottom case final value?) 'margin-bottom': value,
      if (instance.width case final value?) 'width': value,
      if (instance.borderRadius case final value?) 'border-radius': value,
    };
