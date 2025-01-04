import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lb_planner/modules/dashboard/dashboard.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;
  // Logger.root.onRecord.listen(debugLogHandler);

  setUp(() {
    Modular.init(DashboardModule());
  });

  tearDown(() {
    Modular.destroy();
  });

  // Your unit tests here.
}
