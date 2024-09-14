// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LayoutModel _$LayoutModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const [
      'margin-top',
      'margin-bottom',
      'margin-left',
      'margin-right'
    ],
  );
  return LayoutModel(
    marginTop: (json['margin-top'] as num).toDouble(),
    marginBottom: (json['margin-bottom'] as num).toDouble(),
    marginLeft: (json['margin-left'] as num).toDouble(),
    marginRight: (json['margin-right'] as num).toDouble(),
  );
}

Map<String, dynamic> _$LayoutModelToJson(LayoutModel instance) =>
    <String, dynamic>{
      'margin-top': instance.marginTop,
      'margin-bottom': instance.marginBottom,
      'margin-left': instance.marginLeft,
      'margin-right': instance.marginRight,
    };
