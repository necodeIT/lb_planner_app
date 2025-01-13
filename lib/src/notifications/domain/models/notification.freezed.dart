// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return _Notification.fromJson(json);
}

/// @nodoc
mixin _$Notification {
  /// The notification's unique identifier.
  @JsonKey(name: 'notificationid')
  int get id => throw _privateConstructorUsedError;

  /// The timestamp when the notification was sent.
  @UnixTimestampConverter()
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// The timestamp when the notification was read.
  @UnixTimestampConverter()
  @JsonKey(name: 'timestamp_read')
  DateTime? get readAt => throw _privateConstructorUsedError;

  /// The type of the notification.
  ///
  /// The message is displayed differently based on the type.
  NotificationType get type => throw _privateConstructorUsedError;

  /// Additional context for the notification.
  /// Interpretation depends on the [type].
  @JsonKey(name: 'info')
  int? get context => throw _privateConstructorUsedError;

  /// `true` if the notification has been read.
  @BoolConverter()
  @JsonKey(name: 'status')
  bool get read => throw _privateConstructorUsedError;
  @JsonKey(name: 'userid')
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this Notification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationCopyWith<Notification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationCopyWith<$Res> {
  factory $NotificationCopyWith(
          Notification value, $Res Function(Notification) then) =
      _$NotificationCopyWithImpl<$Res, Notification>;
  @useResult
  $Res call(
      {@JsonKey(name: 'notificationid') int id,
      @UnixTimestampConverter() DateTime timestamp,
      @UnixTimestampConverter()
      @JsonKey(name: 'timestamp_read')
      DateTime? readAt,
      NotificationType type,
      @JsonKey(name: 'info') int? context,
      @BoolConverter() @JsonKey(name: 'status') bool read,
      @JsonKey(name: 'userid') int userId});
}

/// @nodoc
class _$NotificationCopyWithImpl<$Res, $Val extends Notification>
    implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? readAt = freezed,
    Object? type = null,
    Object? context = freezed,
    Object? read = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as int?,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationImplCopyWith<$Res>
    implements $NotificationCopyWith<$Res> {
  factory _$$NotificationImplCopyWith(
          _$NotificationImpl value, $Res Function(_$NotificationImpl) then) =
      __$$NotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'notificationid') int id,
      @UnixTimestampConverter() DateTime timestamp,
      @UnixTimestampConverter()
      @JsonKey(name: 'timestamp_read')
      DateTime? readAt,
      NotificationType type,
      @JsonKey(name: 'info') int? context,
      @BoolConverter() @JsonKey(name: 'status') bool read,
      @JsonKey(name: 'userid') int userId});
}

/// @nodoc
class __$$NotificationImplCopyWithImpl<$Res>
    extends _$NotificationCopyWithImpl<$Res, _$NotificationImpl>
    implements _$$NotificationImplCopyWith<$Res> {
  __$$NotificationImplCopyWithImpl(
      _$NotificationImpl _value, $Res Function(_$NotificationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? timestamp = null,
    Object? readAt = freezed,
    Object? type = null,
    Object? context = freezed,
    Object? read = null,
    Object? userId = null,
  }) {
    return _then(_$NotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as int?,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationImpl extends _Notification {
  const _$NotificationImpl(
      {@JsonKey(name: 'notificationid') required this.id,
      @UnixTimestampConverter() required this.timestamp,
      @UnixTimestampConverter() @JsonKey(name: 'timestamp_read') this.readAt,
      required this.type,
      @JsonKey(name: 'info') this.context,
      @BoolConverter() @JsonKey(name: 'status') required this.read,
      @JsonKey(name: 'userid') required this.userId})
      : super._();

  factory _$NotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationImplFromJson(json);

  /// The notification's unique identifier.
  @override
  @JsonKey(name: 'notificationid')
  final int id;

  /// The timestamp when the notification was sent.
  @override
  @UnixTimestampConverter()
  final DateTime timestamp;

  /// The timestamp when the notification was read.
  @override
  @UnixTimestampConverter()
  @JsonKey(name: 'timestamp_read')
  final DateTime? readAt;

  /// The type of the notification.
  ///
  /// The message is displayed differently based on the type.
  @override
  final NotificationType type;

  /// Additional context for the notification.
  /// Interpretation depends on the [type].
  @override
  @JsonKey(name: 'info')
  final int? context;

  /// `true` if the notification has been read.
  @override
  @BoolConverter()
  @JsonKey(name: 'status')
  final bool read;
  @override
  @JsonKey(name: 'userid')
  final int userId;

  @override
  String toString() {
    return 'Notification(id: $id, timestamp: $timestamp, readAt: $readAt, type: $type, context: $context, read: $read, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, timestamp, readAt, type, context, read, userId);

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationImplCopyWith<_$NotificationImpl> get copyWith =>
      __$$NotificationImplCopyWithImpl<_$NotificationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationImplToJson(
      this,
    );
  }
}

abstract class _Notification extends Notification {
  const factory _Notification(
      {@JsonKey(name: 'notificationid') required final int id,
      @UnixTimestampConverter() required final DateTime timestamp,
      @UnixTimestampConverter()
      @JsonKey(name: 'timestamp_read')
      final DateTime? readAt,
      required final NotificationType type,
      @JsonKey(name: 'info') final int? context,
      @BoolConverter() @JsonKey(name: 'status') required final bool read,
      @JsonKey(name: 'userid') required final int userId}) = _$NotificationImpl;
  const _Notification._() : super._();

  factory _Notification.fromJson(Map<String, dynamic> json) =
      _$NotificationImpl.fromJson;

  /// The notification's unique identifier.
  @override
  @JsonKey(name: 'notificationid')
  int get id;

  /// The timestamp when the notification was sent.
  @override
  @UnixTimestampConverter()
  DateTime get timestamp;

  /// The timestamp when the notification was read.
  @override
  @UnixTimestampConverter()
  @JsonKey(name: 'timestamp_read')
  DateTime? get readAt;

  /// The type of the notification.
  ///
  /// The message is displayed differently based on the type.
  @override
  NotificationType get type;

  /// Additional context for the notification.
  /// Interpretation depends on the [type].
  @override
  @JsonKey(name: 'info')
  int? get context;

  /// `true` if the notification has been read.
  @override
  @BoolConverter()
  @JsonKey(name: 'status')
  bool get read;
  @override
  @JsonKey(name: 'userid')
  int get userId;

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationImplCopyWith<_$NotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
