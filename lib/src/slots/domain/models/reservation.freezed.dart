// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return _Reservation.fromJson(json);
}

/// @nodoc
mixin _$Reservation {
  /// Unique identifier of this reservation.
  int get id => throw _privateConstructorUsedError;

  /// The id of the slot this reservation is for.
  @JsonKey(name: 'slotid')
  int get slotId => throw _privateConstructorUsedError;

  /// The date of this reservation.
  @ReservationDateTimeConverter()
  DateTime get date => throw _privateConstructorUsedError;

  /// The id of this reservation is for.
  @JsonKey(name: 'userid')
  int get userId => throw _privateConstructorUsedError;

  /// The id of the user that made this reservation.
  @JsonKey(name: 'reserverid')
  int get reserverId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReservationCopyWith<Reservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationCopyWith<$Res> {
  factory $ReservationCopyWith(
          Reservation value, $Res Function(Reservation) then) =
      _$ReservationCopyWithImpl<$Res, Reservation>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'slotid') int slotId,
      @ReservationDateTimeConverter() DateTime date,
      @JsonKey(name: 'userid') int userId,
      @JsonKey(name: 'reserverid') int reserverId});
}

/// @nodoc
class _$ReservationCopyWithImpl<$Res, $Val extends Reservation>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slotId = null,
    Object? date = null,
    Object? userId = null,
    Object? reserverId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      slotId: null == slotId
          ? _value.slotId
          : slotId // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      reserverId: null == reserverId
          ? _value.reserverId
          : reserverId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationImplCopyWith<$Res>
    implements $ReservationCopyWith<$Res> {
  factory _$$ReservationImplCopyWith(
          _$ReservationImpl value, $Res Function(_$ReservationImpl) then) =
      __$$ReservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'slotid') int slotId,
      @ReservationDateTimeConverter() DateTime date,
      @JsonKey(name: 'userid') int userId,
      @JsonKey(name: 'reserverid') int reserverId});
}

/// @nodoc
class __$$ReservationImplCopyWithImpl<$Res>
    extends _$ReservationCopyWithImpl<$Res, _$ReservationImpl>
    implements _$$ReservationImplCopyWith<$Res> {
  __$$ReservationImplCopyWithImpl(
      _$ReservationImpl _value, $Res Function(_$ReservationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? slotId = null,
    Object? date = null,
    Object? userId = null,
    Object? reserverId = null,
  }) {
    return _then(_$ReservationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      slotId: null == slotId
          ? _value.slotId
          : slotId // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      reserverId: null == reserverId
          ? _value.reserverId
          : reserverId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReservationImpl extends _Reservation {
  const _$ReservationImpl(
      {required this.id,
      @JsonKey(name: 'slotid') required this.slotId,
      @ReservationDateTimeConverter() required this.date,
      @JsonKey(name: 'userid') required this.userId,
      @JsonKey(name: 'reserverid') required this.reserverId})
      : super._();

  factory _$ReservationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationImplFromJson(json);

  /// Unique identifier of this reservation.
  @override
  final int id;

  /// The id of the slot this reservation is for.
  @override
  @JsonKey(name: 'slotid')
  final int slotId;

  /// The date of this reservation.
  @override
  @ReservationDateTimeConverter()
  final DateTime date;

  /// The id of this reservation is for.
  @override
  @JsonKey(name: 'userid')
  final int userId;

  /// The id of the user that made this reservation.
  @override
  @JsonKey(name: 'reserverid')
  final int reserverId;

  @override
  String toString() {
    return 'Reservation(id: $id, slotId: $slotId, date: $date, userId: $userId, reserverId: $reserverId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.slotId, slotId) || other.slotId == slotId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.reserverId, reserverId) ||
                other.reserverId == reserverId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, slotId, date, userId, reserverId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      __$$ReservationImplCopyWithImpl<_$ReservationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationImplToJson(
      this,
    );
  }
}

abstract class _Reservation extends Reservation {
  const factory _Reservation(
          {required final int id,
          @JsonKey(name: 'slotid') required final int slotId,
          @ReservationDateTimeConverter() required final DateTime date,
          @JsonKey(name: 'userid') required final int userId,
          @JsonKey(name: 'reserverid') required final int reserverId}) =
      _$ReservationImpl;
  const _Reservation._() : super._();

  factory _Reservation.fromJson(Map<String, dynamic> json) =
      _$ReservationImpl.fromJson;

  @override

  /// Unique identifier of this reservation.
  int get id;
  @override

  /// The id of the slot this reservation is for.
  @JsonKey(name: 'slotid')
  int get slotId;
  @override

  /// The date of this reservation.
  @ReservationDateTimeConverter()
  DateTime get date;
  @override

  /// The id of this reservation is for.
  @JsonKey(name: 'userid')
  int get userId;
  @override

  /// The id of the user that made this reservation.
  @JsonKey(name: 'reserverid')
  int get reserverId;
  @override
  @JsonKey(ignore: true)
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
