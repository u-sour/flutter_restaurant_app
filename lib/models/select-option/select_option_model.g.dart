// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectOptionModel _$SelectOptionModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['icon'],
  );
  return SelectOptionModel(
    icon: IconModelConverter.convertIconOptionalForModel(
        json['icon'] as IconData?),
    label: json['label'] as String,
    value: json['value'],
    extra: json['extra'],
  );
}

Map<String, dynamic> _$SelectOptionModelToJson(SelectOptionModel instance) {
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
  val['extra'] = instance.extra;
  return val;
}
