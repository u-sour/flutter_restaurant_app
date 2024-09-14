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

Map<String, dynamic> _$LabelStyleModelToJson(LabelStyleModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('font-size', instance.fontSize);
  writeNotNull('font-weight', instance.fontWeight);
  writeNotNull('line-height', instance.lineHeight);
  writeNotNull('justify-content', instance.justifyContent);
  writeNotNull('text-align', instance.textAlign);
  writeNotNull('margin-right', instance.marginRight);
  writeNotNull('padding-top', instance.paddingTop);
  writeNotNull('padding-right', instance.paddingRight);
  writeNotNull('padding-bottom', instance.paddingBottom);
  return val;
}
