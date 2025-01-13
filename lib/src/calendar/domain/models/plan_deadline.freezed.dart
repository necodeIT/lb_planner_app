// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_deadline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlanDeadline _$PlanDeadlineFromJson(Map<String, dynamic> json) {
  return _PlanDeadline.fromJson(json);
}

/// @nodoc
mixin _$PlanDeadline {
  /// The ID of this deadline.
  @JsonKey(name: 'moduleid')
  int get id => throw _privateConstructorUsedError;

  /// The start date of this deadline.
  @JsonKey(name: 'deadlinestart')
  @UnixTimestampConverter()
  DateTime get start => throw _privateConstructorUsedError;

  /// The end date of this deadline.
  @JsonKey(name: 'deadlineend')
  @UnixTimestampConverter()
  DateTime get end => throw _privateConstructorUsedError;

  /// Serializes this PlanDeadline to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlanDeadline
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanDeadlineCopyWith<PlanDeadline> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanDeadlineCopyWith<$Res> {
  factory $PlanDeadlineCopyWith(
          PlanDeadline value, $Res Function(PlanDeadline) then) =
      _$PlanDeadlineCopyWithImpl<$Res, PlanDeadline>;
  @useResult
  $Res call(
      {@JsonKey(name: 'moduleid') int id,
      @JsonKey(name: 'deadlinestart') @UnixTimestampConverter() DateTime start,
      @JsonKey(name: 'deadlineend') @UnixTimestampConverter() DateTime end});
}

/// @nodoc
class _$PlanDeadlineCopyWithImpl<$Res, $Val extends PlanDeadline>
    implements $PlanDeadlineCopyWith<$Res> {
  _$PlanDeadlineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanDeadline
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlanDeadlineImplCopyWith<$Res>
    implements $PlanDeadlineCopyWith<$Res> {
  factory _$$PlanDeadlineImplCopyWith(
          _$PlanDeadlineImpl value, $Res Function(_$PlanDeadlineImpl) then) =
      __$$PlanDeadlineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'moduleid') int id,
      @JsonKey(name: 'deadlinestart') @UnixTimestampConverter() DateTime start,
      @JsonKey(name: 'deadlineend') @UnixTimestampConverter() DateTime end});
}

/// @nodoc
class __$$PlanDeadlineImplCopyWithImpl<$Res>
    extends _$PlanDeadlineCopyWithImpl<$Res, _$PlanDeadlineImpl>
    implements _$$PlanDeadlineImplCopyWith<$Res> {
  __$$PlanDeadlineImplCopyWithImpl(
      _$PlanDeadlineImpl _value, $Res Function(_$PlanDeadlineImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlanDeadline
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$PlanDeadlineImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlanDeadlineImpl extends _PlanDeadline {
  const _$PlanDeadlineImpl(
      {@JsonKey(name: 'moduleid') required this.id,
      @JsonKey(name: 'deadlinestart')
      @UnixTimestampConverter()
      required this.start,
      @JsonKey(name: 'deadlineend')
      @UnixTimestampConverter()
      required this.end})
      : super._();

  factory _$PlanDeadlineImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanDeadlineImplFromJson(json);

  /// The ID of this deadline.
  @override
  @JsonKey(name: 'moduleid')
  final int id;

  /// The start date of this deadline.
  @override
  @JsonKey(name: 'deadlinestart')
  @UnixTimestampConverter()
  final DateTime start;

  /// The end date of this deadline.
  @override
  @JsonKey(name: 'deadlineend')
  @UnixTimestampConverter()
  final DateTime end;

  @override
  String toString() {
    return 'PlanDeadline(id: $id, start: $start, end: $end)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanDeadlineImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, start, end);

  /// Create a copy of PlanDeadline
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanDeadlineImplCopyWith<_$PlanDeadlineImpl> get copyWith =>
      __$$PlanDeadlineImplCopyWithImpl<_$PlanDeadlineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanDeadlineImplToJson(
      this,
    );
  }
}

abstract class _PlanDeadline extends PlanDeadline {
  const factory _PlanDeadline(
      {@JsonKey(name: 'moduleid') required final int id,
      @JsonKey(name: 'deadlinestart')
      @UnixTimestampConverter()
      required final DateTime start,
      @JsonKey(name: 'deadlineend')
      @UnixTimestampConverter()
      required final DateTime end}) = _$PlanDeadlineImpl;
  const _PlanDeadline._() : super._();

  factory _PlanDeadline.fromJson(Map<String, dynamic> json) =
      _$PlanDeadlineImpl.fromJson;

  /// The ID of this deadline.
  @override
  @JsonKey(name: 'moduleid')
  int get id;

  /// The start date of this deadline.
  @override
  @JsonKey(name: 'deadlinestart')
  @UnixTimestampConverter()
  DateTime get start;

  /// The end date of this deadline.
  @override
  @JsonKey(name: 'deadlineend')
  @UnixTimestampConverter()
  DateTime get end;

  /// Create a copy of PlanDeadline
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanDeadlineImplCopyWith<_$PlanDeadlineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
