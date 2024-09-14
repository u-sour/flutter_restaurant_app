// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrapper_style_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WrapperStyleModel _$WrapperStyleModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['padding-top', 'border-top-style'],
  );
  return WrapperStyleModel(
    paddingTop: (json['padding-top'] as num?)?.toDouble(),
    borderTopStyle: json['border-top-style'] as String?,
  );
}

Map<String, dynamic> _$WrapperStyleModelToJson(WrapperStyleModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('padding-top', instance.paddingTop);
  writeNotNull('border-top-style', instance.borderTopStyle);
  return val;
}
