// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlanMember _$PlanMemberFromJson(Map<String, dynamic> json) {
  return _PlanMember.fromJson(json);
}

/// @nodoc
mixin _$PlanMember {
  /// The ID of the [User].
  @JsonKey(name: 'userid')
  int get id => throw _privateConstructorUsedError;

  /// The access type of the member.
  @JsonKey(name: 'accesstype')
  PlanMemberAccessType get accessType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlanMemberCopyWith<PlanMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanMemberCopyWith<$Res> {
  factory $PlanMemberCopyWith(
          PlanMember value, $Res Function(PlanMember) then) =
      _$PlanMemberCopyWithImpl<$Res, PlanMember>;
  @useResult
  $Res call(
      {@JsonKey(name: 'userid') int id,
      @JsonKey(name: 'accesstype') PlanMemberAccessType accessType});
}

/// @nodoc
class _$PlanMemberCopyWithImpl<$Res, $Val extends PlanMember>
    implements $PlanMemberCopyWith<$Res> {
  _$PlanMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accessType = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      accessType: null == accessType
          ? _value.accessType
          : accessType // ignore: cast_nullable_to_non_nullable
              as PlanMemberAccessType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlanMemberImplCopyWith<$Res>
    implements $PlanMemberCopyWith<$Res> {
  factory _$$PlanMemberImplCopyWith(
          _$PlanMemberImpl value, $Res Function(_$PlanMemberImpl) then) =
      __$$PlanMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'userid') int id,
      @JsonKey(name: 'accesstype') PlanMemberAccessType accessType});
}

/// @nodoc
class __$$PlanMemberImplCopyWithImpl<$Res>
    extends _$PlanMemberCopyWithImpl<$Res, _$PlanMemberImpl>
    implements _$$PlanMemberImplCopyWith<$Res> {
  __$$PlanMemberImplCopyWithImpl(
      _$PlanMemberImpl _value, $Res Function(_$PlanMemberImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accessType = null,
  }) {
    return _then(_$PlanMemberImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      accessType: null == accessType
          ? _value.accessType
          : accessType // ignore: cast_nullable_to_non_nullable
              as PlanMemberAccessType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlanMemberImpl extends _PlanMember {
  const _$PlanMemberImpl(
      {@JsonKey(name: 'userid') required this.id,
      @JsonKey(name: 'accesstype') required this.accessType})
      : super._();

  factory _$PlanMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanMemberImplFromJson(json);

  /// The ID of the [User].
  @override
  @JsonKey(name: 'userid')
  final int id;

  /// The access type of the member.
  @override
  @JsonKey(name: 'accesstype')
  final PlanMemberAccessType accessType;

  @override
  String toString() {
    return 'PlanMember(id: $id, accessType: $accessType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accessType, accessType) ||
                other.accessType == accessType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, accessType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanMemberImplCopyWith<_$PlanMemberImpl> get copyWith =>
      __$$PlanMemberImplCopyWithImpl<_$PlanMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanMemberImplToJson(
      this,
    );
  }
}

abstract class _PlanMember extends PlanMember {
  const factory _PlanMember(
      {@JsonKey(name: 'userid') required final int id,
      @JsonKey(name: 'accesstype')
      required final PlanMemberAccessType accessType}) = _$PlanMemberImpl;
  const _PlanMember._() : super._();

  factory _PlanMember.fromJson(Map<String, dynamic> json) =
      _$PlanMemberImpl.fromJson;

  @override

  /// The ID of the [User].
  @JsonKey(name: 'userid')
  int get id;
  @override

  /// The access type of the member.
  @JsonKey(name: 'accesstype')
  PlanMemberAccessType get accessType;
  @override
  @JsonKey(ignore: true)
  _$$PlanMemberImplCopyWith<_$PlanMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
