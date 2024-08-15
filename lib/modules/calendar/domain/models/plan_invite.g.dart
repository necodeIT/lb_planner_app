// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlanInviteImpl _$$PlanInviteImplFromJson(Map<String, dynamic> json) =>
    _$PlanInviteImpl(
      id: (json['id'] as num).toInt(),
      inviterId: (json['inviterid'] as num).toInt(),
      planId: (json['planid'] as num).toInt(),
      invitedUserId: (json['inviteeid'] as num).toInt(),
      status: $enumDecode(_$PlanInviteStatusEnumMap, json['status']),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$PlanInviteImplToJson(_$PlanInviteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'inviterid': instance.inviterId,
      'planid': instance.planId,
      'inviteeid': instance.invitedUserId,
      'status': _$PlanInviteStatusEnumMap[instance.status]!,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$PlanInviteStatusEnumMap = {
  PlanInviteStatus.pending: 0,
  PlanInviteStatus.accepted: 1,
  PlanInviteStatus.declined: 2,
};
