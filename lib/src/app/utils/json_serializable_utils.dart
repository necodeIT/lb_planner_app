import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

/// Implements serialization and deserialization for [DateTime] from and to [int].
///
/// The integer is expected to be a Unix timestamp in milliseconds.
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
class UnixTimestampConverter extends JsonConverter<DateTime, int> {
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
  DateTime fromJson(int json) {
    return DateTime.fromMillisecondsSinceEpoch(json * 1000);
  }

  @override
  int toJson(DateTime object) {
    return object.millisecondsSinceEpoch ~/ 1000;
  }
}

/// Implements nullable serialization and deserialization for [DateTime] from and to [int].
///
/// The integer is expected to be a Unix timestamp in milliseconds.
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
class UnixTimestampConverterNullable extends JsonConverter<DateTime?, int?> {
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
  const UnixTimestampConverterNullable();

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

/// {@template bool_converter}
/// Implements serialization and deserialization for [bool] from [bool] and [int] and converts it to an [int].
///
/// This is a workaround for moodle being special needs and expecting 1 and 0 as input but returning true and false as output.
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
/// {@endtemplate}
class BoolConverter extends JsonConverter<bool, dynamic> {
  /// {@macro bool_converter}
  const BoolConverter();

  @override
  bool fromJson(dynamic json) {
    if (json is int) {
      return json == 1;
    } else if (json is bool) {
      return json;
    } else {
      throw ArgumentError.value(json, 'json', 'Expected an int or a bool');
    }
  }

  @override
  num toJson(bool object) {
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
    // Credit: https://stackoverflow.com/a/50081214
    final buffer = StringBuffer();
    if (json.length == 6 || json.length == 7) buffer.write('ff');
    buffer.write(json.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  String toJson(Color object) {
    // Credit: https://stackoverflow.com/a/50081214
    return '#'
        '${(object.r * 255).toInt().toRadixString(16).padLeft(2, '0')}'
        '${(object.g * 255).toInt().toRadixString(16).padLeft(2, '0')}'
        '${(object.b * 255).toInt().toRadixString(16).padLeft(2, '0')}';
  }
}
