// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_deadline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlanDeadlineImpl _$$PlanDeadlineImplFromJson(Map<String, dynamic> json) =>
    _$PlanDeadlineImpl(
      id: (json['moduleid'] as num).toInt(),
      start: const UnixTimestampConverter()
          .fromJson((json['deadlinestart'] as num).toInt()),
      end: const UnixTimestampConverter()
          .fromJson((json['deadlineend'] as num).toInt()),
    );

Map<String, dynamic> _$$PlanDeadlineImplToJson(_$PlanDeadlineImpl instance) =>
    <String, dynamic>{
      'moduleid': instance.id,
      'deadlinestart': const UnixTimestampConverter().toJson(instance.start),
      'deadlineend': const UnixTimestampConverter().toJson(instance.end),
    };
