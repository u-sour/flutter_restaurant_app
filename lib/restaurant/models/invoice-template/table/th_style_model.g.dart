// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'th_style_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThStyleModel _$ThStyleModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const [
      'font-size',
      'padding-top',
      'padding-bottom',
      'padding-left',
      'padding-right',
      'line-height',
      'width'
    ],
  );
  return ThStyleModel(
    fontSize: (json['font-size'] as num?)?.toDouble(),
    paddingTop: (json['padding-top'] as num?)?.toDouble(),
    paddingBottom: (json['padding-bottom'] as num?)?.toDouble(),
    paddingLeft: (json['padding-left'] as num?)?.toDouble(),
    paddingRight: (json['padding-right'] as num?)?.toDouble(),
    lineHeight: json['line-height'] as String?,
    width: (json['width'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$ThStyleModelToJson(ThStyleModel instance) =>
    <String, dynamic>{
      if (instance.fontSize case final value?) 'font-size': value,
      if (instance.paddingTop case final value?) 'padding-top': value,
      if (instance.paddingBottom case final value?) 'padding-bottom': value,
      if (instance.paddingLeft case final value?) 'padding-left': value,
      if (instance.paddingRight case final value?) 'padding-right': value,
      if (instance.lineHeight case final value?) 'line-height': value,
      if (instance.width case final value?) 'width': value,
    };
