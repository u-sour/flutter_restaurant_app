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

Map<String, dynamic> _$WrapperStyleModelToJson(WrapperStyleModel instance) =>
    <String, dynamic>{
      if (instance.paddingTop case final value?) 'padding-top': value,
      if (instance.borderTopStyle case final value?) 'border-top-style': value,
    };
