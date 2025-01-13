// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  /// The id of the user
  @JsonKey(name: 'userid')
  int get id => throw _privateConstructorUsedError;

  /// The username of the user
  String get username => throw _privateConstructorUsedError;

  /// The firstname of the user
  String get firstname => throw _privateConstructorUsedError;

  /// The lastname of the user
  String get lastname => throw _privateConstructorUsedError;

  /// The email address of the user
  String get email => throw _privateConstructorUsedError;

  /// A bitmask of the capabilities the user has
  @JsonKey(name: 'capabilities')
  int get capabilitiesBitMask => throw _privateConstructorUsedError;

  /// The name of the theme the user has selected
  @JsonKey(name: 'theme')
  String get themeName => throw _privateConstructorUsedError;

  /// The language the user has selected
  @JsonKey(name: 'lang')
  String get language => throw _privateConstructorUsedError;

  /// The url of the profile image
  @JsonKey(name: 'profileimageurl')
  String get profileImageUrl => throw _privateConstructorUsedError;

  /// The id of the plan the user is assigned to
  @JsonKey(name: 'planid')
  int get planId => throw _privateConstructorUsedError;

  /// The color blindness of the user as a string
  @JsonKey(name: 'colorblindness')
  String get colorBlindnessString => throw _privateConstructorUsedError;

  /// Whether to display the task count in the calendar view
  @JsonKey(name: 'displaytaskcount')
  int get displayTaskCountInt => throw _privateConstructorUsedError;

  /// The vintage of the user
  Vintage? get vintage => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@JsonKey(name: 'userid') int id,
      String username,
      String firstname,
      String lastname,
      String email,
      @JsonKey(name: 'capabilities') int capabilitiesBitMask,
      @JsonKey(name: 'theme') String themeName,
      @JsonKey(name: 'lang') String language,
      @JsonKey(name: 'profileimageurl') String profileImageUrl,
      @JsonKey(name: 'planid') int planId,
      @JsonKey(name: 'colorblindness') String colorBlindnessString,
      @JsonKey(name: 'displaytaskcount') int displayTaskCountInt,
      Vintage? vintage});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? firstname = null,
    Object? lastname = null,
    Object? email = null,
    Object? capabilitiesBitMask = null,
    Object? themeName = null,
    Object? language = null,
    Object? profileImageUrl = null,
    Object? planId = null,
    Object? colorBlindnessString = null,
    Object? displayTaskCountInt = null,
    Object? vintage = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      firstname: null == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      lastname: null == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      capabilitiesBitMask: null == capabilitiesBitMask
          ? _value.capabilitiesBitMask
          : capabilitiesBitMask // ignore: cast_nullable_to_non_nullable
              as int,
      themeName: null == themeName
          ? _value.themeName
          : themeName // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      planId: null == planId
          ? _value.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as int,
      colorBlindnessString: null == colorBlindnessString
          ? _value.colorBlindnessString
          : colorBlindnessString // ignore: cast_nullable_to_non_nullable
              as String,
      displayTaskCountInt: null == displayTaskCountInt
          ? _value.displayTaskCountInt
          : displayTaskCountInt // ignore: cast_nullable_to_non_nullable
              as int,
      vintage: freezed == vintage
          ? _value.vintage
          : vintage // ignore: cast_nullable_to_non_nullable
              as Vintage?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'userid') int id,
      String username,
      String firstname,
      String lastname,
      String email,
      @JsonKey(name: 'capabilities') int capabilitiesBitMask,
      @JsonKey(name: 'theme') String themeName,
      @JsonKey(name: 'lang') String language,
      @JsonKey(name: 'profileimageurl') String profileImageUrl,
      @JsonKey(name: 'planid') int planId,
      @JsonKey(name: 'colorblindness') String colorBlindnessString,
      @JsonKey(name: 'displaytaskcount') int displayTaskCountInt,
      Vintage? vintage});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? firstname = null,
    Object? lastname = null,
    Object? email = null,
    Object? capabilitiesBitMask = null,
    Object? themeName = null,
    Object? language = null,
    Object? profileImageUrl = null,
    Object? planId = null,
    Object? colorBlindnessString = null,
    Object? displayTaskCountInt = null,
    Object? vintage = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      firstname: null == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String,
      lastname: null == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      capabilitiesBitMask: null == capabilitiesBitMask
          ? _value.capabilitiesBitMask
          : capabilitiesBitMask // ignore: cast_nullable_to_non_nullable
              as int,
      themeName: null == themeName
          ? _value.themeName
          : themeName // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      planId: null == planId
          ? _value.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as int,
      colorBlindnessString: null == colorBlindnessString
          ? _value.colorBlindnessString
          : colorBlindnessString // ignore: cast_nullable_to_non_nullable
              as String,
      displayTaskCountInt: null == displayTaskCountInt
          ? _value.displayTaskCountInt
          : displayTaskCountInt // ignore: cast_nullable_to_non_nullable
              as int,
      vintage: freezed == vintage
          ? _value.vintage
          : vintage // ignore: cast_nullable_to_non_nullable
              as Vintage?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl extends _User {
  _$UserImpl(
      {@JsonKey(name: 'userid') required this.id,
      required this.username,
      required this.firstname,
      required this.lastname,
      this.email = '',
      @JsonKey(name: 'capabilities') this.capabilitiesBitMask = -1,
      @JsonKey(name: 'theme') this.themeName = '',
      @JsonKey(name: 'lang') this.language = '',
      @JsonKey(name: 'profileimageurl') this.profileImageUrl = '',
      @JsonKey(name: 'planid') this.planId = -1,
      @JsonKey(name: 'colorblindness') this.colorBlindnessString = '',
      @JsonKey(name: 'displaytaskcount') this.displayTaskCountInt = 1,
      this.vintage})
      : super._();

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  /// The id of the user
  @override
  @JsonKey(name: 'userid')
  final int id;

  /// The username of the user
  @override
  final String username;

  /// The firstname of the user
  @override
  final String firstname;

  /// The lastname of the user
  @override
  final String lastname;

  /// The email address of the user
  @override
  @JsonKey()
  final String email;

  /// A bitmask of the capabilities the user has
  @override
  @JsonKey(name: 'capabilities')
  final int capabilitiesBitMask;

  /// The name of the theme the user has selected
  @override
  @JsonKey(name: 'theme')
  final String themeName;

  /// The language the user has selected
  @override
  @JsonKey(name: 'lang')
  final String language;

  /// The url of the profile image
  @override
  @JsonKey(name: 'profileimageurl')
  final String profileImageUrl;

  /// The id of the plan the user is assigned to
  @override
  @JsonKey(name: 'planid')
  final int planId;

  /// The color blindness of the user as a string
  @override
  @JsonKey(name: 'colorblindness')
  final String colorBlindnessString;

  /// Whether to display the task count in the calendar view
  @override
  @JsonKey(name: 'displaytaskcount')
  final int displayTaskCountInt;

  /// The vintage of the user
  @override
  final Vintage? vintage;

  @override
  String toString() {
    return 'User(id: $id, username: $username, firstname: $firstname, lastname: $lastname, email: $email, capabilitiesBitMask: $capabilitiesBitMask, themeName: $themeName, language: $language, profileImageUrl: $profileImageUrl, planId: $planId, colorBlindnessString: $colorBlindnessString, displayTaskCountInt: $displayTaskCountInt, vintage: $vintage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.firstname, firstname) ||
                other.firstname == firstname) &&
            (identical(other.lastname, lastname) ||
                other.lastname == lastname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.capabilitiesBitMask, capabilitiesBitMask) ||
                other.capabilitiesBitMask == capabilitiesBitMask) &&
            (identical(other.themeName, themeName) ||
                other.themeName == themeName) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.planId, planId) || other.planId == planId) &&
            (identical(other.colorBlindnessString, colorBlindnessString) ||
                other.colorBlindnessString == colorBlindnessString) &&
            (identical(other.displayTaskCountInt, displayTaskCountInt) ||
                other.displayTaskCountInt == displayTaskCountInt) &&
            (identical(other.vintage, vintage) || other.vintage == vintage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      username,
      firstname,
      lastname,
      email,
      capabilitiesBitMask,
      themeName,
      language,
      profileImageUrl,
      planId,
      colorBlindnessString,
      displayTaskCountInt,
      vintage);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User extends User {
  factory _User(
      {@JsonKey(name: 'userid') required final int id,
      required final String username,
      required final String firstname,
      required final String lastname,
      final String email,
      @JsonKey(name: 'capabilities') final int capabilitiesBitMask,
      @JsonKey(name: 'theme') final String themeName,
      @JsonKey(name: 'lang') final String language,
      @JsonKey(name: 'profileimageurl') final String profileImageUrl,
      @JsonKey(name: 'planid') final int planId,
      @JsonKey(name: 'colorblindness') final String colorBlindnessString,
      @JsonKey(name: 'displaytaskcount') final int displayTaskCountInt,
      final Vintage? vintage}) = _$UserImpl;
  _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  /// The id of the user
  @override
  @JsonKey(name: 'userid')
  int get id;

  /// The username of the user
  @override
  String get username;

  /// The firstname of the user
  @override
  String get firstname;

  /// The lastname of the user
  @override
  String get lastname;

  /// The email address of the user
  @override
  String get email;

  /// A bitmask of the capabilities the user has
  @override
  @JsonKey(name: 'capabilities')
  int get capabilitiesBitMask;

  /// The name of the theme the user has selected
  @override
  @JsonKey(name: 'theme')
  String get themeName;

  /// The language the user has selected
  @override
  @JsonKey(name: 'lang')
  String get language;

  /// The url of the profile image
  @override
  @JsonKey(name: 'profileimageurl')
  String get profileImageUrl;

  /// The id of the plan the user is assigned to
  @override
  @JsonKey(name: 'planid')
  int get planId;

  /// The color blindness of the user as a string
  @override
  @JsonKey(name: 'colorblindness')
  String get colorBlindnessString;

  /// Whether to display the task count in the calendar view
  @override
  @JsonKey(name: 'displaytaskcount')
  int get displayTaskCountInt;

  /// The vintage of the user
  @override
  Vintage? get vintage;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
