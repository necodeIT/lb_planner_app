// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenImpl _$$TokenImplFromJson(Map<String, dynamic> json) => _$TokenImpl(
      token: json['token'] as String,
      webservice: $enumDecode(_$WebserviceEnumMap, json['webservice']),
    );

Map<String, dynamic> _$$TokenImplToJson(_$TokenImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'webservice': _$WebserviceEnumMap[instance.webservice]!,
    };

const _$WebserviceEnumMap = {
  Webservice.moodle_mobile_app: 'moodle_mobile_app',
  Webservice.lb_planner_api: 'lb_planner_api',
};
