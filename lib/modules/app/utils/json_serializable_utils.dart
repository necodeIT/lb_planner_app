import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

/// Implements serialization and deserialization for [DateTime] from and to [int].
///
/// The integer is expected to be a Unix timestamp in seconds.
///
/// Usage:
/// ```dart
/// @JsonSerializable()
/// class MyClass {
///   @JsonKey(name: 'timestamp')
///   @UnixTimestampConverter()
///   final DateTime timestamp;
///
///   const MyClass(this.timestamp);
/// }
/// ```
class UnixTimestampConverter extends JsonConverter<DateTime?, int?> {
  /// Implements serialization and deserialization for [DateTime] from and to [int].
  ///
  /// Usage:
  /// ```dart
  /// @JsonSerializable()
  /// class MyClass {
  ///   @JsonKey(name: 'timestamp')
  ///   @UnixTimestampConverter()
  ///   final DateTime timestamp;
  ///
  ///   const MyClass(this.timestamp);
  /// }
  /// ```
  const UnixTimestampConverter();

  @override
  DateTime? fromJson(int? json) {
    if (json == null) return null;

    return DateTime.fromMillisecondsSinceEpoch(json * 1000);
  }

  @override
  int? toJson(DateTime? object) {
    if (object == null) return null;

    return object.millisecondsSinceEpoch ~/ 1000;
  }
}

/// Implements serialization and deserialization for [bool] from and to [int].
///
/// The integer is expected to be either 0 or 1.
///
/// Usage:
/// ```dart
/// @JsonSerializable()
/// class MyClass {
///   @JsonKey
///   @BoolConverter()
///   final bool enabled;
///
///   const MyClass(this.enabled);
/// }
/// ```
class BoolConverter extends JsonConverter<bool, int> {
  /// Implements serialization and deserialization for [bool] from and to [int].
  ///
  /// Usage:
  /// ```dart
  /// @JsonSerializable()
  /// class MyClass {
  ///   @JsonKey
  ///   @BoolConverter()
  ///   final bool enabled;
  ///
  ///   const MyClass(this.enabled);
  /// }
  /// ```
  const BoolConverter();

  @override
  bool fromJson(int json) {
    return json == 1;
  }

  @override
  int toJson(bool object) {
    return object ? 1 : 0;
  }
}

/// Implements serialization and deserialization for [Color] from and to [String].
///
/// The string is expected to be a hexadecimal color value.
///
/// Usage:
/// ```dart
/// @JsonSerializable()
/// class MyClass {
///   @JsonKey(name: 'color')
///   @HexColorConverter()
///   final Color color;
///
///   const MyClass(this.color);
/// }
/// ```
class HexColorConverter extends JsonConverter<Color, String> {
  /// Implements serialization and deserialization for [Color] from and to [String].
  ///
  /// Usage:
  /// ```dart
  /// @JsonSerializable()
  /// class MyClass {
  ///   @JsonKey(name: 'color')
  ///   @HexColorConverter()
  ///   final Color color;
  ///
  ///   const MyClass(this.color);
  /// }
  /// ```
  const HexColorConverter();

  @override
  Color fromJson(String json) {
    return Color(int.parse(json, radix: 16));
  }

  @override
  String toJson(Color object) {
    return object.value.toRadixString(16);
  }
}
