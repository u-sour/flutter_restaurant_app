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

Map<String, dynamic> _$ThStyleModelToJson(ThStyleModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('font-size', instance.fontSize);
  writeNotNull('padding-top', instance.paddingTop);
  writeNotNull('padding-bottom', instance.paddingBottom);
  writeNotNull('padding-left', instance.paddingLeft);
  writeNotNull('padding-right', instance.paddingRight);
  writeNotNull('line-height', instance.lineHeight);
  writeNotNull('width', instance.width);
  return val;
}
