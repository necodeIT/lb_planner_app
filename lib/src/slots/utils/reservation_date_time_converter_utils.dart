import 'package:mcquenji_core/mcquenji_core.dart';

/// Converts a [DateTime] to a string in the format 'yyyy-MM-dd' and vice versa.
class ReservationDateTimeConverter extends IGenericSerializer<DateTime, String> {
  /// Converts a [DateTime] to a string in the format 'yyyy-MM-dd' and vice versa.
  const ReservationDateTimeConverter();

  @override
  String serialize(DateTime data) {
    return data.toIso8601String().substring(0, 10);
  }

  @override
  DateTime deserialize(String data) {
    return DateTime.parse(data);
  }
}
