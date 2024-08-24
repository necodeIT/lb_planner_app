// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moodle_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MoodleTaskImpl _$$MoodleTaskImplFromJson(Map<String, dynamic> json) =>
    _$MoodleTaskImpl(
      id: (json['moduleid'] as num).toInt(),
      name: json['name'] as String,
      courseId: (json['courseid'] as num).toInt(),
      status: $enumDecode(_$MoodleTaskStatusEnumMap, json['status']),
      type: $enumDecode(_$MoodleTaskTypeEnumMap, json['type']),
      deadline: const UnixTimestampConverter()
          .fromJson((json['deadline'] as num).toInt()),
      url: json['url'] as String,
    );

Map<String, dynamic> _$$MoodleTaskImplToJson(_$MoodleTaskImpl instance) =>
    <String, dynamic>{
      'moduleid': instance.id,
      'name': instance.name,
      'courseid': instance.courseId,
      'status': _$MoodleTaskStatusEnumMap[instance.status]!,
      'type': _$MoodleTaskTypeEnumMap[instance.type]!,
      'deadline': const UnixTimestampConverter().toJson(instance.deadline),
      'url': instance.url,
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
