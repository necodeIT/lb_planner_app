import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:lb_planner/modules/theming/theming.dart';

abstract class ThemesDatasource extends Datasource {
  @override
  String get name => 'Themes';

  /// Returns a list of all themes available.
  List<ThemeBase> getThemes();

  /// The default theme to use.
  ThemeBase get defaultTheme;

  /// Returns the system theme (light or dark).
  ThemeBase systemTheme();
}
