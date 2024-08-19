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
  @JsonKey(name: 'moduleid')
  int get id => throw _privateConstructorUsedError;

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
  @UnixTimestampConverter()
  DateTime get deadline => throw _privateConstructorUsedError;

  /// The URL to this task on the Moodle website.
  String get url => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'moduleid') int id,
      String name,
      @JsonKey(name: 'courseid') int courseId,
      MoodleTaskStatus status,
      MoodleTaskType type,
      @UnixTimestampConverter() DateTime deadline,
      String url});
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
    Object? name = null,
    Object? courseId = null,
    Object? status = null,
    Object? type = null,
    Object? deadline = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
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
      {@JsonKey(name: 'moduleid') int id,
      String name,
      @JsonKey(name: 'courseid') int courseId,
      MoodleTaskStatus status,
      MoodleTaskType type,
      @UnixTimestampConverter() DateTime deadline,
      String url});
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
    Object? name = null,
    Object? courseId = null,
    Object? status = null,
    Object? type = null,
    Object? deadline = null,
    Object? url = null,
  }) {
    return _then(_$MoodleTaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MoodleTaskImpl extends _MoodleTask {
  const _$MoodleTaskImpl(
      {@JsonKey(name: 'moduleid') required this.id,
      required this.name,
      @JsonKey(name: 'courseid') required this.courseId,
      required this.status,
      required this.type,
      @UnixTimestampConverter() required this.deadline,
      required this.url})
      : super._();

  factory _$MoodleTaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$MoodleTaskImplFromJson(json);

  /// The ID of this task.
  @override
  @JsonKey(name: 'moduleid')
  final int id;

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
  @UnixTimestampConverter()
  final DateTime deadline;

  /// The URL to this task on the Moodle website.
  @override
  final String url;

  @override
  String toString() {
    return 'MoodleTask(id: $id, name: $name, courseId: $courseId, status: $status, type: $type, deadline: $deadline, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoodleTaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, courseId, status, type, deadline, url);

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
      {@JsonKey(name: 'moduleid') required final int id,
      required final String name,
      @JsonKey(name: 'courseid') required final int courseId,
      required final MoodleTaskStatus status,
      required final MoodleTaskType type,
      @UnixTimestampConverter() required final DateTime deadline,
      required final String url}) = _$MoodleTaskImpl;
  const _MoodleTask._() : super._();

  factory _MoodleTask.fromJson(Map<String, dynamic> json) =
      _$MoodleTaskImpl.fromJson;

  @override

  /// The ID of this task.
  @JsonKey(name: 'moduleid')
  int get id;
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
  @UnixTimestampConverter()
  DateTime get deadline;
  @override

  /// The URL to this task on the Moodle website.
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$MoodleTaskImplCopyWith<_$MoodleTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
