import 'dart:async';

import 'package:collection/collection.dart';
import 'package:diffutil_dart/diffutil.dart';
import 'package:eduplanner/config/endpoints.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:eduplanner/src/slots/slots.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides data for the slot master screen.
class SlotMasterSlotsRepository extends Repository<AsyncValue<List<Slot>>> with Tracable {
  final AuthRepository _auth;
  final SlotsDatasource _datasource;

  /// Provides data for the slot master screen.
  SlotMasterSlotsRepository(this._auth, this._datasource) : super(AsyncValue.loading()) {
    watchAsync(_auth);

    _datasource.parent = this;
  }

  @override
  Duration get updateInterval => kRefreshIntervalDuration;

  @override
  Future<void> build(BuildTrigger trigger) async {
    final transaction = startTransaction('loadSlotMasterSlots');
    final token = waitForData(_auth);

    await guard(
      () async => _datasource.getAllSlots(token.pick(Webservice.lb_planner_api)),
      onData: (_) => log('Slots loaded.'),
      onError: (e, s) {
        log('Failed to load slots', e, s);
        transaction.internalError(e);
      },
    );
    await transaction.finish();
  }

  /// Creates a new slot.
  Future<void> createSlot(Slot slot) async {
    if (!state.hasData) {
      log('Cannot create new slot: No data');
      return;
    }

    final transaction = startTransaction('createSlot');
    log('Creating slot with id ${slot.id}');
    try {
      final createdSlot = await _datasource.createSlot(
        token: _auth.state.requireData.pick(Webservice.lb_planner_api),
        slot: slot,
      );

      log('Created slot with id ${slot.id}');

      await captureEvent(
        'slot_created',
        properties: {
          'weekday': slot.weekday,
          'size': slot.size,
          'start': slot.startUnit,
          'end': slot.endUnit,
        },
      );

      for (final supervisorId in slot.supervisors) {
        await addSlotSupervisor(slotId: createdSlot.id, supervisorId: supervisorId);
      }

      final mappings = slot.mappings.map((m) => m.copyWith(slotId: createdSlot.id)).toList();

      for (final mapping in mappings) {
        await addMapping(
          slotId: createdSlot.id,
          mapping: mapping,
        );
      }

      await refresh(this);
    } catch (e, s) {
      log('Failed to create slot', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Deletes the slot with the given [slotId].
  Future<void> deleteSlot(int slotId) async {
    if (!state.hasData) {
      log('Cannot delete slot: No data');
      return;
    }

    final transaction = startTransaction('deleteSlot');
    log('Deleting slot with id $slotId');
    try {
      data(state.requireData.where((s) => s.id != slotId).toList());

      await _datasource.deleteSlot(token: _auth.state.requireData.pick(Webservice.lb_planner_api), slotId: slotId);
      log('Deleted slot with id $slotId');

      await captureEvent(
        'slot_deleted',
        properties: {
          'slotId': slotId,
        },
      );
    } catch (e, s) {
      log('Failed to delete slot with id $slotId', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Updates the given [slot].
  Future<void> updateSlot(Slot slot) async {
    if (!state.hasData) {
      log('Cannot update slot: No data');
      return;
    }

    final transaction = startTransaction('updateSlot');
    log('Updating slot with id ${slot.id}');

    try {
      final oldSlot = state.requireData.firstWhere((s) => s.id == slot.id);

      await _datasource.updateSlot(
        token: _auth.state.requireData.pick(Webservice.lb_planner_api),
        slot: slot,
      );
      log('Updated slot with id ${slot.id}');

      await captureEvent(
        'slot_updated',
        properties: {
          'weekday': slot.weekday,
          'size': slot.size,
          'start': slot.startUnit,
          'end': slot.endUnit,
        },
      );

      final supervisorDiff = calculateListDiff(oldSlot.supervisors, slot.supervisors, detectMoves: false);
      final mappingDiff = calculateListDiff(oldSlot.mappings, slot.mappings, detectMoves: false);

      for (final diff in supervisorDiff.getUpdatesWithData()) {
        await diff.when(
          insert: (index, data) async {
            log('New supervisor $data added to slot ${slot.id}');
            await addSlotSupervisor(slotId: slot.id, supervisorId: data);
          },
          remove: (index, data) async {
            log('Supervisor $data removed from slot ${slot.id}');
            await removeSlotSupervisor(slotId: slot.id, supervisorId: data);
          },
          change: (index, oldData, newData) async {
            log('Supervisor $oldData changed to $newData in slot ${slot.id}');

            await removeSlotSupervisor(slotId: slot.id, supervisorId: oldData);
            await addSlotSupervisor(slotId: slot.id, supervisorId: newData);
          },
          move: (from, to, data) {},
        );
      }

      for (final diff in mappingDiff.getUpdatesWithData()) {
        await diff.when(
          insert: (index, data) async {
            log('New mapping $data added to slot ${slot.id}');
            await addMapping(slotId: slot.id, mapping: data);
          },
          remove: (index, data) async {
            log('Mapping $data removed from slot ${slot.id}');
            await deleteMapping(slotId: slot.id, mappingId: data.id);
          },
          change: (index, oldData, newData) async {
            log('Mapping $oldData changed to $newData in slot ${slot.id}');
            await deleteMapping(slotId: slot.id, mappingId: oldData.id);
            await addMapping(slotId: slot.id, mapping: newData);
          },
          move: (from, to, data) {},
        );
      }

      await refresh(this);
    } catch (e, s) {
      log('Failed to update slot', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Adds a supervisor to the slot with the given [slotId].
  Future<void> addSlotSupervisor({required int slotId, required int supervisorId}) async {
    if (!state.hasData) {
      log('Cannot add supervisor: No data');
      return;
    }

    final transaction = startTransaction('addSlotSupervisor');
    log('Adding supervisor $supervisorId to slot $slotId');
    try {
      data(
        state.requireData.map((s) {
          if (s.id == slotId) {
            return s.copyWith(supervisors: [...s.supervisors, supervisorId]);
          }
          return s;
        }).toList(),
      );

      await _datasource.addSupervisor(
        token: _auth.state.requireData.pick(Webservice.lb_planner_api),
        slotId: slotId,
        supervisorId: supervisorId,
      );

      log('Added supervisor $supervisorId to slot $slotId');
    } catch (e, s) {
      log('Failed to add supervisor $supervisorId to slot $slotId', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Removes a supervisor from the slot with the given [slotId].
  Future<void> removeSlotSupervisor({required int slotId, required int supervisorId}) async {
    if (!state.hasData) {
      log('Cannot remove supervisor: No data');
      return;
    }

    final transaction = startTransaction('removeSlotSupervisor');
    log('Removing supervisor $supervisorId from slot $slotId');
    try {
      data(
        state.requireData.map((s) {
          if (s.id == slotId) {
            return s.copyWith(supervisors: s.supervisors.where((id) => id != supervisorId).toList());
          }
          return s;
        }).toList(),
      );

      await _datasource.removeSupervisor(
        token: _auth.state.requireData.pick(Webservice.lb_planner_api),
        slotId: slotId,
        supervisorId: supervisorId,
      );

      log('Removed supervisor $supervisorId from slot $slotId');
    } catch (e, s) {
      log('Failed to remove supervisor $supervisorId from slot $slotId', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Adds a mapping to the slot with the given [slotId].
  Future<void> addMapping({required int slotId, required CourseToSlot mapping}) async {
    if (!state.hasData) {
      log('Cannot add mapping: No data');
      return;
    }

    final transaction = startTransaction('addMapping');
    log('Adding mapping $mapping to slot $slotId');

    try {
      data(
        state.requireData.map((s) {
          if (s.id == slotId) {
            return s.copyWith(mappings: [...s.mappings, mapping]);
          }
          return s;
        }).toList(),
      );

      await _datasource.addSlotMapping(
        token: _auth.state.requireData.pick(Webservice.lb_planner_api),
        mapping: mapping,
      );

      log('Added mapping $mapping to slot $slotId');
    } catch (e, s) {
      log('Failed to add mapping $mapping to slot $slotId', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Deletes the mapping with the given [mappingId] from the slot with the given [slotId].
  Future<void> deleteMapping({required int slotId, required int mappingId}) async {
    if (!state.hasData) {
      log('Cannot delete mapping: No data');
      return;
    }

    final transaction = startTransaction('deleteMappings');
    log('Deleting mapping $mappingId from slot $slotId');

    try {
      data(
        state.requireData.map((s) {
          if (s.id == slotId) {
            return s.copyWith(mappings: s.mappings.where((m) => m.id != mappingId).toList());
          }
          return s;
        }).toList(),
      );

      await _datasource.deleteSlotMapping(
        token: _auth.state.requireData.pick(Webservice.lb_planner_api),
        mappingId: mappingId,
      );

      log('Deleted mapping $mappingId from slot $slotId');
    } catch (e, s) {
      log('Failed to delete mapping $mappingId from slot $slotId', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Groups all slots by their weekday.
  Map<Weekday, List<Slot>> group() {
    if (!state.hasData) {
      log('Cannot group slots: No data');
      return {};
    }

    return state.requireData.groupFoldBy(
      (s) => s.weekday,
      (g, s) => [...?g, s],
    );
  }

  @override
  void dispose() {
    _datasource.dispose();
    super.dispose();
  }
}

/// Adds a query method to the [Slot] iterable.
extension QueryX on Iterable<Slot> {
  /// Queries the slots for the given [query].
  List<Slot> query(String query) {
    return where((s) => s.room.containsIgnoreCase(query)).toList();
  }
}
