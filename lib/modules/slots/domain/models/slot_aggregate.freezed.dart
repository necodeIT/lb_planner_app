// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slot_aggregate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SlotAggregate {
  List<User> get supervisors => throw _privateConstructorUsedError;
  MoodleCourse get course => throw _privateConstructorUsedError;
  Slot get slot => throw _privateConstructorUsedError;

  /// Create a copy of SlotAggregate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SlotAggregateCopyWith<SlotAggregate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlotAggregateCopyWith<$Res> {
  factory $SlotAggregateCopyWith(
          SlotAggregate value, $Res Function(SlotAggregate) then) =
      _$SlotAggregateCopyWithImpl<$Res, SlotAggregate>;
  @useResult
  $Res call({List<User> supervisors, MoodleCourse course, Slot slot});

  $MoodleCourseCopyWith<$Res> get course;
  $SlotCopyWith<$Res> get slot;
}

/// @nodoc
class _$SlotAggregateCopyWithImpl<$Res, $Val extends SlotAggregate>
    implements $SlotAggregateCopyWith<$Res> {
  _$SlotAggregateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SlotAggregate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supervisors = null,
    Object? course = null,
    Object? slot = null,
  }) {
    return _then(_value.copyWith(
      supervisors: null == supervisors
          ? _value.supervisors
          : supervisors // ignore: cast_nullable_to_non_nullable
              as List<User>,
      course: null == course
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as MoodleCourse,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as Slot,
    ) as $Val);
  }

  /// Create a copy of SlotAggregate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MoodleCourseCopyWith<$Res> get course {
    return $MoodleCourseCopyWith<$Res>(_value.course, (value) {
      return _then(_value.copyWith(course: value) as $Val);
    });
  }

  /// Create a copy of SlotAggregate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SlotCopyWith<$Res> get slot {
    return $SlotCopyWith<$Res>(_value.slot, (value) {
      return _then(_value.copyWith(slot: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SlotAggregateImplCopyWith<$Res>
    implements $SlotAggregateCopyWith<$Res> {
  factory _$$SlotAggregateImplCopyWith(
          _$SlotAggregateImpl value, $Res Function(_$SlotAggregateImpl) then) =
      __$$SlotAggregateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<User> supervisors, MoodleCourse course, Slot slot});

  @override
  $MoodleCourseCopyWith<$Res> get course;
  @override
  $SlotCopyWith<$Res> get slot;
}

/// @nodoc
class __$$SlotAggregateImplCopyWithImpl<$Res>
    extends _$SlotAggregateCopyWithImpl<$Res, _$SlotAggregateImpl>
    implements _$$SlotAggregateImplCopyWith<$Res> {
  __$$SlotAggregateImplCopyWithImpl(
      _$SlotAggregateImpl _value, $Res Function(_$SlotAggregateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SlotAggregate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supervisors = null,
    Object? course = null,
    Object? slot = null,
  }) {
    return _then(_$SlotAggregateImpl(
      supervisors: null == supervisors
          ? _value._supervisors
          : supervisors // ignore: cast_nullable_to_non_nullable
              as List<User>,
      course: null == course
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as MoodleCourse,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as Slot,
    ));
  }
}

/// @nodoc

class _$SlotAggregateImpl extends _SlotAggregate {
  const _$SlotAggregateImpl(
      {required final List<User> supervisors,
      required this.course,
      required this.slot})
      : _supervisors = supervisors,
        super._();

  final List<User> _supervisors;
  @override
  List<User> get supervisors {
    if (_supervisors is EqualUnmodifiableListView) return _supervisors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supervisors);
  }

  @override
  final MoodleCourse course;
  @override
  final Slot slot;

  @override
  String toString() {
    return 'SlotAggregate(supervisors: $supervisors, course: $course, slot: $slot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlotAggregateImpl &&
            const DeepCollectionEquality()
                .equals(other._supervisors, _supervisors) &&
            (identical(other.course, course) || other.course == course) &&
            (identical(other.slot, slot) || other.slot == slot));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_supervisors), course, slot);

  /// Create a copy of SlotAggregate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SlotAggregateImplCopyWith<_$SlotAggregateImpl> get copyWith =>
      __$$SlotAggregateImplCopyWithImpl<_$SlotAggregateImpl>(this, _$identity);
}

abstract class _SlotAggregate extends SlotAggregate {
  const factory _SlotAggregate(
      {required final List<User> supervisors,
      required final MoodleCourse course,
      required final Slot slot}) = _$SlotAggregateImpl;
  const _SlotAggregate._() : super._();

  @override
  List<User> get supervisors;
  @override
  MoodleCourse get course;
  @override
  Slot get slot;

  /// Create a copy of SlotAggregate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SlotAggregateImplCopyWith<_$SlotAggregateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
