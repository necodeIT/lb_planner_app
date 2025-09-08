// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_to_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CourseToSlot _$CourseToSlotFromJson(Map<String, dynamic> json) {
  return _CourseToSlot.fromJson(json);
}

/// @nodoc
mixin _$CourseToSlot {
  /// Unique identifier of this mapping.
  int get id => throw _privateConstructorUsedError;

  /// The id of the course.
  @JsonKey(name: 'courseid')
  int get courseId => throw _privateConstructorUsedError;

  /// The id of the slot.
  @JsonKey(name: 'slotid')
  int get slotId => throw _privateConstructorUsedError;

  /// The vintage a user must be in to attend this slot.
  Vintage get vintage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseToSlotCopyWith<CourseToSlot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseToSlotCopyWith<$Res> {
  factory $CourseToSlotCopyWith(
          CourseToSlot value, $Res Function(CourseToSlot) then) =
      _$CourseToSlotCopyWithImpl<$Res, CourseToSlot>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'courseid') int courseId,
      @JsonKey(name: 'slotid') int slotId,
      Vintage vintage});
}

/// @nodoc
class _$CourseToSlotCopyWithImpl<$Res, $Val extends CourseToSlot>
    implements $CourseToSlotCopyWith<$Res> {
  _$CourseToSlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? slotId = null,
    Object? vintage = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as int,
      slotId: null == slotId
          ? _value.slotId
          : slotId // ignore: cast_nullable_to_non_nullable
              as int,
      vintage: null == vintage
          ? _value.vintage
          : vintage // ignore: cast_nullable_to_non_nullable
              as Vintage,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourseToSlotImplCopyWith<$Res>
    implements $CourseToSlotCopyWith<$Res> {
  factory _$$CourseToSlotImplCopyWith(
          _$CourseToSlotImpl value, $Res Function(_$CourseToSlotImpl) then) =
      __$$CourseToSlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'courseid') int courseId,
      @JsonKey(name: 'slotid') int slotId,
      Vintage vintage});
}

/// @nodoc
class __$$CourseToSlotImplCopyWithImpl<$Res>
    extends _$CourseToSlotCopyWithImpl<$Res, _$CourseToSlotImpl>
    implements _$$CourseToSlotImplCopyWith<$Res> {
  __$$CourseToSlotImplCopyWithImpl(
      _$CourseToSlotImpl _value, $Res Function(_$CourseToSlotImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? slotId = null,
    Object? vintage = null,
  }) {
    return _then(_$CourseToSlotImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as int,
      slotId: null == slotId
          ? _value.slotId
          : slotId // ignore: cast_nullable_to_non_nullable
              as int,
      vintage: null == vintage
          ? _value.vintage
          : vintage // ignore: cast_nullable_to_non_nullable
              as Vintage,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseToSlotImpl extends _CourseToSlot {
  const _$CourseToSlotImpl(
      {required this.id,
      @JsonKey(name: 'courseid') required this.courseId,
      @JsonKey(name: 'slotid') required this.slotId,
      required this.vintage})
      : super._();

  factory _$CourseToSlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseToSlotImplFromJson(json);

  /// Unique identifier of this mapping.
  @override
  final int id;

  /// The id of the course.
  @override
  @JsonKey(name: 'courseid')
  final int courseId;

  /// The id of the slot.
  @override
  @JsonKey(name: 'slotid')
  final int slotId;

  /// The vintage a user must be in to attend this slot.
  @override
  final Vintage vintage;

  @override
  String toString() {
    return 'CourseToSlot(id: $id, courseId: $courseId, slotId: $slotId, vintage: $vintage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseToSlotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.slotId, slotId) || other.slotId == slotId) &&
            (identical(other.vintage, vintage) || other.vintage == vintage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, courseId, slotId, vintage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseToSlotImplCopyWith<_$CourseToSlotImpl> get copyWith =>
      __$$CourseToSlotImplCopyWithImpl<_$CourseToSlotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseToSlotImplToJson(
      this,
    );
  }
}

abstract class _CourseToSlot extends CourseToSlot {
  const factory _CourseToSlot(
      {required final int id,
      @JsonKey(name: 'courseid') required final int courseId,
      @JsonKey(name: 'slotid') required final int slotId,
      required final Vintage vintage}) = _$CourseToSlotImpl;
  const _CourseToSlot._() : super._();

  factory _CourseToSlot.fromJson(Map<String, dynamic> json) =
      _$CourseToSlotImpl.fromJson;

  @override

  /// Unique identifier of this mapping.
  int get id;
  @override

  /// The id of the course.
  @JsonKey(name: 'courseid')
  int get courseId;
  @override

  /// The id of the slot.
  @JsonKey(name: 'slotid')
  int get slotId;
  @override

  /// The vintage a user must be in to attend this slot.
  Vintage get vintage;
  @override
  @JsonKey(ignore: true)
  _$$CourseToSlotImplCopyWith<_$CourseToSlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
