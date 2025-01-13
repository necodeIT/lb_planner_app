// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['userid'] as num).toInt(),
      username: json['username'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String? ?? '',
      capabilitiesBitMask: (json['capabilities'] as num?)?.toInt() ?? -1,
      themeName: json['theme'] as String? ?? '',
      language: json['lang'] as String? ?? '',
      profileImageUrl: json['profileimageurl'] as String? ?? '',
      planId: (json['planid'] as num?)?.toInt() ?? -1,
      colorBlindnessString: json['colorblindness'] as String? ?? '',
      displayTaskCountInt: (json['displaytaskcount'] as num?)?.toInt() ?? 1,
      vintage: $enumDecodeNullable(_$VintageEnumMap, json['vintage']),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'userid': instance.id,
      'username': instance.username,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'capabilities': instance.capabilitiesBitMask,
      'theme': instance.themeName,
      'lang': instance.language,
      'profileimageurl': instance.profileImageUrl,
      'planid': instance.planId,
      'colorblindness': instance.colorBlindnessString,
      'displaytaskcount': instance.displayTaskCountInt,
      'vintage': _$VintageEnumMap[instance.vintage],
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
