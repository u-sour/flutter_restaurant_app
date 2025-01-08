// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectOptionModel _$SelectOptionModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['icon', 'extra'],
  );
  return SelectOptionModel(
    icon: IconModelConverter.convertIconOptionalForModel(
        json['icon'] as IconData?),
    label: json['label'] as String,
    value: json['value'],
    extra: json['extra'],
  );
}

Map<String, dynamic> _$SelectOptionModelToJson(SelectOptionModel instance) =>
    <String, dynamic>{
      if (IconModelConverter.convertIconOptionalForModel(instance.icon)
          case final value?)
        'icon': value,
      'label': instance.label,
      'value': instance.value,
      if (instance.extra case final value?) 'extra': value,
    };
