// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlanMemberImpl _$$PlanMemberImplFromJson(Map<String, dynamic> json) =>
    _$PlanMemberImpl(
      id: (json['userid'] as num).toInt(),
      accessType:
          $enumDecode(_$PlanMemberAccessTypeEnumMap, json['accesstype']),
    );

Map<String, dynamic> _$$PlanMemberImplToJson(_$PlanMemberImpl instance) =>
    <String, dynamic>{
      'userid': instance.id,
      'accesstype': _$PlanMemberAccessTypeEnumMap[instance.accessType]!,
    };

const _$PlanMemberAccessTypeEnumMap = {
  PlanMemberAccessType.owner: 0,
  PlanMemberAccessType.write: 1,
  PlanMemberAccessType.read: 2,
};
