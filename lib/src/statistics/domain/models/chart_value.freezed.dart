// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChartValue {
  /// The name of the value.
  String get name => throw _privateConstructorUsedError;

  /// The value itself.
  double get value => throw _privateConstructorUsedError;

  /// The percentage of the value compared to the total.
  double get percentage => throw _privateConstructorUsedError;

  /// The color of the value.
  Color get color => throw _privateConstructorUsedError;

  /// Create a copy of ChartValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChartValueCopyWith<ChartValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartValueCopyWith<$Res> {
  factory $ChartValueCopyWith(
          ChartValue value, $Res Function(ChartValue) then) =
      _$ChartValueCopyWithImpl<$Res, ChartValue>;
  @useResult
  $Res call({String name, double value, double percentage, Color color});
}

/// @nodoc
class _$ChartValueCopyWithImpl<$Res, $Val extends ChartValue>
    implements $ChartValueCopyWith<$Res> {
  _$ChartValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChartValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
    Object? percentage = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChartValueImplCopyWith<$Res>
    implements $ChartValueCopyWith<$Res> {
  factory _$$ChartValueImplCopyWith(
          _$ChartValueImpl value, $Res Function(_$ChartValueImpl) then) =
      __$$ChartValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double value, double percentage, Color color});
}

/// @nodoc
class __$$ChartValueImplCopyWithImpl<$Res>
    extends _$ChartValueCopyWithImpl<$Res, _$ChartValueImpl>
    implements _$$ChartValueImplCopyWith<$Res> {
  __$$ChartValueImplCopyWithImpl(
      _$ChartValueImpl _value, $Res Function(_$ChartValueImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChartValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = null,
    Object? percentage = null,
    Object? color = null,
  }) {
    return _then(_$ChartValueImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$ChartValueImpl extends _ChartValue {
  const _$ChartValueImpl(
      {required this.name,
      required this.value,
      required this.percentage,
      required this.color})
      : super._();

  /// The name of the value.
  @override
  final String name;

  /// The value itself.
  @override
  final double value;

  /// The percentage of the value compared to the total.
  @override
  final double percentage;

  /// The color of the value.
  @override
  final Color color;

  @override
  String toString() {
    return 'ChartValue(name: $name, value: $value, percentage: $percentage, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChartValueImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, value, percentage, color);

  /// Create a copy of ChartValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChartValueImplCopyWith<_$ChartValueImpl> get copyWith =>
      __$$ChartValueImplCopyWithImpl<_$ChartValueImpl>(this, _$identity);
}

abstract class _ChartValue extends ChartValue {
  const factory _ChartValue(
      {required final String name,
      required final double value,
      required final double percentage,
      required final Color color}) = _$ChartValueImpl;
  const _ChartValue._() : super._();

  /// The name of the value.
  @override
  String get name;

  /// The value itself.
  @override
  double get value;

  /// The percentage of the value compared to the total.
  @override
  double get percentage;

  /// The color of the value.
  @override
  Color get color;

  /// Create a copy of ChartValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChartValueImplCopyWith<_$ChartValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
