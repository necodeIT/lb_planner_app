import 'dart:async';

import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/src/slots/slots.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Holds all slots the current user can reserve.
class SlotsRepository extends Repository<AsyncValue<List<Slot>>> {
  final AuthRepository _auth;
  final SlotsDatasource _datasource;

  /// Holds all slots the current user can reserve.
  SlotsRepository(this._auth, this._datasource) : super(AsyncValue.loading()) {
    watchAsync(_auth);
  }

  @override
  Duration get updateInterval => kImportantRefreshIntervalDuration;

  @override
  FutureOr<void> build(Type trigger) {
    waitForData(_auth);

    guard(
      () async => _datasource.getSlots(waitForData(_auth).pick(Webservice.lb_planner_api)),
    );
  }

  /// Books the given [slot] for the current user at the given [date].
  Future<void> book({required Slot slot, required DateTime date}) async {
    if (!state.hasData) {
      log('Cannot book slot ${slot.id} for current user: No data');
      return;
    }

    if (slot.reserved) {
      log('Cannot book slot ${slot.id} for current user: Already reserved');

      return;
    }

    if (slot.reservations >= slot.size) {
      log('Cannot book slot ${slot.id} for current user: No more slots available');

      return;
    }

    log('Reserving slot ${slot.id} for current user');
    try {
      data(
        state.requireData.map(
          (s) {
            if (s.id == slot.id) {
              return s.copyWith(
                reservations: s.reservations + 1,
                reserved: true,
              );
            }

            return s;
          },
        ).toList(),
      );

      await _datasource.reserveSlot(
        token: _auth.state.requireData.pick(Webservice.lb_planner_api),
        slotId: slot.id,
        date: date,
      );

      await captureEvent(
        'slot_reserved',
        properties: {
          'reservation_date': DateTime.now().toIso8601String(),
          'date': date.toIso8601String(),
        },
      );

      log('Reserved slot ${slot.id} for current user');
    } catch (e) {
      log('Failed to reserve slot: $e');
    }
  }

  /// Groups all slots by their weekday and time unit.
  Map<Weekday, Map<(SlotTimeUnit, SlotTimeUnit), List<Slot>>> group() {
    if (!state.hasData) {
      return {};
    }

    final grouped = <Weekday, Map<(SlotTimeUnit, SlotTimeUnit), List<Slot>>>{};

    for (final slot in state.requireData) {
      grouped[slot.weekday] ??= {};

      final timeGroup = (slot.startUnit, slot.endUnit);

      grouped[slot.weekday]![timeGroup] ??= [];

      grouped[slot.weekday]![timeGroup]!.add(slot);

      grouped[slot.weekday]![timeGroup]!.sort(
        (a, b) {
          if (a.startUnit == b.startUnit) {
            return a.endUnit.compareTo(b.endUnit);
          }

          return a.startUnit.compareTo(b.startUnit);
        },
      );
    }

    return grouped;
  }

  @override
  void dispose() {
    _datasource.dispose();
    super.dispose();
  }
}
