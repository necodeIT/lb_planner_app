import 'dart:async';

import 'package:crypto/crypto.dart';
import 'package:echidna_flutter/echidna_flutter.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// User ID repository for the echidna package.
class EchidnaUserRepository extends UserIdRepository {
  final UserRepository _user;

  /// User ID repository for the echidna package.
  EchidnaUserRepository(this._user) {
    watchAsync(_user);
  }

  @override
  FutureOr<void> build(BuildTrigger trigger) async {
    if (trigger is! UserRepository) return;

    final transaction = startTransaction('loadEchidnaUser');

    try {
      final user = waitForData(_user);

      data(
        UserID(
          userId: sha256.convert(user.id.toString().codeUnits).toString(),
        ),
      );
    } catch (e) {
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }
}
