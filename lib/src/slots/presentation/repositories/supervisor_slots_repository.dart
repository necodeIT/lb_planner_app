import 'dart:async';

import 'package:collection/collection.dart';
import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/lb_planner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides data for the supervisor slots screen.
class SupervisorSlotsRepository extends Repository<AsyncValue<List<Slot>>> {
  final SlotsDatasource _datasource;
  final AuthRepository _auth;

  /// Provides data for the supervisor slots screen.
  SupervisorSlotsRepository(this._datasource, this._auth) : super(AsyncValue.loading()) {
    watchAsync(_auth);
  }

  @override
  Duration get updateInterval => kImportantRefreshIntervalDuration;

  @override
  FutureOr<void> build(BuildTrigger trigger) {
    final transaction = startTransaction('loadSupervisorSlots');
    waitForData(_auth);

    guard(
      () async => _datasource.getSupervisedSlots(waitForData(_auth).pick(Webservice.lb_planner_api)),
      onData: (_) => log('Slots loaded.'),
      onError: (e, s) {
        log('Failed to load slots', e, s);
        transaction.internalError(e);
      },
    );
    transaction.finish();
  }

  /// Returns a list of reservations for the given [slotId].
  Future<List<Reservation>> getSlotReservations(int slotId) async {
    if (!state.hasData) {
      log('Cannot get reservations for slot $slotId: No data');
      return [];
    }
    final transaction = startTransaction('getSlotReservations');

    try {
      final token = waitForData(_auth).pick(Webservice.lb_planner_api);

      return _datasource.getSlotReservations(token: token, slotId: slotId);
    } catch (e, s) {
      log('Failed to get slot reservations', e, s);
      transaction.internalError(e);
      return [];
    } finally {
      await transaction.commit();
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

  /// Returns the slot with the given [id].
  Slot? getSlotById(int id) {
    if (!state.hasData) {
      return null;
    }

    return state.requireData.firstWhereOrNull((element) => element.id == id);
  }

  @override
  void dispose() {
    super.dispose();
    _datasource.dispose();
  }
}
