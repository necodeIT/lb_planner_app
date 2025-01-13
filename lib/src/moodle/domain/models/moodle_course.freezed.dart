// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moodle_course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MoodleCourse _$MoodleCourseFromJson(Map<String, dynamic> json) {
  return _MoodleCourse.fromJson(json);
}

/// @nodoc
mixin _$MoodleCourse {
  /// The ID of this course.
  @JsonKey(name: 'courseid')
  int get id => throw _privateConstructorUsedError;

  /// The color of this course in hexadecimal format.
  @HexColorConverter()
  Color get color => throw _privateConstructorUsedError;

  /// The name of this course.
  String get name => throw _privateConstructorUsedError;

  /// The shortname chosen by the user for this course.
  /// Limited to 5 characters.
  String get shortname => throw _privateConstructorUsedError;

  /// Whether the user want's the app to track this course.
  @BoolConverter()
  bool get enabled => throw _privateConstructorUsedError;

  /// Serializes this MoodleCourse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MoodleCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MoodleCourseCopyWith<MoodleCourse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoodleCourseCopyWith<$Res> {
  factory $MoodleCourseCopyWith(
          MoodleCourse value, $Res Function(MoodleCourse) then) =
      _$MoodleCourseCopyWithImpl<$Res, MoodleCourse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'courseid') int id,
      @HexColorConverter() Color color,
      String name,
      String shortname,
      @BoolConverter() bool enabled});
}

/// @nodoc
class _$MoodleCourseCopyWithImpl<$Res, $Val extends MoodleCourse>
    implements $MoodleCourseCopyWith<$Res> {
  _$MoodleCourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MoodleCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? color = null,
    Object? name = null,
    Object? shortname = null,
    Object? enabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      shortname: null == shortname
          ? _value.shortname
          : shortname // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoodleCourseImplCopyWith<$Res>
    implements $MoodleCourseCopyWith<$Res> {
  factory _$$MoodleCourseImplCopyWith(
          _$MoodleCourseImpl value, $Res Function(_$MoodleCourseImpl) then) =
      __$$MoodleCourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'courseid') int id,
      @HexColorConverter() Color color,
      String name,
      String shortname,
      @BoolConverter() bool enabled});
}

/// @nodoc
class __$$MoodleCourseImplCopyWithImpl<$Res>
    extends _$MoodleCourseCopyWithImpl<$Res, _$MoodleCourseImpl>
    implements _$$MoodleCourseImplCopyWith<$Res> {
  __$$MoodleCourseImplCopyWithImpl(
      _$MoodleCourseImpl _value, $Res Function(_$MoodleCourseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MoodleCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? color = null,
    Object? name = null,
    Object? shortname = null,
    Object? enabled = null,
  }) {
    return _then(_$MoodleCourseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      shortname: null == shortname
          ? _value.shortname
          : shortname // ignore: cast_nullable_to_non_nullable
              as String,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoodleCourseImpl extends _MoodleCourse {
  const _$MoodleCourseImpl(
      {@JsonKey(name: 'courseid') required this.id,
      @HexColorConverter() required this.color,
      required this.name,
      required this.shortname,
      @BoolConverter() required this.enabled})
      : super._();

  factory _$MoodleCourseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MoodleCourseImplFromJson(json);

  /// The ID of this course.
  @override
  @JsonKey(name: 'courseid')
  final int id;

  /// The color of this course in hexadecimal format.
  @override
  @HexColorConverter()
  final Color color;

  /// The name of this course.
  @override
  final String name;

  /// The shortname chosen by the user for this course.
  /// Limited to 5 characters.
  @override
  final String shortname;

  /// Whether the user want's the app to track this course.
  @override
  @BoolConverter()
  final bool enabled;

  @override
  String toString() {
    return 'MoodleCourse(id: $id, color: $color, name: $name, shortname: $shortname, enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoodleCourseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.shortname, shortname) ||
                other.shortname == shortname) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, color, name, shortname, enabled);

  /// Create a copy of MoodleCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MoodleCourseImplCopyWith<_$MoodleCourseImpl> get copyWith =>
      __$$MoodleCourseImplCopyWithImpl<_$MoodleCourseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoodleCourseImplToJson(
      this,
    );
  }
}

abstract class _MoodleCourse extends MoodleCourse {
  const factory _MoodleCourse(
      {@JsonKey(name: 'courseid') required final int id,
      @HexColorConverter() required final Color color,
      required final String name,
      required final String shortname,
      @BoolConverter() required final bool enabled}) = _$MoodleCourseImpl;
  const _MoodleCourse._() : super._();

  factory _MoodleCourse.fromJson(Map<String, dynamic> json) =
      _$MoodleCourseImpl.fromJson;

  /// The ID of this course.
  @override
  @JsonKey(name: 'courseid')
  int get id;

  /// The color of this course in hexadecimal format.
  @override
  @HexColorConverter()
  Color get color;

  /// The name of this course.
  @override
  String get name;

  /// The shortname chosen by the user for this course.
  /// Limited to 5 characters.
  @override
  String get shortname;

  /// Whether the user want's the app to track this course.
  @override
  @BoolConverter()
  bool get enabled;

  /// Create a copy of MoodleCourse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MoodleCourseImplCopyWith<_$MoodleCourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
