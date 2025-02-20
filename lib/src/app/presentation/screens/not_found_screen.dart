import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Displays a 404 error message.
class NotFoundScreen extends StatelessWidget {
  /// Displays a 404 error message.
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            ImageMessage(
              message: context.t.notFound,
              image: Assets.a404,
            ).expanded(),
            Spacing.mediumVertical(),
            ElevatedButton(
              onPressed: () {
                Modular.to.navigate('/dashboard/');
              },
              child: Text(context.t.notFound_returnHome),
            ),
          ],
        ),
      ),
    );
  }
}
