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
      capabilitiesBitMask: (json['capabilities'] as num?)?.toInt() ?? -1,
      themeName: json['theme'] as String? ?? '',
      language: json['lang'] as String? ?? '',
      profileImageUrl: json['profileimageurl'] as String? ?? '',
      planId: (json['planid'] as num?)?.toInt() ?? -1,
      colorBlindnessString: json['colorblindness'] as String? ?? '',
      displayTaskCountInt: (json['displaytaskcount'] as num?)?.toInt() ?? 1,
      vintage: json['vintage'] as String? ?? '',
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'userid': instance.id,
      'username': instance.username,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'capabilities': instance.capabilitiesBitMask,
      'theme': instance.themeName,
      'lang': instance.language,
      'profileimageurl': instance.profileImageUrl,
      'planid': instance.planId,
      'colorblindness': instance.colorBlindnessString,
      'displaytaskcount': instance.displayTaskCountInt,
      'vintage': instance.vintage,
    };
