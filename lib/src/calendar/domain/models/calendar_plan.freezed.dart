// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CalendarPlan _$CalendarPlanFromJson(Map<String, dynamic> json) {
  return _CalendarPlan.fromJson(json);
}

/// @nodoc
mixin _$CalendarPlan {
  /// The name of this plan.
  String get name => throw _privateConstructorUsedError;

  /// The ID of this plan.
  @JsonKey(name: 'planid')
  int get id => throw _privateConstructorUsedError;

  /// A list of deadlines planned by it's [members].
  List<PlanDeadline> get deadlines => throw _privateConstructorUsedError;

  /// A list of all [User]s participating in this plan and their respective access type.
  List<PlanMember> get members => throw _privateConstructorUsedError;

  /// Serializes this CalendarPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CalendarPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarPlanCopyWith<CalendarPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarPlanCopyWith<$Res> {
  factory $CalendarPlanCopyWith(
          CalendarPlan value, $Res Function(CalendarPlan) then) =
      _$CalendarPlanCopyWithImpl<$Res, CalendarPlan>;
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'planid') int id,
      List<PlanDeadline> deadlines,
      List<PlanMember> members});
}

/// @nodoc
class _$CalendarPlanCopyWithImpl<$Res, $Val extends CalendarPlan>
    implements $CalendarPlanCopyWith<$Res> {
  _$CalendarPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalendarPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? deadlines = null,
    Object? members = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      deadlines: null == deadlines
          ? _value.deadlines
          : deadlines // ignore: cast_nullable_to_non_nullable
              as List<PlanDeadline>,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<PlanMember>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarPlanImplCopyWith<$Res>
    implements $CalendarPlanCopyWith<$Res> {
  factory _$$CalendarPlanImplCopyWith(
          _$CalendarPlanImpl value, $Res Function(_$CalendarPlanImpl) then) =
      __$$CalendarPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      @JsonKey(name: 'planid') int id,
      List<PlanDeadline> deadlines,
      List<PlanMember> members});
}

/// @nodoc
class __$$CalendarPlanImplCopyWithImpl<$Res>
    extends _$CalendarPlanCopyWithImpl<$Res, _$CalendarPlanImpl>
    implements _$$CalendarPlanImplCopyWith<$Res> {
  __$$CalendarPlanImplCopyWithImpl(
      _$CalendarPlanImpl _value, $Res Function(_$CalendarPlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of CalendarPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? id = null,
    Object? deadlines = null,
    Object? members = null,
  }) {
    return _then(_$CalendarPlanImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      deadlines: null == deadlines
          ? _value._deadlines
          : deadlines // ignore: cast_nullable_to_non_nullable
              as List<PlanDeadline>,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<PlanMember>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarPlanImpl extends _CalendarPlan {
  const _$CalendarPlanImpl(
      {required this.name,
      @JsonKey(name: 'planid') required this.id,
      required final List<PlanDeadline> deadlines,
      required final List<PlanMember> members})
      : _deadlines = deadlines,
        _members = members,
        super._();

  factory _$CalendarPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarPlanImplFromJson(json);

  /// The name of this plan.
  @override
  final String name;

  /// The ID of this plan.
  @override
  @JsonKey(name: 'planid')
  final int id;

  /// A list of deadlines planned by it's [members].
  final List<PlanDeadline> _deadlines;

  /// A list of deadlines planned by it's [members].
  @override
  List<PlanDeadline> get deadlines {
    if (_deadlines is EqualUnmodifiableListView) return _deadlines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deadlines);
  }

  /// A list of all [User]s participating in this plan and their respective access type.
  final List<PlanMember> _members;

  /// A list of all [User]s participating in this plan and their respective access type.
  @override
  List<PlanMember> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  String toString() {
    return 'CalendarPlan(name: $name, id: $id, deadlines: $deadlines, members: $members)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarPlanImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._deadlines, _deadlines) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      id,
      const DeepCollectionEquality().hash(_deadlines),
      const DeepCollectionEquality().hash(_members));

  /// Create a copy of CalendarPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarPlanImplCopyWith<_$CalendarPlanImpl> get copyWith =>
      __$$CalendarPlanImplCopyWithImpl<_$CalendarPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarPlanImplToJson(
      this,
    );
  }
}

abstract class _CalendarPlan extends CalendarPlan {
  const factory _CalendarPlan(
      {required final String name,
      @JsonKey(name: 'planid') required final int id,
      required final List<PlanDeadline> deadlines,
      required final List<PlanMember> members}) = _$CalendarPlanImpl;
  const _CalendarPlan._() : super._();

  factory _CalendarPlan.fromJson(Map<String, dynamic> json) =
      _$CalendarPlanImpl.fromJson;

  /// The name of this plan.
  @override
  String get name;

  /// The ID of this plan.
  @override
  @JsonKey(name: 'planid')
  int get id;

  /// A list of deadlines planned by it's [members].
  @override
  List<PlanDeadline> get deadlines;

  /// A list of all [User]s participating in this plan and their respective access type.
  @override
  List<PlanMember> get members;

  /// Create a copy of CalendarPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarPlanImplCopyWith<_$CalendarPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
