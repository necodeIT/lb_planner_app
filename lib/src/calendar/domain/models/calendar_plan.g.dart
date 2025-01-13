// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarPlanImpl _$$CalendarPlanImplFromJson(Map<String, dynamic> json) =>
    _$CalendarPlanImpl(
      name: json['name'] as String,
      id: (json['planid'] as num).toInt(),
      optionalTasksEnabled: const BoolConverter().fromJson(json['enableek']),
      deadlines: (json['deadlines'] as List<dynamic>)
          .map((e) => PlanDeadline.fromJson(e as Map<String, dynamic>))
          .toList(),
      members: (json['members'] as List<dynamic>)
          .map((e) => PlanMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CalendarPlanImplToJson(_$CalendarPlanImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'planid': instance.id,
      'enableek': const BoolConverter().toJson(instance.optionalTasksEnabled),
      'deadlines': instance.deadlines.map((e) => e.toJson()).toList(),
      'members': instance.members.map((e) => e.toJson()).toList(),
    };
