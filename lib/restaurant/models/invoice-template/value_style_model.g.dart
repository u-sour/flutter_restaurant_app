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

Map<String, dynamic> _$ValueStyleModelToJson(ValueStyleModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('font-size', instance.fontSize);
  writeNotNull('font-weight', instance.fontWeight);
  writeNotNull('margin-top', instance.marginTop);
  writeNotNull('margin-bottom', instance.marginBottom);
  writeNotNull('width', instance.width);
  writeNotNull('border-radius', instance.borderRadius);
  return val;
}
