import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';

/// A CourseSelector dialog for mobile.
class CourseSelectorDialog extends StatelessWidget {
  /// A CourseSelector dialog for mobile.
  const CourseSelectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: SafeArea(
        child: Padding(
          padding: PaddingAll(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Row(
                  children: [
                    const Icon(Icons.chevron_left),
                    Text(
                      context.t.moodle_courseSelectionScreen_selectCourses,
                      style: context.textTheme.titleMedium?.bold,
                    ).alignAtTopLeft(),
                  ],
                ),
              ),
              Spacing.small(),
              const Expanded(child: CourseSelector()),
            ],
          ),
        ),
      ),
    );
  }
}
