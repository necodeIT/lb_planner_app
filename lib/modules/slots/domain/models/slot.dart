// ignore_for_file: invalid_annotation_target

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'slot.freezed.dart';
part 'slot.g.dart';

/// A reservable slot in the school's timetable.
@freezed
class Slot with _$Slot {
  /// A reservable slot in the school's timetable.
  const factory Slot({
    /// Unique identifier of this slot.
    required int id,

    /// The start time of this slot.
    @JsonValue('startunit') required SlotTimeUnit startUnit,

    /// The duration of this slot interpreted as [SlotTimeUnit]s.
    required int duration,

    /// The weekday this slot takes place on.
    required Weekday weekday,

    /// The room this slot takes place in.
    required String room,

    /// The number of students that can attend this slot.
    required int size,

    /// The number of students that have already reserved this slot.
    @JsonValue('fullness') required int reservations,

    /// `true` if the current user has reserved this slot.
    @JsonValue('forcuruser') required bool reserved,

    /// The user ids of those supervising this slot.
    @Default([]) List<int> supervisors,
  }) = _Slot;

  const Slot._();

  /// Creates a [Slot] without [Slot.id], [Slot.reservations], [Slot.reserved] and [Slot.supervisors].
  factory Slot.noId({
    required SlotTimeUnit startUnit,
    required int duration,
    required Weekday weekday,
    required String room,
    required int size,
  }) =>
      Slot(
        id: -1,
        startUnit: startUnit,
        duration: duration,
        weekday: weekday,
        room: room,
        size: size,
        reservations: 0,
        reserved: false,
        supervisors: [],
      );

  /// End time of this slot.
  SlotTimeUnit get endUnit => startUnit + duration;

  /// Creates a [Slot] from [json].
  factory Slot.fromJson(Map<String, Object?> json) => _$SlotFromJson(json);
}

/// The weekday of a [Slot].
enum Weekday {
  /// Monday (duh).
  @JsonValue(1)
  monday,

  /// Tuesday (duh).
  @JsonValue(2)
  tuesday,

  /// Wednesday (duh).
  @JsonValue(3)
  wednesday,

  /// Thursday (duh).
  @JsonValue(4)
  thursday,

  /// Friday (duh).
  @JsonValue(5)
  friday,

  /// Saturday (duh).
  @JsonValue(6)
  saturday,

  /// Sunday (duh).
  @JsonValue(7)
  sunday;

  /// Returns the dates of this weekday between [start] and [end].
  List<DateTime> getDates(DateTime start, DateTime end) {
    final dates = <DateTime>[];
    for (var date = start; date.isBefore(end); date = date.add(const Duration(days: 1))) {
      if (date.weekday == index + 1) {
        dates.add(date);
      }
    }
    return dates;
  }

  /// Returns the dates of this weekday starting from [DateTime.now()] until [weeks] weeks in the future.
  List<DateTime> futureDates([int weeks = 1]) {
    return getDates(DateTime.now(), DateTime.now().add(Duration(days: 7 * weeks)));
  }

  /// Returns the next date of this weekday.
  ///
  /// If this weekday is today, [DateTime.now()] is returned.
  DateTime get nextDate {
    final now = DateTime.now();
    for (var i = 0; i < 7; i++) {
      final date = now.add(Duration(days: i));
      if (date.weekday == index + 1) {
        return date;
      }
    }
    throw StateError('Could not find next date for $this');
  }

  /// Returns the date of this weekday [index] weeks in the future.
  /// 0 means the next date (including today), 1 means the date after the next date, etc.
  DateTime peek(int index) {
    return futureDates(index).last;
  }
}

/// A time unit as defined in [lb_planner_plugin](https://github.com/necodeIT/lb_planner_plugin/blob/2f118f50aad5e4fb9d425b59b3ebccbdf1a16cd8/lbplanner/classes/helpers/slot_helper.php#L55)
enum SlotTimeUnit {
  /// 08:00
  @JsonValue(1)
  $1(TimeOfDay(hour: 8, minute: 0)),

  /// 08:50
  @JsonValue(2)
  $2(TimeOfDay(hour: 8, minute: 50)),

  /// 09:50
  @JsonValue(3)
  $3(TimeOfDay(hour: 9, minute: 50)),

  /// 10:40
  @JsonValue(4)
  $4(TimeOfDay(hour: 10, minute: 40)),

  /// 11:30
  @JsonValue(5)
  $5(TimeOfDay(hour: 11, minute: 30)),

  /// 12:30
  @JsonValue(6)
  $6(TimeOfDay(hour: 12, minute: 30)),

  /// 13:20
  @JsonValue(7)
  $7(TimeOfDay(hour: 13, minute: 20)),

  /// 14:10
  @JsonValue(8)
  $8(TimeOfDay(hour: 14, minute: 10)),

  /// 15:10
  @JsonValue(9)
  $9(TimeOfDay(hour: 15, minute: 10)),

  /// 16:00
  @JsonValue(10)
  $10(TimeOfDay(hour: 16, minute: 0)),

  /// 17:00
  @JsonValue(11)
  $11(TimeOfDay(hour: 17, minute: 0)),

  /// 17:45
  @JsonValue(12)
  $12(TimeOfDay(hour: 17, minute: 45)),

  /// 18:45
  @JsonValue(13)
  $13(TimeOfDay(hour: 18, minute: 45)),

  /// 19:30
  @JsonValue(14)
  $14(TimeOfDay(hour: 19, minute: 30)),

  /// 20:15
  @JsonValue(15)
  $15(TimeOfDay(hour: 20, minute: 15)),

  /// 21:00
  @JsonValue(16)
  $16(TimeOfDay(hour: 21, minute: 0));

  /// The human-readable representation of this time unit.
  final TimeOfDay timeOfDay;

  const SlotTimeUnit(this.timeOfDay);

  /// Adds [other] to this [SlotTimeUnit] and returns the resulting [SlotTimeUnit].
  SlotTimeUnit operator +(int other) {
    final newIndex = index + other;

    if (newIndex < 0 || newIndex >= SlotTimeUnit.values.length) {
      throw RangeError('SlotTimeUnit index out of bounds: $newIndex. Must be between 0 and ${SlotTimeUnit.values.length - 1}');
    }

    return SlotTimeUnit.values[newIndex];
  }

  /// Subtracts [other] from this [SlotTimeUnit] and returns the resulting [SlotTimeUnit].
  SlotTimeUnit operator -(int other) {
    return this + (-other);
  }

  /// Returns `true` if this [SlotTimeUnit] is later than [other].
  bool operator >(SlotTimeUnit other) => index > other.index;

  /// Returns `true` if this [SlotTimeUnit] is earlier than [other].
  bool operator <(SlotTimeUnit other) => index < other.index;

  /// Returns `true` if this [SlotTimeUnit] is later than or equal to [other].
  bool operator >=(SlotTimeUnit other) => index >= other.index;

  /// Returns `true` if this [SlotTimeUnit] is earlier than or equal to [other].
  bool operator <=(SlotTimeUnit other) => index <= other.index;

  /// Returns the **absolute** duration between this [SlotTimeUnit] and [other] in minutes.
  Duration duration(SlotTimeUnit other) {
    return Duration(
      hours: (other.timeOfDay.hour - timeOfDay.hour).abs(),
      minutes: (other.timeOfDay.minute - timeOfDay.minute).abs(),
    );
  }
}
