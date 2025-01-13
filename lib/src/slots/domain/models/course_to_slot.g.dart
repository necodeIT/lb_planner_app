// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_to_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseToSlotImpl _$$CourseToSlotImplFromJson(Map<String, dynamic> json) =>
    _$CourseToSlotImpl(
      id: (json['id'] as num).toInt(),
      courseId: (json['courseid'] as num).toInt(),
      slotId: (json['slotid'] as num).toInt(),
      vintage: $enumDecode(_$VintageEnumMap, json['vintage']),
    );

Map<String, dynamic> _$$CourseToSlotImplToJson(_$CourseToSlotImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseid': instance.courseId,
      'slotid': instance.slotId,
      'vintage': _$VintageEnumMap[instance.vintage]!,
    };

const _$VintageEnumMap = {
  Vintage.$1: 1,
  Vintage.$2: 2,
  Vintage.$3: 3,
  Vintage.$4: 4,
  Vintage.$5: 5,
  Vintage.$1ahit: '1AHIT',
  Vintage.$1bhit: '1BHIT',
  Vintage.$1chit: '1CHIT',
  Vintage.$1dhit: '1DHIT',
  Vintage.$2ahit: '2AHIT',
  Vintage.$2bhit: '2BHIT',
  Vintage.$2chit: '2CHIT',
  Vintage.$2dhit: '2DHIT',
  Vintage.$3ahit: '3AHIT',
  Vintage.$3bhit: '3BHIT',
  Vintage.$3chit: '3CHIT',
  Vintage.$3dhit: '3DHIT',
  Vintage.$4ahit: '4AHIT',
  Vintage.$4bhit: '4BHIT',
  Vintage.$4chit: '4CHIT',
  Vintage.$4dhit: '4DHIT',
  Vintage.$5ahit: '5AHIT',
  Vintage.$5bhit: '5BHIT',
  Vintage.$5chit: '5CHIT',
  Vintage.$5dhit: '5DHIT',
};
