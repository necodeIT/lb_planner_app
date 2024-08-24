// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_aggregate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StatusAggregate _$StatusAggregateFromJson(Map<String, dynamic> json) {
  return _StatusAggregate.fromJson(json);
}

/// @nodoc
mixin _$StatusAggregate {
  /// The number of tasks with [MoodleTaskStatus.done].
  int get done => throw _privateConstructorUsedError;

  /// The number of tasks with [MoodleTaskStatus.pending].
  int get pending => throw _privateConstructorUsedError;

  /// The number of tasks with [MoodleTaskStatus.uploaded].
  int get uploaded => throw _privateConstructorUsedError;

  /// The number of tasks with [MoodleTaskStatus.late].
  int get late => throw _privateConstructorUsedError;

  /// Serializes this StatusAggregate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StatusAggregate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StatusAggregateCopyWith<StatusAggregate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusAggregateCopyWith<$Res> {
  factory $StatusAggregateCopyWith(
          StatusAggregate value, $Res Function(StatusAggregate) then) =
      _$StatusAggregateCopyWithImpl<$Res, StatusAggregate>;
  @useResult
  $Res call({int done, int pending, int uploaded, int late});
}

/// @nodoc
class _$StatusAggregateCopyWithImpl<$Res, $Val extends StatusAggregate>
    implements $StatusAggregateCopyWith<$Res> {
  _$StatusAggregateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StatusAggregate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? done = null,
    Object? pending = null,
    Object? uploaded = null,
    Object? late = null,
  }) {
    return _then(_value.copyWith(
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as int,
      pending: null == pending
          ? _value.pending
          : pending // ignore: cast_nullable_to_non_nullable
              as int,
      uploaded: null == uploaded
          ? _value.uploaded
          : uploaded // ignore: cast_nullable_to_non_nullable
              as int,
      late: null == late
          ? _value.late
          : late // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusAggregateImplCopyWith<$Res>
    implements $StatusAggregateCopyWith<$Res> {
  factory _$$StatusAggregateImplCopyWith(_$StatusAggregateImpl value,
          $Res Function(_$StatusAggregateImpl) then) =
      __$$StatusAggregateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int done, int pending, int uploaded, int late});
}

/// @nodoc
class __$$StatusAggregateImplCopyWithImpl<$Res>
    extends _$StatusAggregateCopyWithImpl<$Res, _$StatusAggregateImpl>
    implements _$$StatusAggregateImplCopyWith<$Res> {
  __$$StatusAggregateImplCopyWithImpl(
      _$StatusAggregateImpl _value, $Res Function(_$StatusAggregateImpl) _then)
      : super(_value, _then);

  /// Create a copy of StatusAggregate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? done = null,
    Object? pending = null,
    Object? uploaded = null,
    Object? late = null,
  }) {
    return _then(_$StatusAggregateImpl(
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as int,
      pending: null == pending
          ? _value.pending
          : pending // ignore: cast_nullable_to_non_nullable
              as int,
      uploaded: null == uploaded
          ? _value.uploaded
          : uploaded // ignore: cast_nullable_to_non_nullable
              as int,
      late: null == late
          ? _value.late
          : late // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusAggregateImpl extends _StatusAggregate {
  const _$StatusAggregateImpl(
      {required this.done,
      required this.pending,
      required this.uploaded,
      required this.late})
      : super._();

  factory _$StatusAggregateImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusAggregateImplFromJson(json);

  /// The number of tasks with [MoodleTaskStatus.done].
  @override
  final int done;

  /// The number of tasks with [MoodleTaskStatus.pending].
  @override
  final int pending;

  /// The number of tasks with [MoodleTaskStatus.uploaded].
  @override
  final int uploaded;

  /// The number of tasks with [MoodleTaskStatus.late].
  @override
  final int late;

  @override
  String toString() {
    return 'StatusAggregate(done: $done, pending: $pending, uploaded: $uploaded, late: $late)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusAggregateImpl &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.pending, pending) || other.pending == pending) &&
            (identical(other.uploaded, uploaded) ||
                other.uploaded == uploaded) &&
            (identical(other.late, late) || other.late == late));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, done, pending, uploaded, late);

  /// Create a copy of StatusAggregate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusAggregateImplCopyWith<_$StatusAggregateImpl> get copyWith =>
      __$$StatusAggregateImplCopyWithImpl<_$StatusAggregateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusAggregateImplToJson(
      this,
    );
  }
}

abstract class _StatusAggregate extends StatusAggregate {
  const factory _StatusAggregate(
      {required final int done,
      required final int pending,
      required final int uploaded,
      required final int late}) = _$StatusAggregateImpl;
  const _StatusAggregate._() : super._();

  factory _StatusAggregate.fromJson(Map<String, dynamic> json) =
      _$StatusAggregateImpl.fromJson;

  /// The number of tasks with [MoodleTaskStatus.done].
  @override
  int get done;

  /// The number of tasks with [MoodleTaskStatus.pending].
  @override
  int get pending;

  /// The number of tasks with [MoodleTaskStatus.uploaded].
  @override
  int get uploaded;

  /// The number of tasks with [MoodleTaskStatus.late].
  @override
  int get late;

  /// Create a copy of StatusAggregate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatusAggregateImplCopyWith<_$StatusAggregateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
