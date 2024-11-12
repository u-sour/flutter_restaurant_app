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

Map<String, dynamic> _$OptionModelToJson(OptionModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'icon', IconModelConverter.convertIconOptionalForModel(instance.icon));
  val['label'] = instance.label;
  val['value'] = instance.value;
  writeNotNull('extra', instance.extra);
  return val;
}
