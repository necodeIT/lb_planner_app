import 'package:lb_planner/modules/theming/theming.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// A service that generates a theme of type [Theme] based on a [ThemeBase].
abstract class ThemeGeneratorService<Theme> extends Service {
  @override
  String get name => 'ThemeGenerator';

  /// Generates a theme based on the provided [themeBase].
  Theme generateTheme(ThemeBase themeBase);
}
