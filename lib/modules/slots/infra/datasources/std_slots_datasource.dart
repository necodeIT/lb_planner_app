import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/slots/slots.dart';

/// Standard implementation of [SlotsDatasource].
class StdSlotsDatasource extends SlotsDatasource {
  @override
  void dispose() {}

  /// The API service to use.
  final ApiService api;

  /// Standard implementation of [SlotsDatasource].
  StdSlotsDatasource(this.api);

  @override
  Future<CourseToSlot> addSlotMapping({required String token, required CourseToSlot mapping}) async {
    log('Pushing slot mapping to server: $mapping');

    final json = mapping.toJson()..remove('id');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_add_slot_filter',
      body: json,
      token: token,
    );

    response.assertJson();

    return CourseToSlot.fromJson(response.asJson);
  }

  @override
  Future<void> addSupervisor({required String token, required int slotId, required int supervisorId}) async {
    log('Adding supervisor $supervisorId to slot $slotId');

    await api.callFunction(
      function: 'local_lbplanner_slots_add_slot_supervisor',
      body: {
        'slotid': slotId,
        'userid': supervisorId,
      },
      token: token,
    );
  }

  @override
  Future<void> cancelReservation({required String token, required int reservationId, bool force = false}) async {
    log('Cancelling reservation $reservationId');

    await api.callFunction(
      function: 'local_lbplanner_slots_unbook_reservation',
      body: {
        'reservationid': reservationId,
        'nice': force,
      },
      token: token,
    );
  }

  @override
  Future<Slot> createSlot({required String token, required Slot slot}) async {
    log('Creating slot $slot');

    final json = slot.toJson()
      ..remove('id')
      ..remove('');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_create_slot',
      body: json,
      token: token,
    );

    response.assertJson();

    return Slot.fromJson(response.asJson);
  }

  @override
  Future<void> deleteSlot({required String token, required int slotId}) async {
    log('Deleting slot $slotId');

    await api.callFunction(
      function: 'local_lbplanner_slots_delete_slot',
      body: {
        'slotid': slotId,
      },
      token: token,
    );
  }

  @override
  Future<void> deleteSlotMapping({required String token, required int mappingId}) async {
    log('Deleting slot mapping $mappingId');

    await api.callFunction(
      function: 'local_lbplanner_slots_delete_slot_filter',
      body: {
        'filterid': mappingId,
      },
      token: token,
    );
  }

  @override
  Future<List<CourseToSlot>> getSlotMappings({required String token, required int slotId}) async {
    log('Fetching slot mappings for slot $slotId');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_get_slot_filters',
      body: {
        'slotid': slotId,
      },
      token: token,
    );

    response.assertJson();

    return response.asList.map(CourseToSlot.fromJson).toList();
  }

  @override
  Future<List<Reservation>> getSlotReservations({required String token, required int slotId}) async {
    log('Fetching reservations for slot $slotId');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_get_slot_reservations',
      body: {
        'slotid': slotId,
      },
      token: token,
    );

    response.assertJson();

    return response.asList.map(Reservation.fromJson).toList();
  }

  @override
  Future<List<Slot>> getSlots(String token) async {
    log('Fetching slots');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_get_my_slots',
      token: token,
    );

    response.assertJson();

    return response.asList.map(Slot.fromJson).toList();
  }

  @override
  Future<List<Slot>> getStudentSlots({required String token, required int studentId}) async {
    log('Fetching student slots for student $studentId');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_get_student_slots',
      body: {
        'studentid': studentId,
      },
      token: token,
    );

    response.assertJson();

    return response.asList.map(Slot.fromJson).toList();
  }

  @override
  Future<List<Slot>> getSupervisedSlots(String tokrn) async {
    log('Fetching supervised slots');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_get_supervisor_slots',
      token: tokrn,
    );

    response.assertJson();

    return response.asList.map(Slot.fromJson).toList();
  }

  @override
  Future<List<Reservation>> getUserReservations(String token) async {
    log('Fetching user reservations');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_get_my_reservations',
      token: token,
    );

    response.assertJson();

    return response.asList.map(Reservation.fromJson).toList();
  }

  @override
  Future<Reservation> reserveSlot({required String token, required int slotId, required DateTime date, int? studentId}) async {
    log('Reserving slot $slotId on $date');

    final response = await api.callFunction(
      function: 'local_lbplanner_slots_book_slot',
      body: {
        'slotid': slotId,
        'date': const ReservationDateTimeConverter().toJson(date),
        if (studentId != null) 'studentid': studentId,
      },
      token: token,
    );

    response.assertJson();

    return Reservation.fromJson(response.asJson);
  }

  @override
  Future<void> updateSlot({required String token, required Slot slot}) async {
    log('Updating slot $slot');

    final json = slot.toJson();

    await api.callFunction(
      function: 'local_lbplanner_slots_update_slot',
      body: json,
      token: token,
    );
  }
}
