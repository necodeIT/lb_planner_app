// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moodle_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MoodleCourseImpl _$$MoodleCourseImplFromJson(Map<String, dynamic> json) =>
    _$MoodleCourseImpl(
      id: (json['courseid'] as num).toInt(),
      color: const HexColorConverter().fromJson(json['color'] as String),
      name: json['name'] as String,
      shortname: json['shortname'] as String,
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$$MoodleCourseImplToJson(_$MoodleCourseImpl instance) =>
    <String, dynamic>{
      'courseid': instance.id,
      'color': const HexColorConverter().toJson(instance.color),
      'name': instance.name,
      'shortname': instance.shortname,
      'enabled': instance.enabled,
    };
