import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lb_planner/modules/theming/theming.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(debugLogHandler);

  setUp(() {
    Modular.init(ThemingModule());
  });

  tearDown(() {
    Modular.destroy();
  });

  // Your unit tests here.
}
