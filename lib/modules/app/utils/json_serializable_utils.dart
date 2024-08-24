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
class BoolConverter extends JsonConverter<bool, num> {
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
  bool fromJson(num json) {
    return json == 1;
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
    return '#${object.alpha.toRadixString(16).padLeft(2, '0')}'
        '${object.red.toRadixString(16).padLeft(2, '0')}'
        '${object.green.toRadixString(16).padLeft(2, '0')}'
        '${object.blue.toRadixString(16).padLeft(2, '0')}';
  }
}
