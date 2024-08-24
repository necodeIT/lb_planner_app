// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationImpl _$$NotificationImplFromJson(Map<String, dynamic> json) =>
    _$NotificationImpl(
      id: (json['notificationid'] as num).toInt(),
      timestamp: const UnixTimestampConverter()
          .fromJson((json['timestamp'] as num).toInt()),
      readAt: _$JsonConverterFromJson<int, DateTime>(
          json['timestamp_read'], const UnixTimestampConverter().fromJson),
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      read: const BoolConverter().fromJson(json['status'] as num),
      userId: (json['userid'] as num).toInt(),
    );

Map<String, dynamic> _$$NotificationImplToJson(_$NotificationImpl instance) =>
    <String, dynamic>{
      'notificationid': instance.id,
      'timestamp': const UnixTimestampConverter().toJson(instance.timestamp),
      'timestamp_read': _$JsonConverterToJson<int, DateTime>(
          instance.readAt, const UnixTimestampConverter().toJson),
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'status': const BoolConverter().toJson(instance.read),
      'userid': instance.userId,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$NotificationTypeEnumMap = {
  NotificationType.invite: 0,
  NotificationType.inviteAccepted: 1,
  NotificationType.inviteDeclined: 2,
  NotificationType.planLeft: 3,
  NotificationType.planRemoved: 4,
  NotificationType.newUser: 5,
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
