import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Data source for managing [PlanDeadline]s.
///
/// For retrieving all deadlines, see [PlanDatasource] as deadlines are part of the [CalendarPlan] object.
abstract class DeadlinesDatasource extends Datasource {
  @override
  String get name => 'Deadlines';

  /// Clears all deadlines in the plan of the user associated with the given [token].
  Future<void> clearDeadlines(String token);

  /// Removes the deadline with the given [id] from the plan of the user associated with the given [token].
  Future<void> removeDeadline(String token, int id);

  /// Sets the given [deadline] in the plan of the user associated with the given [token].
  ///
  /// If a deadline with the same ID already exists, it will be replaced.
  Future<void> setDeadline(String token, PlanDeadline deadline);
}
