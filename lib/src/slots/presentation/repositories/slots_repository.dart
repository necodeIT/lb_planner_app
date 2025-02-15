import 'dart:async';
import 'dart:collection';

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
  bool get refreshOptimization => true;

  @override
  FutureOr<void> build(BuildTrigger trigger) {
    final transaction = startTransaction('loadSlots');
    waitForData(_auth);

    guard(
      () async => _datasource.getSlots(waitForData(_auth).pick(Webservice.lb_planner_api)),
    );
    transaction.finish();
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

    final transaction = startTransaction('bookSlot');

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

      await build(this);
    } catch (e) {
      log('Failed to reserve slot: $e');
    } finally {
      await transaction.commit();
    }
  }

  /// Groups all slots by their weekday and time unit.
  Map<Weekday, Map<(SlotTimeUnit, SlotTimeUnit), List<Slot>>> group() {
    if (!state.hasData) {
      return {};
    }

    final grouped = <Weekday, SplayTreeMap<(SlotTimeUnit, SlotTimeUnit), List<Slot>>>{};

    for (final slot in state.requireData) {
      grouped[slot.weekday] ??= SplayTreeMap((a, b) {
        if (a.$1 == b.$1) {
          return a.$2.compareTo(b.$2);
        }

        return a.$1.compareTo(b.$1);
      });

      final timeGroup = (slot.startUnit, slot.endUnit);

      grouped[slot.weekday]![timeGroup] ??= [];

      grouped[slot.weekday]![timeGroup]!.add(slot);
    }

    return grouped;
  }

  /// Returns all slots that are reserved for today.
  List<Slot> getReservedSlotsForToday() {
    if (!state.hasData) {
      return [];
    }

    final now = DateTime.now();

    return state.requireData.where((s) {
      return s.reserved && s.weekday.dateTimeWeekday == now.weekday;
    }).toList();
  }

  @override
  void dispose() {
    _datasource.dispose();
    super.dispose();
  }
}
