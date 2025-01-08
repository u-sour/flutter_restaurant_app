// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'td_style_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TdStyleModel _$TdStyleModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const [
      'font-size',
      'padding-top',
      'padding-bottom',
      'padding-left',
      'padding-right',
      'font-weight'
    ],
  );
  return TdStyleModel(
    fontSize: (json['font-size'] as num?)?.toDouble(),
    paddingTop: (json['padding-top'] as num?)?.toDouble(),
    paddingBottom: (json['padding-bottom'] as num?)?.toDouble(),
    paddingLeft: (json['padding-left'] as num?)?.toDouble(),
    paddingRight: (json['padding-right'] as num?)?.toDouble(),
    fontWeight: json['font-weight'] as String?,
  );
}

Map<String, dynamic> _$TdStyleModelToJson(TdStyleModel instance) =>
    <String, dynamic>{
      if (instance.fontSize case final value?) 'font-size': value,
      if (instance.paddingTop case final value?) 'padding-top': value,
      if (instance.paddingBottom case final value?) 'padding-bottom': value,
      if (instance.paddingLeft case final value?) 'padding-left': value,
      if (instance.paddingRight case final value?) 'padding-right': value,
      if (instance.fontWeight case final value?) 'font-weight': value,
    };
