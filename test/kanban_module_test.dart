import 'defaults.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eduplanner/src/kanban/kanban.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;

  setUp(() {
    Modular.init(KanbanModule());
  });

  tearDown(() {
    Modular.destroy();
  });

  // Your unit tests here.
}
