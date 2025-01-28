// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SlotImpl _$$SlotImplFromJson(Map<String, dynamic> json) => _$SlotImpl(
      id: (json['id'] as num).toInt(),
      startUnit: $enumDecode(_$SlotTimeUnitEnumMap, json['startunit']),
      duration: (json['duration'] as num).toInt(),
      weekday: $enumDecode(_$WeekdayEnumMap, json['weekday']),
      room: json['room'] as String,
      size: (json['size'] as num).toInt(),
      reservations: (json['fullness'] as num).toInt(),
      reserved: json['forcuruser'] as bool,
      supervisors: (json['supervisors'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      mappings: (json['filters'] as List<dynamic>?)
              ?.map((e) => CourseToSlot.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SlotImplToJson(_$SlotImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startunit': _$SlotTimeUnitEnumMap[instance.startUnit]!,
      'duration': instance.duration,
      'weekday': _$WeekdayEnumMap[instance.weekday]!,
      'room': instance.room,
      'size': instance.size,
      'fullness': instance.reservations,
      'forcuruser': instance.reserved,
      'supervisors': instance.supervisors,
      'filters': instance.mappings.map((e) => e.toJson()).toList(),
    };

const _$SlotTimeUnitEnumMap = {
  SlotTimeUnit.$1: 1,
  SlotTimeUnit.$2: 2,
  SlotTimeUnit.$3: 3,
  SlotTimeUnit.$4: 4,
  SlotTimeUnit.$5: 5,
  SlotTimeUnit.$6: 6,
  SlotTimeUnit.$7: 7,
  SlotTimeUnit.$8: 8,
  SlotTimeUnit.$9: 9,
  SlotTimeUnit.$10: 10,
  SlotTimeUnit.$11: 11,
  SlotTimeUnit.$12: 12,
  SlotTimeUnit.$13: 13,
  SlotTimeUnit.$14: 14,
  SlotTimeUnit.$15: 15,
  SlotTimeUnit.$16: 16,
};

const _$WeekdayEnumMap = {
  Weekday.monday: 1,
  Weekday.tuesday: 2,
  Weekday.wednesday: 3,
  Weekday.thursday: 4,
  Weekday.friday: 5,
  Weekday.saturday: 6,
  Weekday.sunday: 7,
};
