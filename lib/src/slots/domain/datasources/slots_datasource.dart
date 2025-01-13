import 'package:lb_planner/src/slots/slots.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Datasource mapping the slots endpoints.
abstract class SlotsDatasource extends Datasource {
  @override
  String get name => 'Slots';

  /// Fetches the slots the current user can theoretically reserve.
  Future<List<Slot>> getSlots(String token);

  /// Fetches all slots a supervisor can theoretically reserve for a student.
  Future<List<Slot>> getStudentSlots({required String token, required int studentId});

  /// Fetches all slots supervised by the current user.
  Future<List<Slot>> getSupervisedSlots(String tokrn);

  /// Reserves the slot with [slotId] on [date].
  ///
  /// If [studentId] is provided, the reservation will be made for the student with the given id.
  /// Note: User associated with [token] must be a supervisor of the slot.
  Future<Reservation> reserveSlot({required String token, required int slotId, required DateTime date, int? studentId});

  /// Cancels the reservation with [reservationId].
  ///
  /// If [force] is `false` the user made the reservation will be asked for confirmation. When `true` the reservation will be cancelled without confirmation.
  /// Note: User associated with [token] must be a supervisor of the slot.
  Future<void> cancelReservation({required String token, required int reservationId, bool force = false});

  /// Fetches all reservations for the slot with [slotId].
  ///
  /// Note: User associated with [token] must be a supervisor of the slot.
  Future<List<Reservation>> getSlotReservations({required String token, required int slotId});

  /// Fetches all reservations made by the current user.
  Future<List<Reservation>> getUserReservations(String token);

  /// Pushes a new [slot] to the server.
  Future<Slot> createSlot({required String token, required Slot slot});

  /// Deletes the slot with [slotId].
  Future<void> deleteSlot({required String token, required int slotId});

  /// Pushes an updated [slot] to the server.
  Future<void> updateSlot({required String token, required Slot slot});

  /// Adds [supervisorId] to the supervisors of the slot with [slotId].
  Future<void> addSupervisor({required String token, required int slotId, required int supervisorId});

  /// Pushes a new [mapping] to the server.
  Future<CourseToSlot> addSlotMapping({required String token, required CourseToSlot mapping});

  /// Deletes the mapping with [mappingId].
  Future<void> deleteSlotMapping({required String token, required int mappingId});

  /// Fetches all mappings for the slot with [slotId].
  Future<List<CourseToSlot>> getSlotMappings({required String token, required int slotId});
}
