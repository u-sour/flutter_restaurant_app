// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_style_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabelStyleModel _$LabelStyleModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const [
      'font-size',
      'font-weight',
      'line-height',
      'justify-content',
      'text-align',
      'margin-right',
      'padding-top',
      'padding-right',
      'padding-bottom'
    ],
  );
  return LabelStyleModel(
    fontSize: (json['font-size'] as num?)?.toDouble(),
    fontWeight: json['font-weight'] as String?,
    lineHeight: json['line-height'] as String?,
    justifyContent: json['justify-content'] as String?,
    textAlign: json['text-align'] as String?,
    paddingTop: (json['padding-top'] as num?)?.toDouble(),
    paddingRight: (json['padding-right'] as num?)?.toDouble(),
    paddingBottom: (json['padding-bottom'] as num?)?.toDouble(),
    marginRight: (json['margin-right'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$LabelStyleModelToJson(LabelStyleModel instance) =>
    <String, dynamic>{
      if (instance.fontSize case final value?) 'font-size': value,
      if (instance.fontWeight case final value?) 'font-weight': value,
      if (instance.lineHeight case final value?) 'line-height': value,
      if (instance.justifyContent case final value?) 'justify-content': value,
      if (instance.textAlign case final value?) 'text-align': value,
      if (instance.marginRight case final value?) 'margin-right': value,
      if (instance.paddingTop case final value?) 'padding-top': value,
      if (instance.paddingRight case final value?) 'padding-right': value,
      if (instance.paddingBottom case final value?) 'padding-bottom': value,
    };
