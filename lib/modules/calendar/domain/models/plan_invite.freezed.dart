// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_invite.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlanInvite _$PlanInviteFromJson(Map<String, dynamic> json) {
  return _PlanInvite.fromJson(json);
}

/// @nodoc
mixin _$PlanInvite {
  /// The ID of this invitation.
  int get id => throw _privateConstructorUsedError;

  /// The ID of the [User] who created this invite.
  @JsonKey(name: 'inviterid')
  int get inviterId => throw _privateConstructorUsedError;

  /// The ID of the [CalendarPlan] this invite is for.
  @JsonKey(name: 'planid')
  int get planId => throw _privateConstructorUsedError;

  /// The ID of the [User] who is invited.
  @JsonKey(name: 'inviteeid')
  int get invitedUserId => throw _privateConstructorUsedError;

  /// The status of this invite.
  PlanInviteStatus get status => throw _privateConstructorUsedError;

  /// The date and time this invite was created.
  @UnixTimestampConverter()
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this PlanInvite to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlanInvite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanInviteCopyWith<PlanInvite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanInviteCopyWith<$Res> {
  factory $PlanInviteCopyWith(
          PlanInvite value, $Res Function(PlanInvite) then) =
      _$PlanInviteCopyWithImpl<$Res, PlanInvite>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'inviterid') int inviterId,
      @JsonKey(name: 'planid') int planId,
      @JsonKey(name: 'inviteeid') int invitedUserId,
      PlanInviteStatus status,
      @UnixTimestampConverter() DateTime timestamp});
}

/// @nodoc
class _$PlanInviteCopyWithImpl<$Res, $Val extends PlanInvite>
    implements $PlanInviteCopyWith<$Res> {
  _$PlanInviteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanInvite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? inviterId = null,
    Object? planId = null,
    Object? invitedUserId = null,
    Object? status = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      inviterId: null == inviterId
          ? _value.inviterId
          : inviterId // ignore: cast_nullable_to_non_nullable
              as int,
      planId: null == planId
          ? _value.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as int,
      invitedUserId: null == invitedUserId
          ? _value.invitedUserId
          : invitedUserId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlanInviteStatus,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlanInviteImplCopyWith<$Res>
    implements $PlanInviteCopyWith<$Res> {
  factory _$$PlanInviteImplCopyWith(
          _$PlanInviteImpl value, $Res Function(_$PlanInviteImpl) then) =
      __$$PlanInviteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'inviterid') int inviterId,
      @JsonKey(name: 'planid') int planId,
      @JsonKey(name: 'inviteeid') int invitedUserId,
      PlanInviteStatus status,
      @UnixTimestampConverter() DateTime timestamp});
}

/// @nodoc
class __$$PlanInviteImplCopyWithImpl<$Res>
    extends _$PlanInviteCopyWithImpl<$Res, _$PlanInviteImpl>
    implements _$$PlanInviteImplCopyWith<$Res> {
  __$$PlanInviteImplCopyWithImpl(
      _$PlanInviteImpl _value, $Res Function(_$PlanInviteImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlanInvite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? inviterId = null,
    Object? planId = null,
    Object? invitedUserId = null,
    Object? status = null,
    Object? timestamp = null,
  }) {
    return _then(_$PlanInviteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      inviterId: null == inviterId
          ? _value.inviterId
          : inviterId // ignore: cast_nullable_to_non_nullable
              as int,
      planId: null == planId
          ? _value.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as int,
      invitedUserId: null == invitedUserId
          ? _value.invitedUserId
          : invitedUserId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PlanInviteStatus,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlanInviteImpl extends _PlanInvite {
  const _$PlanInviteImpl(
      {required this.id,
      @JsonKey(name: 'inviterid') required this.inviterId,
      @JsonKey(name: 'planid') required this.planId,
      @JsonKey(name: 'inviteeid') required this.invitedUserId,
      required this.status,
      @UnixTimestampConverter() required this.timestamp})
      : super._();

  factory _$PlanInviteImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanInviteImplFromJson(json);

  /// The ID of this invitation.
  @override
  final int id;

  /// The ID of the [User] who created this invite.
  @override
  @JsonKey(name: 'inviterid')
  final int inviterId;

  /// The ID of the [CalendarPlan] this invite is for.
  @override
  @JsonKey(name: 'planid')
  final int planId;

  /// The ID of the [User] who is invited.
  @override
  @JsonKey(name: 'inviteeid')
  final int invitedUserId;

  /// The status of this invite.
  @override
  final PlanInviteStatus status;

  /// The date and time this invite was created.
  @override
  @UnixTimestampConverter()
  final DateTime timestamp;

  @override
  String toString() {
    return 'PlanInvite(id: $id, inviterId: $inviterId, planId: $planId, invitedUserId: $invitedUserId, status: $status, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanInviteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.inviterId, inviterId) ||
                other.inviterId == inviterId) &&
            (identical(other.planId, planId) || other.planId == planId) &&
            (identical(other.invitedUserId, invitedUserId) ||
                other.invitedUserId == invitedUserId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, inviterId, planId, invitedUserId, status, timestamp);

  /// Create a copy of PlanInvite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanInviteImplCopyWith<_$PlanInviteImpl> get copyWith =>
      __$$PlanInviteImplCopyWithImpl<_$PlanInviteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanInviteImplToJson(
      this,
    );
  }
}

abstract class _PlanInvite extends PlanInvite {
  const factory _PlanInvite(
          {required final int id,
          @JsonKey(name: 'inviterid') required final int inviterId,
          @JsonKey(name: 'planid') required final int planId,
          @JsonKey(name: 'inviteeid') required final int invitedUserId,
          required final PlanInviteStatus status,
          @UnixTimestampConverter() required final DateTime timestamp}) =
      _$PlanInviteImpl;
  const _PlanInvite._() : super._();

  factory _PlanInvite.fromJson(Map<String, dynamic> json) =
      _$PlanInviteImpl.fromJson;

  /// The ID of this invitation.
  @override
  int get id;

  /// The ID of the [User] who created this invite.
  @override
  @JsonKey(name: 'inviterid')
  int get inviterId;

  /// The ID of the [CalendarPlan] this invite is for.
  @override
  @JsonKey(name: 'planid')
  int get planId;

  /// The ID of the [User] who is invited.
  @override
  @JsonKey(name: 'inviteeid')
  int get invitedUserId;

  /// The status of this invite.
  @override
  PlanInviteStatus get status;

  /// The date and time this invite was created.
  @override
  @UnixTimestampConverter()
  DateTime get timestamp;

  /// Create a copy of PlanInvite
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanInviteImplCopyWith<_$PlanInviteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
