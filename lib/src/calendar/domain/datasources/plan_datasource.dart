import 'package:lb_planner/src/calendar/calendar.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Data source for managing a user's [CalendarPlan].
abstract class PlanDatasource extends Datasource {
  @override
  String get name => 'Plan';

  /// Fetches the plan for the user associated with the given [token].
  Future<CalendarPlan> getPlan(String token);

  /// Updates the plan for the user associated with the given [token] and returns the updated plan confirmed by the server.
  Future<void> updatePlan(String token, CalendarPlan plan);

  /// Leaves a shared plan of the user associated with the given [token].
  Future<void> leavePlan(String token);

  /// Removes the member with the given [userId] from the plan of the user associated with the given [token].
  Future<void> removeMember(String token, int userId);

  /// Modifies the access type of the member with the given [userId] in the plan of the user associated with the given [token].
  Future<void> chmod(String token, int userId, PlanMemberAccessType accessType);
}
