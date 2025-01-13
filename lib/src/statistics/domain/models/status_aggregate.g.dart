// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StatusAggregateImpl _$$StatusAggregateImplFromJson(
        Map<String, dynamic> json) =>
    _$StatusAggregateImpl(
      done: (json['done'] as num).toInt(),
      pending: (json['pending'] as num).toInt(),
      uploaded: (json['uploaded'] as num).toInt(),
      late: (json['late'] as num).toInt(),
    );

Map<String, dynamic> _$$StatusAggregateImplToJson(
        _$StatusAggregateImpl instance) =>
    <String, dynamic>{
      'done': instance.done,
      'pending': instance.pending,
      'uploaded': instance.uploaded,
      'late': instance.late,
    };
