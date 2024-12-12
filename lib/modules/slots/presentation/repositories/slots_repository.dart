import 'dart:async';

import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/slots/slots.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Holds all slots the current user can reserve.
class SlotsRepository extends Repository<AsyncValue<List<SlotAggregate>>> {
  final AuthRepository _auth;
  final UsersRepository _users;
  final MoodleCoursesRepository _courses;
  final SlotsDatasource _datasource;

  /// Holds all slots the current user can reserve.
  SlotsRepository(this._auth, this._users, this._courses, this._datasource) : super(AsyncValue.loading()) {
    watchAsync(_auth);
    watchAsync(_users);
    watchAsync(_courses);
  }

  @override
  Duration get updateInterval => kImportantRefreshIntervalDuration;

  @override
  FutureOr<void> build(Type trigger) {
    waitForData(_auth);

    guard(
      () async {
        final rawSlots = await _datasource.getSlots(waitForData(_auth).pick(Webservice.lb_planner_api));

        final slots = <SlotAggregate>[];

        for (final rawSlot in rawSlots) {
          final mappings = await _datasource.getSlotMappings(
            token: _auth.state.requireData.pick(Webservice.lb_planner_api),
            slotId: rawSlot.id,
          );

          slots.add(
            rawSlot.join(
              users: _users.state.requireData,
              courses: _courses.state.requireData,
              mappings: mappings,
            ),
          );
        }

        return slots;
      },
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
      await _datasource.reserveSlot(
        token: _auth.state.requireData.pick(Webservice.lb_planner_api),
        slotId: slot.id,
        date: date,
      );

      data(
        state.requireData.map(
          (s) {
            if (s.slot.id == slot.id) {
              return s.copyWith(
                slot: s.slot.copyWith(
                  reservations: s.slot.reservations + 1,
                  reserved: true,
                ),
              );
            }

            return s;
          },
        ).toList(),
      );

      log('Reserved slot ${slot.id} for current user');
    } catch (e) {
      log('Failed to reserve slot: $e');
    }
  }

  @override
  void dispose() {
    _datasource.dispose();
    super.dispose();
  }
}
