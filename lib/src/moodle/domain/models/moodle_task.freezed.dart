// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'moodle_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MoodleTask _$MoodleTaskFromJson(Map<String, dynamic> json) {
  return _MoodleTask.fromJson(json);
}

/// @nodoc
mixin _$MoodleTask {
  /// The ID of this task.
  @JsonKey(name: 'assignid')
  int get id => throw _privateConstructorUsedError;

  /// The id of the task within it's parent [MoodleCourse].
  @JsonKey(name: 'cmid')
  int get cmid => throw _privateConstructorUsedError;

  /// The name of this task.
  String get name => throw _privateConstructorUsedError;

  /// The ID of the [MoodleCourse] this task is part of.
  @JsonKey(name: 'courseid')
  int get courseId => throw _privateConstructorUsedError;

  /// The status of this task.
  MoodleTaskStatus get status => throw _privateConstructorUsedError;

  /// The type of this task.
  MoodleTaskType get type => throw _privateConstructorUsedError;

  /// The timestamp of when this task is due in seconds since the Unix epoch.
  @JsonKey(name: 'duedate')
  @UnixTimestampConverterNullable()
  DateTime? get deadline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoodleTaskCopyWith<MoodleTask> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoodleTaskCopyWith<$Res> {
  factory $MoodleTaskCopyWith(
          MoodleTask value, $Res Function(MoodleTask) then) =
      _$MoodleTaskCopyWithImpl<$Res, MoodleTask>;
  @useResult
  $Res call(
      {@JsonKey(name: 'assignid') int id,
      @JsonKey(name: 'cmid') int cmid,
      String name,
      @JsonKey(name: 'courseid') int courseId,
      MoodleTaskStatus status,
      MoodleTaskType type,
      @JsonKey(name: 'duedate')
      @UnixTimestampConverterNullable()
      DateTime? deadline});
}

/// @nodoc
class _$MoodleTaskCopyWithImpl<$Res, $Val extends MoodleTask>
    implements $MoodleTaskCopyWith<$Res> {
  _$MoodleTaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cmid = null,
    Object? name = null,
    Object? courseId = null,
    Object? status = null,
    Object? type = null,
    Object? deadline = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cmid: null == cmid
          ? _value.cmid
          : cmid // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MoodleTaskStatus,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MoodleTaskType,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MoodleTaskImplCopyWith<$Res>
    implements $MoodleTaskCopyWith<$Res> {
  factory _$$MoodleTaskImplCopyWith(
          _$MoodleTaskImpl value, $Res Function(_$MoodleTaskImpl) then) =
      __$$MoodleTaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'assignid') int id,
      @JsonKey(name: 'cmid') int cmid,
      String name,
      @JsonKey(name: 'courseid') int courseId,
      MoodleTaskStatus status,
      MoodleTaskType type,
      @JsonKey(name: 'duedate')
      @UnixTimestampConverterNullable()
      DateTime? deadline});
}

/// @nodoc
class __$$MoodleTaskImplCopyWithImpl<$Res>
    extends _$MoodleTaskCopyWithImpl<$Res, _$MoodleTaskImpl>
    implements _$$MoodleTaskImplCopyWith<$Res> {
  __$$MoodleTaskImplCopyWithImpl(
      _$MoodleTaskImpl _value, $Res Function(_$MoodleTaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? cmid = null,
    Object? name = null,
    Object? courseId = null,
    Object? status = null,
    Object? type = null,
    Object? deadline = freezed,
  }) {
    return _then(_$MoodleTaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cmid: null == cmid
          ? _value.cmid
          : cmid // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MoodleTaskStatus,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MoodleTaskType,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoodleTaskImpl extends _MoodleTask {
  const _$MoodleTaskImpl(
      {@JsonKey(name: 'assignid') required this.id,
      @JsonKey(name: 'cmid') required this.cmid,
      required this.name,
      @JsonKey(name: 'courseid') required this.courseId,
      required this.status,
      required this.type,
      @JsonKey(name: 'duedate')
      @UnixTimestampConverterNullable()
      this.deadline})
      : super._();

  factory _$MoodleTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$MoodleTaskImplFromJson(json);

  /// The ID of this task.
  @override
  @JsonKey(name: 'assignid')
  final int id;

  /// The id of the task within it's parent [MoodleCourse].
  @override
  @JsonKey(name: 'cmid')
  final int cmid;

  /// The name of this task.
  @override
  final String name;

  /// The ID of the [MoodleCourse] this task is part of.
  @override
  @JsonKey(name: 'courseid')
  final int courseId;

  /// The status of this task.
  @override
  final MoodleTaskStatus status;

  /// The type of this task.
  @override
  final MoodleTaskType type;

  /// The timestamp of when this task is due in seconds since the Unix epoch.
  @override
  @JsonKey(name: 'duedate')
  @UnixTimestampConverterNullable()
  final DateTime? deadline;

  @override
  String toString() {
    return 'MoodleTask(id: $id, cmid: $cmid, name: $name, courseId: $courseId, status: $status, type: $type, deadline: $deadline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoodleTaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.cmid, cmid) || other.cmid == cmid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, cmid, name, courseId, status, type, deadline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MoodleTaskImplCopyWith<_$MoodleTaskImpl> get copyWith =>
      __$$MoodleTaskImplCopyWithImpl<_$MoodleTaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MoodleTaskImplToJson(
      this,
    );
  }
}

abstract class _MoodleTask extends MoodleTask {
  const factory _MoodleTask(
      {@JsonKey(name: 'assignid') required final int id,
      @JsonKey(name: 'cmid') required final int cmid,
      required final String name,
      @JsonKey(name: 'courseid') required final int courseId,
      required final MoodleTaskStatus status,
      required final MoodleTaskType type,
      @JsonKey(name: 'duedate')
      @UnixTimestampConverterNullable()
      final DateTime? deadline}) = _$MoodleTaskImpl;
  const _MoodleTask._() : super._();

  factory _MoodleTask.fromJson(Map<String, dynamic> json) =
      _$MoodleTaskImpl.fromJson;

  @override

  /// The ID of this task.
  @JsonKey(name: 'assignid')
  int get id;
  @override

  /// The id of the task within it's parent [MoodleCourse].
  @JsonKey(name: 'cmid')
  int get cmid;
  @override

  /// The name of this task.
  String get name;
  @override

  /// The ID of the [MoodleCourse] this task is part of.
  @JsonKey(name: 'courseid')
  int get courseId;
  @override

  /// The status of this task.
  MoodleTaskStatus get status;
  @override

  /// The type of this task.
  MoodleTaskType get type;
  @override

  /// The timestamp of when this task is due in seconds since the Unix epoch.
  @JsonKey(name: 'duedate')
  @UnixTimestampConverterNullable()
  DateTime? get deadline;
  @override
  @JsonKey(ignore: true)
  _$$MoodleTaskImplCopyWith<_$MoodleTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
