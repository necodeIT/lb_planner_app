import 'package:eduplanner/src/settings/settings.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;
  // Logger.root.onRecord.listen(debugLogHandler);

  setUp(() {
    Modular.init(SettingsModule());
  });

  tearDown(() {
    Modular.destroy();
  });

  // Your unit tests here.
}
