// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionModel _$OptionModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['icon', 'extra'],
  );
  return OptionModel(
    icon: IconModelConverter.convertIconOptionalForModel(
        json['icon'] as IconData?),
    label: json['label'] as String,
    value: json['value'],
    extra: json['extra'],
  );
}

Map<String, dynamic> _$OptionModelToJson(OptionModel instance) =>
    <String, dynamic>{
      if (IconModelConverter.convertIconOptionalForModel(instance.icon)
          case final value?)
        'icon': value,
      'label': instance.label,
      'value': instance.value,
      if (instance.extra case final value?) 'extra': value,
    };
