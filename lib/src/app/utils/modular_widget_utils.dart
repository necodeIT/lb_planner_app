import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_widget/flutter_modular_widget.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:skeletonizer/skeletonizer.dart';

R _get<R extends Repository<dynamic>>() => Modular.get<R>();

mixin CircularLoaderBuilder<T> on ModularWidget<T> {
  @override
  Widget buildLoader(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

mixin SkeletonLoaderBuilder<T> on ModularWidget<T> {
  @override
  Widget buildLoader(BuildContext context) {
    return Skeletonizer(
      child: IgnorePointer(
        child: buildContent(context, skeletonData, _get),
      ),
    );
  }

  T get skeletonData;
}

mixin GenericErrorBuilder<T> on ModularWidget<T> {
  @override
  Widget buildError(BuildContext context, Object error, StackTrace? stackTrace) {
    final message = getErrorMessage(context, error);

    return ImageMessage(
      message: message,
      image: Assets.genericError,
    );
  }

  String getErrorMessage(BuildContext context, Object error) {
    return 'Oops! An error occurred.\nThe error has been reported to our team and we will look into it shortly.';
  }
}
