// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => NotificationDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      unreadCount: (json['unreadCount'] as num).toInt(),
      newCount: (json['newCount'] as num).toInt(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'unreadCount': instance.unreadCount,
      'newCount': instance.newCount,
      'type': instance.type,
    };