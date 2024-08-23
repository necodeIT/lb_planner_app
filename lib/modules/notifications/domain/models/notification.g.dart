// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationImpl _$$NotificationImplFromJson(Map<String, dynamic> json) =>
    _$NotificationImpl(
      id: (json['notificationid'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      readAt: const UnixTimestampConverter()
          .fromJson((json['timestamp_read'] as num?)?.toInt()),
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      read: const BoolConverter().fromJson(json['status'] as num),
      userId: (json['userid'] as num).toInt(),
    );

Map<String, dynamic> _$$NotificationImplToJson(_$NotificationImpl instance) =>
    <String, dynamic>{
      'notificationid': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'timestamp_read': const UnixTimestampConverter().toJson(instance.readAt),
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'status': const BoolConverter().toJson(instance.read),
      'userid': instance.userId,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.invite: 0,
  NotificationType.inviteAccepted: 1,
  NotificationType.inviteDeclined: 2,
  NotificationType.planLeft: 3,
  NotificationType.planRemoved: 4,
  NotificationType.newUser: 5,
};
