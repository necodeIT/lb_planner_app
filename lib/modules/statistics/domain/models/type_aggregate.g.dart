// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TypeAggregateImpl _$$TypeAggregateImplFromJson(Map<String, dynamic> json) =>
    _$TypeAggregateImpl(
      required: (json['required'] as num).toInt(),
      optional: (json['optional'] as num).toInt(),
      compensation: (json['compensation'] as num).toInt(),
      exam: (json['exam'] as num).toInt(),
      none: (json['none'] as num).toInt(),
    );

Map<String, dynamic> _$$TypeAggregateImplToJson(_$TypeAggregateImpl instance) =>
    <String, dynamic>{
      'required': instance.required,
      'optional': instance.optional,
      'compensation': instance.compensation,
      'exam': instance.exam,
      'none': instance.none,
    };
