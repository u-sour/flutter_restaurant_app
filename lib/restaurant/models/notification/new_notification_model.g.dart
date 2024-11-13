// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewNotificationModel _$NewNotificationModelFromJson(
        Map<String, dynamic> json) =>
    NewNotificationModel(
      newCount: (json['newCount'] as num).toInt(),
      unreadCount: (json['unreadCount'] as num).toInt(),
      lastestDoc: json['lastestDoc'] == null
          ? null
          : NotificationDataModel.fromJson(
              json['lastestDoc'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewNotificationModelToJson(
        NewNotificationModel instance) =>
    <String, dynamic>{
      'newCount': instance.newCount,
      'unreadCount': instance.unreadCount,
      'lastestDoc': instance.lastestDoc?.toJson(),
    };
