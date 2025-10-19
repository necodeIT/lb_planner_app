import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:flutter/material.dart';

/// A widget that displays an image with a message below.
class ImageMessage extends StatelessWidget {
  /// A widget that displays an image with a message below.
  const ImageMessage({super.key, required this.message, required this.image});

  /// The message to display.
  final String message;

  /// The image to display.
  final SvgGenImage image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            image.themed(context).expanded(),
            Spacing.mediumVertical(),
            Text(
              message,
              style: context.theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
