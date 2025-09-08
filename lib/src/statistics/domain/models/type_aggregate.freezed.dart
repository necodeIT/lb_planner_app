// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'type_aggregate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TypeAggregate _$TypeAggregateFromJson(Map<String, dynamic> json) {
  return _TypeAggregate.fromJson(json);
}

/// @nodoc
mixin _$TypeAggregate {
  /// The number of tasks with [MoodleTaskType.required].
  int get required => throw _privateConstructorUsedError;

  /// The number of tasks with [MoodleTaskType.optional].
  int get optional => throw _privateConstructorUsedError;

  /// The number of tasks with [MoodleTaskType.compensation].
  int get compensation => throw _privateConstructorUsedError;

  /// The number of tasks with [MoodleTaskType.exam].
  int get exam => throw _privateConstructorUsedError;

  /// The number of tasks with [MoodleTaskType.none].
  int get none => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TypeAggregateCopyWith<TypeAggregate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeAggregateCopyWith<$Res> {
  factory $TypeAggregateCopyWith(
          TypeAggregate value, $Res Function(TypeAggregate) then) =
      _$TypeAggregateCopyWithImpl<$Res, TypeAggregate>;
  @useResult
  $Res call({int required, int optional, int compensation, int exam, int none});
}

/// @nodoc
class _$TypeAggregateCopyWithImpl<$Res, $Val extends TypeAggregate>
    implements $TypeAggregateCopyWith<$Res> {
  _$TypeAggregateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? required = null,
    Object? optional = null,
    Object? compensation = null,
    Object? exam = null,
    Object? none = null,
  }) {
    return _then(_value.copyWith(
      required: null == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as int,
      optional: null == optional
          ? _value.optional
          : optional // ignore: cast_nullable_to_non_nullable
              as int,
      compensation: null == compensation
          ? _value.compensation
          : compensation // ignore: cast_nullable_to_non_nullable
              as int,
      exam: null == exam
          ? _value.exam
          : exam // ignore: cast_nullable_to_non_nullable
              as int,
      none: null == none
          ? _value.none
          : none // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TypeAggregateImplCopyWith<$Res>
    implements $TypeAggregateCopyWith<$Res> {
  factory _$$TypeAggregateImplCopyWith(
          _$TypeAggregateImpl value, $Res Function(_$TypeAggregateImpl) then) =
      __$$TypeAggregateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int required, int optional, int compensation, int exam, int none});
}

/// @nodoc
class __$$TypeAggregateImplCopyWithImpl<$Res>
    extends _$TypeAggregateCopyWithImpl<$Res, _$TypeAggregateImpl>
    implements _$$TypeAggregateImplCopyWith<$Res> {
  __$$TypeAggregateImplCopyWithImpl(
      _$TypeAggregateImpl _value, $Res Function(_$TypeAggregateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? required = null,
    Object? optional = null,
    Object? compensation = null,
    Object? exam = null,
    Object? none = null,
  }) {
    return _then(_$TypeAggregateImpl(
      required: null == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as int,
      optional: null == optional
          ? _value.optional
          : optional // ignore: cast_nullable_to_non_nullable
              as int,
      compensation: null == compensation
          ? _value.compensation
          : compensation // ignore: cast_nullable_to_non_nullable
              as int,
      exam: null == exam
          ? _value.exam
          : exam // ignore: cast_nullable_to_non_nullable
              as int,
      none: null == none
          ? _value.none
          : none // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TypeAggregateImpl extends _TypeAggregate {
  const _$TypeAggregateImpl(
      {required this.required,
      required this.optional,
      required this.compensation,
      required this.exam,
      required this.none})
      : super._();

  factory _$TypeAggregateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TypeAggregateImplFromJson(json);

  /// The number of tasks with [MoodleTaskType.required].
  @override
  final int required;

  /// The number of tasks with [MoodleTaskType.optional].
  @override
  final int optional;

  /// The number of tasks with [MoodleTaskType.compensation].
  @override
  final int compensation;

  /// The number of tasks with [MoodleTaskType.exam].
  @override
  final int exam;

  /// The number of tasks with [MoodleTaskType.none].
  @override
  final int none;

  @override
  String toString() {
    return 'TypeAggregate(required: $required, optional: $optional, compensation: $compensation, exam: $exam, none: $none)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypeAggregateImpl &&
            (identical(other.required, required) ||
                other.required == required) &&
            (identical(other.optional, optional) ||
                other.optional == optional) &&
            (identical(other.compensation, compensation) ||
                other.compensation == compensation) &&
            (identical(other.exam, exam) || other.exam == exam) &&
            (identical(other.none, none) || other.none == none));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, required, optional, compensation, exam, none);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TypeAggregateImplCopyWith<_$TypeAggregateImpl> get copyWith =>
      __$$TypeAggregateImplCopyWithImpl<_$TypeAggregateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TypeAggregateImplToJson(
      this,
    );
  }
}

abstract class _TypeAggregate extends TypeAggregate {
  const factory _TypeAggregate(
      {required final int required,
      required final int optional,
      required final int compensation,
      required final int exam,
      required final int none}) = _$TypeAggregateImpl;
  const _TypeAggregate._() : super._();

  factory _TypeAggregate.fromJson(Map<String, dynamic> json) =
      _$TypeAggregateImpl.fromJson;

  @override

  /// The number of tasks with [MoodleTaskType.required].
  int get required;
  @override

  /// The number of tasks with [MoodleTaskType.optional].
  int get optional;
  @override

  /// The number of tasks with [MoodleTaskType.compensation].
  int get compensation;
  @override

  /// The number of tasks with [MoodleTaskType.exam].
  int get exam;
  @override

  /// The number of tasks with [MoodleTaskType.none].
  int get none;
  @override
  @JsonKey(ignore: true)
  _$$TypeAggregateImplCopyWith<_$TypeAggregateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
