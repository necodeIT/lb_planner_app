import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/src/slots/slots.dart';

/// Standard implementation of [SlotsDatasource].
class StdSlotsDatasource extends SlotsDatasource {
  /// The API service to use.
  final ApiService api;

  /// Standard implementation of [SlotsDatasource].
  StdSlotsDatasource(this.api);

  /// Whitelist of keys that are allowed to be sent to the server.
  static const slotKeyWhitelist = [
    'id',
    'weekday',
    'room',
    'startunit',
    'duration',
    'size',
  ];

  @override
  Future<CourseToSlot> addSlotMapping({required String token, required CourseToSlot mapping}) async {
    final transaction = startTransaction('addSlotMapping');
    log('Pushing slot mapping to server: $mapping');

    final json = mapping.toJson()..remove('id');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_add_slot_filter',
      body: json,
      token: token,
    );

    response.assertJson();

    await transaction.finish();

    return CourseToSlot.fromJson(response.asJson);
  }

  @override
  Future<void> addSupervisor({required String token, required int slotId, required int supervisorId}) async {
    final transaction = startTransaction('addSupervisor');
    log('Adding supervisor $supervisorId to slot $slotId');

    await api.callFunction(
      function: 'local_lbplanner_slots_add_slot_supervisor',
      body: {
        'slotid': slotId,
        'userid': supervisorId,
      },
      token: token,
    );
    await transaction.finish();
  }

  @override
  Future<void> removeSupervisor({required String token, required int slotId, required int supervisorId}) async {
    final transaction = startTransaction('removeSupervisor');
    log('Removing supervisor $supervisorId to slot $slotId');

    await api.callFunction(
      function: 'local_lbplanner_slots_remove_slot_supervisor',
      body: {'slotid': slotId, 'userid': supervisorId},
      token: token,
    );

    await transaction.finish();
  }

  @override
  Future<void> cancelReservation({required String token, required int reservationId, bool force = false}) async {
    final transaction = startTransaction('cancelReservation');
    log('Cancelling reservation $reservationId');

    await api.callFunction(
      function: 'local_lbplanner_slots_unbook_reservation',
      body: {
        'reservationid': reservationId,
        'nice': force,
      },
      token: token,
    );
    await transaction.finish();
  }

  @override
  Future<Slot> createSlot({required String token, required Slot slot}) async {
    final transaction = startTransaction('createSlot');
    log('Creating slot $slot');

    final json = slot.toJson()
      ..removeWhere((key, value) => !slotKeyWhitelist.contains(key))
      ..remove('id');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_create_slot',
      body: json,
      token: token,
    );

    response.assertJson();

    await transaction.finish();

    return Slot.fromJson(response.asJson);
  }

  @override
  Future<void> deleteSlot({required String token, required int slotId}) async {
    final transaction = startTransaction('deleteSlot');
    log('Deleting slot $slotId');

    await api.callFunction(
      function: 'local_lbplanner_slots_delete_slot',
      body: {
        'id': slotId,
      },
      token: token,
    );
    await transaction.finish();
  }

  @override
  Future<void> deleteSlotMapping({required String token, required int mappingId}) async {
    final transaction = startTransaction('deleteSlotMapping');
    log('Deleting slot mapping $mappingId');

    await api.callFunction(
      function: 'local_lbplanner_slots_delete_slot_filter',
      body: {
        'filterid': mappingId,
      },
      token: token,
    );
    await transaction.finish();
  }

  @override
  Future<List<Reservation>> getSlotReservations({required String token, required int slotId}) async {
    final transaction = startTransaction('getSlotReservations');
    log('Fetching reservations for slot $slotId');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_get_slot_reservations',
      body: {
        'slotid': slotId,
      },
      token: token,
    );

    response.assertList();

    await transaction.finish();

    return response.asList.map(Reservation.fromJson).toList();
  }

  @override
  Future<List<Slot>> getSlots(String token) async {
    final transaction = startTransaction('getSlots');
    log('Fetching slots');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_get_my_slots',
      token: token,
    );

    response.assertList();

    await transaction.finish();

    return response.asList.map(Slot.fromJson).toList();
  }

  @override
  Future<List<Slot>> getStudentSlots({required String token, required int studentId}) async {
    final transaction = startTransaction('getStudentSlots');
    log('Fetching student slots for student $studentId');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_get_student_slots',
      body: {
        'studentid': studentId,
      },
      token: token,
    );

    response.assertList();

    await transaction.finish();

    return response.asList.map(Slot.fromJson).toList();
  }

  @override
  Future<List<Slot>> getSupervisedSlots(String tokrn) async {
    final transaction = startTransaction('getSupervisedSlots');
    log('Fetching supervised slots');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_get_supervisor_slots',
      token: tokrn,
    );

    response.assertList();

    await transaction.finish();

    return response.asList.map(Slot.fromJson).toList();
  }

  @override
  Future<List<Reservation>> getUserReservations(String token) async {
    final transaction = startTransaction('getUserReservations');
    log('Fetching user reservations');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_get_my_reservations',
      token: token,
    );

    response.assertList();

    await transaction.finish();

    return response.asList.map(Reservation.fromJson).toList();
  }

  @override
  Future<Reservation> reserveSlot({required String token, required int slotId, required DateTime date, int? studentId}) async {
    final transaction = startTransaction('reserveSlot');
    log('Reserving slot $slotId on $date');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_book_reservation',
      body: {
        'slotid': slotId,
        'date': const ReservationDateTimeConverter().toJson(date),
        if (studentId != null) 'studentid': studentId,
      },
      token: token,
    );

    response.assertJson();

    await transaction.finish();

    return Reservation.fromJson(response.asJson);
  }

  @override
  Future<void> updateSlot({required String token, required Slot slot}) async {
    final transaction = startTransaction('updateSlot');
    log('Updating slot $slot');

    final json = slot.toJson()..removeWhere((key, value) => !slotKeyWhitelist.contains(key));

    await api.callFunction(
      function: 'local_lbplanner_slots_update_slot',
      body: json,
      token: token,
    );

    await transaction.finish();
  }

  @override
  Future<List<Slot>> getAllSlots(String token) async {
    final transaction = startTransaction('getAllSlots');
    log('Getting all slots');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_get_all_slots',
      token: token,
    );

    await transaction.finish();

    return response.asList.map(Slot.fromJson).toList();
  }
}
