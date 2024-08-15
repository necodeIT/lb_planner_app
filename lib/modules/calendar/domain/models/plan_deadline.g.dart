// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_deadline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlanDeadlineImpl _$$PlanDeadlineImplFromJson(Map<String, dynamic> json) =>
    _$PlanDeadlineImpl(
      id: (json['moduleid'] as num).toInt(),
      start: DateTime.parse(json['deadlinestart'] as String),
      end: DateTime.parse(json['deadlineend'] as String),
    );

Map<String, dynamic> _$$PlanDeadlineImplToJson(_$PlanDeadlineImpl instance) =>
    <String, dynamic>{
      'moduleid': instance.id,
      'deadlinestart': instance.start.toIso8601String(),
      'deadlineend': instance.end.toIso8601String(),
    };
