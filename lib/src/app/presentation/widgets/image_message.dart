import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:lb_planner/src/app/app.dart';

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
    return Column(
      children: [
        image.themed(context).expanded(),
        Spacing.mediumVertical(),
        Text(
          message,
          style: context.theme.textTheme.titleMedium,
        ),
      ],
    );
  }
}
