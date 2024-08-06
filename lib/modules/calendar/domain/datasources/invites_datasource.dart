import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Data source for managing [PlanInvite]s.
abstract class InvitesDatasource extends Datasource {
  @override
  String get name => 'Invites';

  /// Fetches all invites for the user associated with the given [token].
  Future<List<PlanInvite>> getInvites(String token);

  /// Accepts the invite with the given [id].
  Future<void> acceptInvite(String token, int id);

  /// Declines the invite with the given [id].
  Future<void> declineInvite(String token, int id);

  /// Invites the user with the given [userId] to the plan of the user associated with the given [token].
  Future<PlanInvite> inviteUser(String token, int userId);
}
