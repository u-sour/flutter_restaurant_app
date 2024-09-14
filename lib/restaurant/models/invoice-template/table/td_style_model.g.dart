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

Map<String, dynamic> _$TdStyleModelToJson(TdStyleModel instance) {
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
  writeNotNull('font-weight', instance.fontWeight);
  return val;
}
