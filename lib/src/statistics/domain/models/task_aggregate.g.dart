// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskAggregateImpl _$$TaskAggregateImplFromJson(Map<String, dynamic> json) =>
    _$TaskAggregateImpl(
      status: StatusAggregate.fromJson(json['status'] as Map<String, dynamic>),
      type: TypeAggregate.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TaskAggregateImplToJson(_$TaskAggregateImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'type': instance.type,
    };
