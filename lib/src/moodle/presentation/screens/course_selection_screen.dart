import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:lb_planner/lb_planner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CourseSelectionScreen extends StatelessWidget {
  const CourseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            child: SizedBox(
              height: context.height,
              child: Assets.moodle.courseSelection.themed(
                context,
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: Text(
              'Select courses',
              style: context.textTheme.titleLarge,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 150),
              child: SizedBox(
                width: context.width * 0.4,
                height: context.height * 0.8,
                child: Column(
                  children: [
                    const CourseSelector().expanded(),
                    Spacing.mediumVertical(),
                    ElevatedButton(
                      onPressed: () => Modular.to.pushNamed('/dashboard/'),
                      child: Text('Continue'),
                    ).stretch(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
