// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_aggregate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskAggregate _$TaskAggregateFromJson(Map<String, dynamic> json) {
  return _TaskAggregate.fromJson(json);
}

/// @nodoc
mixin _$TaskAggregate {
  /// Aggregation by status.
  StatusAggregate get status => throw _privateConstructorUsedError;

  /// Aggregation by type.
  TypeAggregate get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskAggregateCopyWith<TaskAggregate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskAggregateCopyWith<$Res> {
  factory $TaskAggregateCopyWith(
          TaskAggregate value, $Res Function(TaskAggregate) then) =
      _$TaskAggregateCopyWithImpl<$Res, TaskAggregate>;
  @useResult
  $Res call({StatusAggregate status, TypeAggregate type});

  $StatusAggregateCopyWith<$Res> get status;
  $TypeAggregateCopyWith<$Res> get type;
}

/// @nodoc
class _$TaskAggregateCopyWithImpl<$Res, $Val extends TaskAggregate>
    implements $TaskAggregateCopyWith<$Res> {
  _$TaskAggregateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusAggregate,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TypeAggregate,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StatusAggregateCopyWith<$Res> get status {
    return $StatusAggregateCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TypeAggregateCopyWith<$Res> get type {
    return $TypeAggregateCopyWith<$Res>(_value.type, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaskAggregateImplCopyWith<$Res>
    implements $TaskAggregateCopyWith<$Res> {
  factory _$$TaskAggregateImplCopyWith(
          _$TaskAggregateImpl value, $Res Function(_$TaskAggregateImpl) then) =
      __$$TaskAggregateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StatusAggregate status, TypeAggregate type});

  @override
  $StatusAggregateCopyWith<$Res> get status;
  @override
  $TypeAggregateCopyWith<$Res> get type;
}

/// @nodoc
class __$$TaskAggregateImplCopyWithImpl<$Res>
    extends _$TaskAggregateCopyWithImpl<$Res, _$TaskAggregateImpl>
    implements _$$TaskAggregateImplCopyWith<$Res> {
  __$$TaskAggregateImplCopyWithImpl(
      _$TaskAggregateImpl _value, $Res Function(_$TaskAggregateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? type = null,
  }) {
    return _then(_$TaskAggregateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatusAggregate,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TypeAggregate,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskAggregateImpl extends _TaskAggregate {
  const _$TaskAggregateImpl({required this.status, required this.type})
      : super._();

  factory _$TaskAggregateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskAggregateImplFromJson(json);

  /// Aggregation by status.
  @override
  final StatusAggregate status;

  /// Aggregation by type.
  @override
  final TypeAggregate type;

  @override
  String toString() {
    return 'TaskAggregate(status: $status, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskAggregateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskAggregateImplCopyWith<_$TaskAggregateImpl> get copyWith =>
      __$$TaskAggregateImplCopyWithImpl<_$TaskAggregateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskAggregateImplToJson(
      this,
    );
  }
}

abstract class _TaskAggregate extends TaskAggregate {
  const factory _TaskAggregate(
      {required final StatusAggregate status,
      required final TypeAggregate type}) = _$TaskAggregateImpl;
  const _TaskAggregate._() : super._();

  factory _TaskAggregate.fromJson(Map<String, dynamic> json) =
      _$TaskAggregateImpl.fromJson;

  @override

  /// Aggregation by status.
  StatusAggregate get status;
  @override

  /// Aggregation by type.
  TypeAggregate get type;
  @override
  @JsonKey(ignore: true)
  _$$TaskAggregateImplCopyWith<_$TaskAggregateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
