// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moodle_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MoodleTaskImpl _$$MoodleTaskImplFromJson(Map<String, dynamic> json) =>
    _$MoodleTaskImpl(
      id: (json['assignid'] as num).toInt(),
      cmid: (json['cmid '] as num).toInt(),
      name: json['name'] as String,
      courseId: (json['courseid'] as num).toInt(),
      status: $enumDecode(_$MoodleTaskStatusEnumMap, json['status']),
      type: $enumDecode(_$MoodleTaskTypeEnumMap, json['type']),
      deadline: _$JsonConverterFromJson<int, DateTime>(
          json['deadline'], const UnixTimestampConverter().fromJson),
    );

Map<String, dynamic> _$$MoodleTaskImplToJson(_$MoodleTaskImpl instance) =>
    <String, dynamic>{
      'assignid': instance.id,
      'cmid ': instance.cmid,
      'name': instance.name,
      'courseid': instance.courseId,
      'status': _$MoodleTaskStatusEnumMap[instance.status]!,
      'type': _$MoodleTaskTypeEnumMap[instance.type]!,
      'deadline': _$JsonConverterToJson<int, DateTime>(
          instance.deadline, const UnixTimestampConverter().toJson),
    };

const _$MoodleTaskStatusEnumMap = {
  MoodleTaskStatus.done: 0,
  MoodleTaskStatus.uploaded: 1,
  MoodleTaskStatus.late: 2,
  MoodleTaskStatus.pending: 3,
};

const _$MoodleTaskTypeEnumMap = {
  MoodleTaskType.required: 0,
  MoodleTaskType.optional: 1,
  MoodleTaskType.exam: 2,
  MoodleTaskType.compensation: 3,
  MoodleTaskType.none: 4,
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
