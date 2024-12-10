// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lb_planner/modules/slots/slots.dart';

part 'reservation.freezed.dart';
part 'reservation.g.dart';

/// A reservation for a [Slot].
@freezed
class Reservation with _$Reservation {
  /// A reservation for a [Slot].
  const factory Reservation({
    /// Unique identifier of this reservation.
    required int id,

    /// The id of the slot this reservation is for.
    @JsonKey(name: 'slotid') required int slotId,

    /// The date of this reservation.
    @ReservationDateTimeConverter() required DateTime date,

    /// The id of this reservation is for.
    @JsonKey(name: 'userid') required int userId,

    /// The id of the user that made this reservation.
    @JsonKey(name: 'reserverid') required int reserverId,
  }) = _Reservation;

  const Reservation._();

  /// Creates a [Reservation] from [json].
  factory Reservation.fromJson(Map<String, Object?> json) => _$ReservationFromJson(json);
}
