/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsAuthGen {
  const $AssetsAuthGen();

  /// File path: assets/auth/background.svg
  SvgGenImage get background => const SvgGenImage('assets/auth/background.svg');

  /// List of all assets
  List<SvgGenImage> get values => [background];
}

class $AssetsDashboardGen {
  const $AssetsDashboardGen();

  /// File path: assets/dashboard/no-exams.svg
  SvgGenImage get noExams => const SvgGenImage('assets/dashboard/no-exams.svg');

  /// File path: assets/dashboard/no-overdue-tasks.svg
  SvgGenImage get noOverdueTasks =>
      const SvgGenImage('assets/dashboard/no-overdue-tasks.svg');

  /// File path: assets/dashboard/no-reservations-for-today.svg
  SvgGenImage get noReservationsForToday =>
      const SvgGenImage('assets/dashboard/no-reservations-for-today.svg');

  /// File path: assets/dashboard/nothing-planned-for-today.svg
  SvgGenImage get nothingPlannedForToday =>
      const SvgGenImage('assets/dashboard/nothing-planned-for-today.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [noExams, noOverdueTasks, noReservationsForToday, nothingPlannedForToday];
}

class $AssetsMoodleGen {
  const $AssetsMoodleGen();

  /// File path: assets/moodle/course-selection.svg
  SvgGenImage get courseSelection =>
      const SvgGenImage('assets/moodle/course-selection.svg');

  /// List of all assets
  List<SvgGenImage> get values => [courseSelection];
}

class Assets {
  Assets._();

  static const SvgGenImage a404 = SvgGenImage('assets/404.svg');
  static const $AssetsAuthGen auth = $AssetsAuthGen();
  static const $AssetsDashboardGen dashboard = $AssetsDashboardGen();
  static const SvgGenImage logo = SvgGenImage('assets/logo.svg');
  static const $AssetsMoodleGen moodle = $AssetsMoodleGen();
  static const SvgGenImage noResults = SvgGenImage('assets/no-results.svg');

  /// List of all assets
  static List<SvgGenImage> get values => [a404, logo, noResults];
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
