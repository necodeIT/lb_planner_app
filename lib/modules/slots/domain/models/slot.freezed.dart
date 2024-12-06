// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Slot _$SlotFromJson(Map<String, dynamic> json) {
  return _Slot.fromJson(json);
}

/// @nodoc
mixin _$Slot {
  /// Unique identifier of this slot.
  int get id => throw _privateConstructorUsedError;

  /// The start time of this slot.
  @JsonValue('startunit')
  SlotTimeUnit get startUnit => throw _privateConstructorUsedError;

  /// The duration of this slot interpreted as [SlotTimeUnit]s.
  int get duration => throw _privateConstructorUsedError;

  /// The weekday this slot takes place on.
  Weekday get weekday => throw _privateConstructorUsedError;

  /// The room this slot takes place in.
  String get room => throw _privateConstructorUsedError;

  /// The number of students that can attend this slot.
  int get size => throw _privateConstructorUsedError;

  /// The number of students that have already reserved this slot.
  @JsonValue('fullness')
  int get reservations => throw _privateConstructorUsedError;

  /// `true` if the current user has reserved this slot.
  @JsonValue('forcuruser')
  bool get reserved => throw _privateConstructorUsedError;

  /// Serializes this Slot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Slot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SlotCopyWith<Slot> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlotCopyWith<$Res> {
  factory $SlotCopyWith(Slot value, $Res Function(Slot) then) =
      _$SlotCopyWithImpl<$Res, Slot>;
  @useResult
  $Res call(
      {int id,
      @JsonValue('startunit') SlotTimeUnit startUnit,
      int duration,
      Weekday weekday,
      String room,
      int size,
      @JsonValue('fullness') int reservations,
      @JsonValue('forcuruser') bool reserved});
}

/// @nodoc
class _$SlotCopyWithImpl<$Res, $Val extends Slot>
    implements $SlotCopyWith<$Res> {
  _$SlotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Slot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startUnit = null,
    Object? duration = null,
    Object? weekday = null,
    Object? room = null,
    Object? size = null,
    Object? reservations = null,
    Object? reserved = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      startUnit: null == startUnit
          ? _value.startUnit
          : startUnit // ignore: cast_nullable_to_non_nullable
              as SlotTimeUnit,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      weekday: null == weekday
          ? _value.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as Weekday,
      room: null == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      reservations: null == reservations
          ? _value.reservations
          : reservations // ignore: cast_nullable_to_non_nullable
              as int,
      reserved: null == reserved
          ? _value.reserved
          : reserved // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SlotImplCopyWith<$Res> implements $SlotCopyWith<$Res> {
  factory _$$SlotImplCopyWith(
          _$SlotImpl value, $Res Function(_$SlotImpl) then) =
      __$$SlotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonValue('startunit') SlotTimeUnit startUnit,
      int duration,
      Weekday weekday,
      String room,
      int size,
      @JsonValue('fullness') int reservations,
      @JsonValue('forcuruser') bool reserved});
}

/// @nodoc
class __$$SlotImplCopyWithImpl<$Res>
    extends _$SlotCopyWithImpl<$Res, _$SlotImpl>
    implements _$$SlotImplCopyWith<$Res> {
  __$$SlotImplCopyWithImpl(_$SlotImpl _value, $Res Function(_$SlotImpl) _then)
      : super(_value, _then);

  /// Create a copy of Slot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startUnit = null,
    Object? duration = null,
    Object? weekday = null,
    Object? room = null,
    Object? size = null,
    Object? reservations = null,
    Object? reserved = null,
  }) {
    return _then(_$SlotImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      startUnit: null == startUnit
          ? _value.startUnit
          : startUnit // ignore: cast_nullable_to_non_nullable
              as SlotTimeUnit,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      weekday: null == weekday
          ? _value.weekday
          : weekday // ignore: cast_nullable_to_non_nullable
              as Weekday,
      room: null == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      reservations: null == reservations
          ? _value.reservations
          : reservations // ignore: cast_nullable_to_non_nullable
              as int,
      reserved: null == reserved
          ? _value.reserved
          : reserved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SlotImpl extends _Slot {
  const _$SlotImpl(
      {required this.id,
      @JsonValue('startunit') required this.startUnit,
      required this.duration,
      required this.weekday,
      required this.room,
      required this.size,
      @JsonValue('fullness') required this.reservations,
      @JsonValue('forcuruser') required this.reserved})
      : super._();

  factory _$SlotImpl.fromJson(Map<String, dynamic> json) =>
      _$$SlotImplFromJson(json);

  /// Unique identifier of this slot.
  @override
  final int id;

  /// The start time of this slot.
  @override
  @JsonValue('startunit')
  final SlotTimeUnit startUnit;

  /// The duration of this slot interpreted as [SlotTimeUnit]s.
  @override
  final int duration;

  /// The weekday this slot takes place on.
  @override
  final Weekday weekday;

  /// The room this slot takes place in.
  @override
  final String room;

  /// The number of students that can attend this slot.
  @override
  final int size;

  /// The number of students that have already reserved this slot.
  @override
  @JsonValue('fullness')
  final int reservations;

  /// `true` if the current user has reserved this slot.
  @override
  @JsonValue('forcuruser')
  final bool reserved;

  @override
  String toString() {
    return 'Slot(id: $id, startUnit: $startUnit, duration: $duration, weekday: $weekday, room: $room, size: $size, reservations: $reservations, reserved: $reserved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startUnit, startUnit) ||
                other.startUnit == startUnit) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.weekday, weekday) || other.weekday == weekday) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.reservations, reservations) ||
                other.reservations == reservations) &&
            (identical(other.reserved, reserved) ||
                other.reserved == reserved));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, startUnit, duration, weekday,
      room, size, reservations, reserved);

  /// Create a copy of Slot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SlotImplCopyWith<_$SlotImpl> get copyWith =>
      __$$SlotImplCopyWithImpl<_$SlotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SlotImplToJson(
      this,
    );
  }
}

abstract class _Slot extends Slot {
  const factory _Slot(
      {required final int id,
      @JsonValue('startunit') required final SlotTimeUnit startUnit,
      required final int duration,
      required final Weekday weekday,
      required final String room,
      required final int size,
      @JsonValue('fullness') required final int reservations,
      @JsonValue('forcuruser') required final bool reserved}) = _$SlotImpl;
  const _Slot._() : super._();

  factory _Slot.fromJson(Map<String, dynamic> json) = _$SlotImpl.fromJson;

  /// Unique identifier of this slot.
  @override
  int get id;

  /// The start time of this slot.
  @override
  @JsonValue('startunit')
  SlotTimeUnit get startUnit;

  /// The duration of this slot interpreted as [SlotTimeUnit]s.
  @override
  int get duration;

  /// The weekday this slot takes place on.
  @override
  Weekday get weekday;

  /// The room this slot takes place in.
  @override
  String get room;

  /// The number of students that can attend this slot.
  @override
  int get size;

  /// The number of students that have already reserved this slot.
  @override
  @JsonValue('fullness')
  int get reservations;

  /// `true` if the current user has reserved this slot.
  @override
  @JsonValue('forcuruser')
  bool get reserved;

  /// Create a copy of Slot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SlotImplCopyWith<_$SlotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
