// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleCategoryModel _$SaleCategoryModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['_id', 'children'],
  );
  return SaleCategoryModel(
    id: json['_id'] as String,
    name: json['name'] as String,
    level: (json['level'] as num).toInt(),
    icon: json['icon'] as String?,
    children: (json['children'] as List<dynamic>?)
        ?.map((e) => SaleCategoryModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SaleCategoryModelToJson(SaleCategoryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'level': instance.level,
      if (instance.icon case final value?) 'icon': value,
      if (instance.children?.map((e) => e.toJson()).toList() case final value?)
        'children': value,
    };
